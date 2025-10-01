import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  String calculation = "";
  String result = "0";

  final List<String> buttons = [
    "<", "%", "()", "÷",
    "7", "8", "9", "*",
    "4", "5", "6", "-",
    "1", "2", "3", "+",
    "C", "0", ".", "="
  ];

  void takeInput(String val) {
    setState(() {
      switch (val) {
        case "C":
          calculation = "";
          result = "0";
          break;
        case "<":
          if (calculation.isNotEmpty) {
            calculation = calculation.substring(0, calculation.length - 1);
          }
          break;
        case "=":
          if (calculation.isEmpty) return;
          try {
            // Replace special operators for FunctionTree
            String expression = calculation.replaceAll('÷', '/');
            final eval = expression.interpret();
            result = eval.toString();
          } catch (e) {
            result = "Error";
          }
          break;
        case "()":
          // Auto-detect whether to insert '(' or ')'
          int openParens = '('.allMatches(calculation).length;
          int closeParens = ')'.allMatches(calculation).length;
          calculation += openParens == closeParens ? '(' : ')';
          break;
        default:
          calculation += val;
      }
    });
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
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[800],
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
                      result,
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
                  bool isOperator = ["+", "-", "*", "÷", "%", "=", "()", ".", "C", "<"].contains(buttonText);
                  if(buttonText == "<"){
                    return IconButton(
                      onPressed: (){
                        takeInput(buttonText);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue[900] 
                      ),
                      icon: const Icon(
                        Icons.backspace,
                        color: Colors.white,
                      ),
                    );
                  }else{
                    return TextButton(
                      onPressed: (){
                        takeInput(buttonText);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: buttonText == "C" ? Colors.red[700] :
                          isOperator ? Colors.blue[900] : 
                          Colors.grey[800],
                      ),
                      child: Text(
                        buttonText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25
                        ),
                      ),
                    );
                  }
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}