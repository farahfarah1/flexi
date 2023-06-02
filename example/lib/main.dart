import 'package:flexiges/flexiges.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flexi Widget Demo'),
      ),
      body: Center(
        child: FlexiGes(
            child: Container(
          width: 200,
          height: 200,
          color: Colors.blue,
        )),
      ),
    );
  }
}
