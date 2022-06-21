// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:livraria_flutter/components/bookList.dart';
import 'package:livraria_flutter/main.dart';
import 'package:livraria_flutter/provider/book_provider.dart';
import 'package:livraria_flutter/routes/MyAppRoutes.dart';
import 'package:provider/provider.dart';

class BookPage extends StatefulWidget {
  BookPage({Key? key}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  Future<List> getBook() async {
    var url =
        Uri.parse('https://locadoradelivros-api.herokuapp.com/api/livros');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Erro ao carregar dados do Servidor');
    }
  }

  @override
  Widget build(BuildContext context) {
    final book = Provider.of<BookProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Livros'),
        backgroundColor: Colors.blue[700],
        leading: Icon(Icons.book),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              Navigator.of(context).pushNamed(MyAppRoutes.FORMBOOK);
            },
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(           
      //   onPressed: () {
      //       Navigator.of(context).pushNamed(MyAppRoutes.FORMBOOK);
      //   },
      //   child: Icon(Icons.add),
      // ),
      body: FutureBuilder(
          future: book.loadBooks(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Erro ao carregar os Livros'),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (ctx, i) => BookList(snapshot.data[i]));
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
