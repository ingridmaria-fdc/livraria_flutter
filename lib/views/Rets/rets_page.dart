import 'package:flutter/material.dart';

class RetsPage extends StatefulWidget {
  RetsPage({Key? key}) : super(key: key);

  @override
  _RetsPageState createState() => _RetsPageState();
}

class _RetsPageState extends State<RetsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aluguéis'),
        backgroundColor: Colors.blue[700],
      ),
    );
  }
}
