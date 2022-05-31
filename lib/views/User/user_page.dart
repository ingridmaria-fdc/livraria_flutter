import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:livraria_flutter/components/userList.dart';
import 'package:livraria_flutter/main.dart';
import 'package:livraria_flutter/provider/users_provider.dart';
import 'package:livraria_flutter/routes/MyAppRoutes.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Future<List> getUsers() async {
    var url =
        Uri.parse('https://locadoradelivros-api.herokuapp.com/api/usuarios');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Erro ao carregar dados do Servidor');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuários'),
        backgroundColor: Colors.blue[700],
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              Navigator.of(context).pushNamed(MyAppRoutes.FORMUSERS);
            },
          )
        ],
      ),
      body: FutureBuilder(
          future: user.loadUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Erro ao carregar os Usuários'),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (ctx, i) => UserList(snapshot.data[i]));
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
