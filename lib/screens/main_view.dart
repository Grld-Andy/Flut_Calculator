import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> buttons = [
      "%", "(", ")", "÷",
      "7", "8", "9", "*",
      "6", "5", "4", "-",
      "3", "2", "1", "+",
      "C", "0", ".", "="
    ];

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // display screen
              Column(
                children: [
                  Text("5 + 3"),
                  Text("8")
                ],
              ),
        
            // buttons grid
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10
                ),
                itemCount: buttons.length,
                itemBuilder: (context, index){
                  return TextButton(
                    onPressed: (){},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                    ),
                    child: Text(
                      buttons[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),
                    ),
                  );
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}