import 'package:flutter/material.dart';
import 'package:responsi_meal/Pages/listpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> categoryList = [];
  List<dynamic> filteredCategoryList = [];

  Future<void> fetchCategoryData() async {
    final response = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/categories.php"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        categoryList = data['categories'];
        filteredCategoryList = categoryList;
      });
    }
  }

  @override
  void initState() {
    fetchCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Category'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: filteredCategoryList.length,
        itemBuilder: (context, index) {
          final category = filteredCategoryList[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: Colors.grey[200]!, width: 1.0),
            ),
            leading: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                child: Image.network(
                  category['strCategoryThumb'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              category['strCategory'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
            onTap: () {
              // Handle category item tap
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListPage(meal: category),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
