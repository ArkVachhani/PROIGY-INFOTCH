import 'package:task_1/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double firstnum = 0.0;
  double secondnum = 0.0;
  var input = '';
  var output = '';
  var operation = '';

  onButtonClick(value) {
    //if value is AC
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "<-") {
      input = input.substring(0, input.length - 1);
    } else if (value == "=") {
      var userInput = input;
      userInput = input.replaceAll('x', '*');

      Parser p = Parser();
      Expression expression = p.parse(userInput);
      ContextModel cm = ContextModel();
      var finalValue = expression.evaluate(EvaluationType.REAL, cm);
      output = finalValue.toString();
    } else {
      input = input + value;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orangeColor,
        title: Text('Calculator App',
            style: TextStyle(fontWeight: FontWeight.w500)),
      ),
      backgroundColor: Color.fromARGB(255, 83, 68, 68),
      body: Column(
        children: [
          Expanded(
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        input,
                        style: TextStyle(
                          fontSize: 48,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        output,
                        style: TextStyle(
                          fontSize: 34,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ))),
          //buttons area
          Row(
            children: [
              button(text: "AC", tColor: orangeColor),
              button(text: "<-", tColor: orangeColor),
              button(text: "+/-", tColor: orangeColor),
              button(text: "÷", tColor: orangeColor),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(text: "x", tColor: orangeColor),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(text: "-", tColor: orangeColor),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(text: "+", tColor: orangeColor),
            ],
          ),
          Row(
            children: [
              button(text: "%", tColor: orangeColor),
              button(text: "0"),
              button(text: "."),
              button(text: "=", tColor: orangeColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text, tColor = Colors.white, buttonBgColor = buttonColor}) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(22),
          backgroundColor: buttonColor,
        ),
        onPressed: () => onButtonClick(text),
        child: Text(text,
            style: TextStyle(
              fontSize: 18,
              color: tColor,
              fontWeight: FontWeight.bold,
            )),
      ),
    ));
  }
}
