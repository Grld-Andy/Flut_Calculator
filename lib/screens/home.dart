import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            GridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              shrinkWrap: true,
              children: [
                TextButton(
                  onPressed: (){},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[600],
                  ),
                  child: const Text(
                    "+"
                  )
                ),
                TextButton(
                  onPressed: (){},
                  child: const Text("+")
                ),
                TextButton(
                  onPressed: (){},
                  child: const Text("+")
                ),
                TextButton(
                  onPressed: (){},
                  child: const Text("+")
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}