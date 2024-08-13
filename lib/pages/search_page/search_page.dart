import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Hero(
              tag: "searchbar",
              child: Container(
                height: 50,
                width: double.infinity,
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
