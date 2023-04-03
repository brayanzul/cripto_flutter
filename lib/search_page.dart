import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {

    // final List<Country> countries = [

    // ];

    return Scaffold(
    //   appBar: AppBar(
    //     automaticallyImplyLeading: false,
    //     title: ListTile(
    //       onTap: (){

    //       },
    //       title: const Text(
    //         'search',
    //         style: TextStyle(
    //           color: Colors.white,
    //         ),
    //       ),
    //     ),
    //   ),

      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Cryto Flutter',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Bitcoin",
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: Colors.black
              ),
            )
          ],
        ),
      ),
    );
  }
}
