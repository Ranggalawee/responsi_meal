import 'package:flutter/material.dart';
import 'package:responsi_meal/Pages/detailpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListPage extends StatefulWidget {
  final dynamic meal;
  const ListPage({Key? key, required this.meal}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<dynamic> mealList = [];
  List<dynamic> filteredMealList = [];

  Future<void> fetchMealData() async {
    final response = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/filter.php?c=${widget.meal['strCategory']}"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        mealList = data['meals'];
        filteredMealList = mealList;
      });
    }
  }

  @override
  void initState() {
    fetchMealData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.meal['strCategory']} Meal"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: filteredMealList.length,
        itemBuilder: (context, index) {
          final meal = filteredMealList[index];
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
                  meal['strMealThumb'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              meal['strMeal'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
            onTap: () {
              // Handle meal item tap
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(detail: meal),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
