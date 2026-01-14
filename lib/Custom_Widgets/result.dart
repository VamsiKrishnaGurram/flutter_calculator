import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Text("result"),
      );
  }
}