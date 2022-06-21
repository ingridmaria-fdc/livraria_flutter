// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WDA Livraria'),         
        backgroundColor: Colors.blue[700],
        
      ),
      
      body: Card(
        child: Column(children: [
      Container( 
       margin: EdgeInsets.symmetric(
      horizontal: 20        
       ),
       padding: EdgeInsets.symmetric(
         horizontal: 20,
         vertical: 15
       ),
       width: double.infinity,
       height: 90,
       decoration: BoxDecoration(
       color: Colors.blue,
       borderRadius: BorderRadius.circular(20),      
       ),  
      child: Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Icon(
            Icons.book,
            color: Colors.white,
          ),
          Text.rich(
            TextSpan(
              text: "Último Livro Alugado",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              )
            )
          )
        ],
         
      ),
    
      ),
        ]),
      ) 
    );
  }
}
 