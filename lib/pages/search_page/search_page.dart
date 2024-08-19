import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/category_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // Initialize the TextEditingController
  TextEditingController searchController = TextEditingController();
  CategoryController categoryController = Get.put(CategoryController());

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed to free up resources
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag:
          "searchbar", // Ensure this tag is consistent with the widget you are transitioning from
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search'), // Optionally add a title to the AppBar
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Add padding for better UI
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center the column vertically
              children: [
                Container(
                  height: 50,
                  width: double.infinity, // Use full width of the screen
                  child: TextFormField(
                    controller:
                        searchController, // Connect the TextEditingController
                    decoration: InputDecoration(
                      hintText: 'Search...', // Add a hint text
                      border:
                          OutlineInputBorder(), // Add a border for the TextFormField
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
