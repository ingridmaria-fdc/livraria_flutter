// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:livraria_flutter/components/publishingList.dart';
import 'package:livraria_flutter/main.dart';
import 'package:livraria_flutter/models/publishing.dart';
import 'package:livraria_flutter/provider/publishing_provider.dart';
import 'package:livraria_flutter/routes/MyAppRoutes.dart';
import 'package:provider/provider.dart';

class PublishingPage extends StatefulWidget {
  const PublishingPage({Key? key}) : super(key: key);

  @override
  _PublishingPageState createState() => _PublishingPageState();
}

class _PublishingPageState extends State<PublishingPage> {
  Future<List> getPublishing() async {
    var url =
        Uri.parse('https://locadoradelivros-api.herokuapp.com/api/editoras');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Erro ao carregar dados do Servidor');
    }
  }

  @override
  Widget build(BuildContext context) {
    final publishing = Provider.of<PublishingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Editoras'),
        backgroundColor: Colors.blue[700],
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              Navigator.of(context).pushNamed(MyAppRoutes.FORMPUBLISHING);
            },
          )
        ],
      ),
      body: FutureBuilder(
          future: publishing.loadPublishing(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Erro ao carregar as Editoras'),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (ctx, i) => PublishingList(snapshot.data[i]));
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
