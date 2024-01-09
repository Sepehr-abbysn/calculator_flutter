import 'package:flutter/material.dart';
import 'package:flutter_calc/constants.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApplication());
}

class MyApplication extends StatefulWidget {
  const MyApplication({Key? key}) : super(key: key);

  @override
  State<MyApplication> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  var inputUser = "";
  var result = "";

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor(text1),
            shape: CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
          ),
          onPressed: () {
            if (text1 == "AC") {
              setState(() {
                inputUser = "";
                result = "";
              });
            } else {
              buttonPressed(text1);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text1,
              style: TextStyle(
                fontSize: 33,
                color: textColor(text1),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor(text2),
            shape: CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
          ),
          onPressed: () {
            if (text2 == "CE") {
              setState(() {
                if (inputUser.length > 0) {
                  inputUser = inputUser.substring(0, inputUser.length - 1);
                }
              });
            } else {
              buttonPressed(text2);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text2,
              style: TextStyle(
                fontSize: 33,
                color: textColor(text2),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor(text3),
            shape: CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
          ),
          onPressed: () {
            buttonPressed(text3);
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text3,
              style: TextStyle(
                fontSize: 33,
                color: textColor(text3),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor(text4),
            shape: CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
          ),
          onPressed: () {
            if (text4 == "=") {
              Parser parser = Parser();
              Expression expression = parser.parse(inputUser);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);

              setState(() {
                result = eval.toString();
              });
            } else {
              buttonPressed(text4);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(3),

            child: Text(
              text4,
              style: TextStyle(
                fontSize: 33,
                color: textColor(text4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void buttonPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  bool isOperator(String text) {
    var list = ["/", "AC", "CE", "%", "*", "-", "+", "="];
    for (var element in list) {
      if (element == text) {
        return true;
      }
    }
    return false;
  }

  Color backgroundColor(String text) {
    if (isOperator(text)) {
      return backgroundGreyDark;
    } else {
      return backgroundGrey;
    }
  }

  Color textColor(String text) {
    if (isOperator(text)) {
      return textGreen;
    } else {
      return textGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: backgroundGreyDark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          inputUser,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: textGreen,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          result,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: textGrey,
                            fontSize: 62,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  color: backgroundGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      getRow("AC", "CE", "%", "/"),
                      getRow("7", "8", "9", "*"),
                      getRow("4", "5", "6", "-"),
                      getRow("1", "2", "3", "+"),
                      getRow("00", "0", ".", "="),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
