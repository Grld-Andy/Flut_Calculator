import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> buttons = [
      "<", "%", "()", "÷",
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
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "he",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20
                      ),
                    ),
                    Text(
                      "hdafe",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30
                      ),
                    ),
                  ],
                ),
              )
            ),
            SizedBox(height: 10,),
            // buttons grid
            Expanded(
              flex: 5,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10
                ),
                itemCount: buttons.length,
                itemBuilder: (context, index){
                  final buttonText = buttons[index];
                  bool isOperator = ["+", "-", "*", "÷", "=", "()", "%", "<"].contains(buttonText);
                  return TextButton(
                    onPressed: (){},
                    style: TextButton.styleFrom(
                      backgroundColor: isOperator ? Colors.blue[900] : 
                        buttonText == "C" ? Colors.red[700] : Colors.grey[800],
                    ),
                    child: Text(
                      buttonText,
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