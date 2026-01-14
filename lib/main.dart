import 'package:flutter/material.dart';
import 'package:hello_world/Custom_Widgets/resultsreen.dart';
import 'package:hello_world/Custom_Widgets/calculator.dart';


void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Calcia"),
          backgroundColor: Colors.redAccent,
          centerTitle: false,
          // leading: CircleAvatar(child: Text("W")),
        ),
        body: Container(
          decoration: BoxDecoration(),
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(child: ResultScreen(expression: "", result: 0.0)),

              Expanded(child: Calculator()),
            ],
          ),
        ),
      ),
    );
  }
}
