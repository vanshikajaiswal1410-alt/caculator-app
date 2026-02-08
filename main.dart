import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '', result = '';

  void onPressed(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        result = '';
      } else if (value == '=') {
        try {
          Expression exp = Parser().parse(input.replaceAll('×', '*').replaceAll('÷', '/'));
          result = exp.evaluate(EvaluationType.REAL, ContextModel()).toString();
        } catch (_) {
          result = 'Error';
        }
      } else {
        input += value;
      }
    });
  }

  Widget btn(String text) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: ElevatedButton(
            onPressed: () => onPressed(text),
            child: Text(text, style: const TextStyle(fontSize: 24)),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(input, style: const TextStyle(fontSize: 32)),
                  const SizedBox(height: 10),
                  Text(result, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          ...[
            ['7', '8', '9', '÷'],
            ['4', '5', '6', '×'],
            ['1', '2', '3', '-'],
            ['0', 'C', '=', '+'],
          ].map((row) => Row(children: row.map(btn).toList()))
        ],
      ),
    );
  }
}