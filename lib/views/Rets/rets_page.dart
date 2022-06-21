import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:livraria_flutter/components/retsList.dart';
import 'package:livraria_flutter/main.dart';
import 'package:livraria_flutter/provider/rets_provider.dart';
import 'package:livraria_flutter/routes/MyAppRoutes.dart';
import 'package:provider/provider.dart';

class RetsPage extends StatefulWidget {
  RetsPage({Key? key}) : super(key: key);

  @override
  _RetsPageState createState() => _RetsPageState();
}

class _RetsPageState extends State<RetsPage> {
  Future<List> getRets() async {
    var url =
        Uri.parse('https://locadoradelivros-api.herokuapp.com/api/alugueis');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Erro ao carregar dados do Servidor');
    }
  }
  @override
  Widget build(BuildContext context) {
    final rets = Provider.of<RetsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Aluguéis'),
        backgroundColor: Colors.blue[700],
        leading: Icon(Icons.contact_page),
         actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              Navigator.of(context).pushNamed(MyAppRoutes.FORMSAVERETS);
            },
          )
        ],
      ),
      body: FutureBuilder(
          future: rets.loadRets(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Erro ao carregar os Alugueis'),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (ctx, i) => RetsList(snapshot.data[i]));
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
