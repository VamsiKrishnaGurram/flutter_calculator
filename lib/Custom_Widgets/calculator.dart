import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String expression = "";
  double result = 0.0;

  // ================= EVALUATOR =================
  double evaluateExpression(String expr) {
    if (expr.isEmpty) return 0;

    List<String> tokens = [];
    String current = "";

    for (int i = 0; i < expr.length; i++) {
      String ch = expr[i];
      if ("+-*/".contains(ch)) {
        tokens.add(current);
        tokens.add(ch);
        current = "";
      } else {
        current += ch;
      }
    }
    tokens.add(current);

    // Handle * and /
    for (int i = 0; i < tokens.length; i++) {
      if (tokens[i] == "*" || tokens[i] == "/") {
        double left = double.parse(tokens[i - 1]);
        double right = double.parse(tokens[i + 1]);
        double res = tokens[i] == "*" ? left * right : left / right;

        tokens[i - 1] = res.toString();
        tokens.removeAt(i);
        tokens.removeAt(i);
        i--;
      }
    }

    // Handle + and -
    double res = double.parse(tokens[0]);
    for (int i = 1; i < tokens.length; i += 2) {
      double num = double.parse(tokens[i + 1]);
      if (tokens[i] == "+") res += num;
      if (tokens[i] == "-") res -= num;
    }

    return res;
  }

  // ================= HELPERS =================
  void add(String value) {
    setState(() {
      expression += value;
    });
  }

  void clear() {
    setState(() {
      expression = "";
      result = 0.0;
    });
  }

  void backspace() {
    setState(() {
      if (expression.isNotEmpty) {
        expression = expression.substring(0, expression.length - 1);
      }
    });
  }

  void calculate() {
    setState(() {
      result = evaluateExpression(expression);
    });
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ===== DISPLAY =====
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.bottomRight,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  expression,
                  style: const TextStyle(fontSize: 28),
                ),
                const SizedBox(height: 8),
                Text(
                  result == 0 ? "" : result.toString(),
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const Divider(),

          // ===== BUTTONS =====
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildRow(["+", "-", "*", "/", "="]),
                const SizedBox(height: 12),
                buildRow(["7", "8", "9"]),
                const SizedBox(height: 12),
                buildRow(["4", "5", "6"]),
                const SizedBox(height: 12),
                buildRow(["1", "2", "3"]),
                const SizedBox(height: 12),
                buildRow(["AC", "<--"]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= BUTTON ROW =================
  Widget buildRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buttons.map((text) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ElevatedButton(
            onPressed: () {
              if (text == "AC") {
                clear();
              } else if (text == "<--") {
                backspace();
              } else if (text == "=") {
                calculate();
              } else {
                add(text);
              }
            },
            child: Text(
              text,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        );
      }).toList(),
    );
  }
}
