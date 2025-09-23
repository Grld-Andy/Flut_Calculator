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
      body: Column(
        children: [
          GridView.count(
            crossAxisCount: 4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              TextButton(
                onPressed: (){},
                child: Text("+")
              ),
              TextButton(
                onPressed: (){},
                child: Text("+")
              ),
              TextButton(
                onPressed: (){},
                child: Text("+")
              ),
              TextButton(
                onPressed: (){},
                child: Text("+")
              ),
            ],
          ),
        ],
      )
    );
  }
}