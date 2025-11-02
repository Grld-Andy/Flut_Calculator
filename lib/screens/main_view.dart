import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  String calculation = "";
  num result = 0;

  final List<String> buttons = [
    "<", "%", "()", "÷",
    "7", "8", "9", "*",
    "6", "5", "4", "-",
    "3", "2", "1", "+",
    "C", "0", ".", "="
  ];

  void takeInput(String val){
    if(val == "C"){
      setState((){
        calculation = "";
        result = 0;
      });
    }else if(val == "<"){
      setState(() {
        calculation = calculation.substring(0, calculation.length - 1);
      });
    }else if(val == "="){
      setState(() {
        if(calculation.isEmpty) {
          result = 0;
        }else{
          result = calculation.interpret();
        }
      });
    }else{
      setState(() {
        calculation += val;
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {

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
                      calculation,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20
                      ),
                    ),
                    Text(
                      "$result",
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
                  bool isOperator = ["+", "-", "*", "÷", "=", "()", "%", "<", "."].contains(buttonText);
                  return TextButton(
                    onPressed: (){
                      takeInput(buttonText);
                    },
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