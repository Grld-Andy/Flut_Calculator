import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  TextEditingController calculationController = TextEditingController();
  String result = "0";

  final List<String> buttons = [
    "<", "%", "()", "÷",
    "7", "8", "9", "*",
    "4", "5", "6", "-",
    "1", "2", "3", "+",
    "C", "0", ".", "="
  ];

  void takeInput(String val) {
    String calculation = calculationController.text;
    int cursorPos = calculationController.selection.base.offset;
    cursorPos = cursorPos < 0 ? calculation.length : cursorPos;

    setState(() {
      switch (val) {
        case "C":
          calculationController.text = "";
          result = "0";
          break;
        case "<":
          if (calculation.isNotEmpty && cursorPos > 0) {
            calculationController.text =
                calculation.substring(0, cursorPos - 1) +
                    calculation.substring(cursorPos);
            calculationController.selection =
                TextSelection.fromPosition(TextPosition(offset: cursorPos - 1));
          }
          break;
        case "=":
          if (calculation.isEmpty) return;
          try {
            String expression = calculation.replaceAll('÷', '/');
            final eval = expression.interpret();
            result = eval.toString();
          } catch (e) {
            print("error $e");
            result = "Error";
          }
          break;
        case "()":
          int openParens = '('.allMatches(calculation).length;
          int closeParens = ')'.allMatches(calculation).length;
          String parenToInsert = openParens == closeParens ? '(' : ')';
          calculationController.text =
              calculation.substring(0, cursorPos) +
                  parenToInsert +
                  calculation.substring(cursorPos);
          calculationController.selection = TextSelection.fromPosition(
              TextPosition(offset: cursorPos + 1));
          break;
        default:
          calculationController.text =
              calculation.substring(0, cursorPos) +
                  val +
                  calculation.substring(cursorPos);
          calculationController.selection = TextSelection.fromPosition(
              TextPosition(offset: cursorPos + val.length));
      }
    });
  }

  Widget buildButton(String text) {
    bool isOperator = [
      "+", "-", "*", "÷", "%", "=", "()", ".", "C", "<"
    ].contains(text);

    Color baseColor = isOperator
        ? Colors.blue[700]!
        : Colors.grey[800]!;
    if (text == "C") baseColor = Colors.red[700]!;
    if (text == "<") baseColor = Colors.orange[700]!;

    return GestureDetector(
      onTap: () => takeInput(text),
      child: Listener(
        onPointerDown: (_) => setState(() {}),
        onPointerUp: (_) => setState(() {}),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(4, 4),
                blurRadius: 6,
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                offset: const Offset(-2, -2),
                blurRadius: 6,
              ),
            ],
          ),
          child: Center(
            child: text == "<"
                ? const Icon(Icons.backspace, color: Colors.white, size: 28)
                : Text(
                    text,
                    style: const TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // Display screen
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      controller: calculationController,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 36),
                      textAlign: TextAlign.right,
                      cursorColor: Colors.blueAccent,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '0',
                        hintStyle: TextStyle(color: Colors.white38),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      result,
                      style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 28,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Buttons grid
              Expanded(
                child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    return buildButton(buttons[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
