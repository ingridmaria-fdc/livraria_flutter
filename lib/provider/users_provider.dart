// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:asuka/asuka.dart' as asuka;
import 'package:livraria_flutter/models/user.dart';

class UserProvider with ChangeNotifier {
  final _baseURL = 'https://locadoradelivros-api.herokuapp.com/api';

  Future<List<User>> loadUser() async {
    final response = await http.get(Uri.parse(_baseURL + '/usuarios'));
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<User> listUser = [];

    for (var usuario in data) {
      listUser.add(User(
          id: usuario['id'].toString(),
          name: usuario['nome'],
          address: usuario['endereco'],
          email: usuario['email'],
          city: usuario['cidade']));
    }
    return listUser;
  }

  Future<void> save(User user) async {
    if (user != null) {
      final response = await http.post(Uri.parse(_baseURL + '/usuario'),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            'nome': user.name,
            'endereco': user.address,
            'cidade': user.city,
            'email': user.email
          }),
          encoding: Encoding.getByName("utf-8"));
      if (response.statusCode == 200) {
        asuka.AsukaSnackbar.success("Usuário salvo com sucesso").show();
      } else {
        asuka.AsukaSnackbar.alert("Erro ao tentar salvar este usuário").show();
      }
      notifyListeners();
    }
  }

  Future<void> update(User user) async {
    if (user != null) {
      final response = await http.put(Uri.parse(_baseURL + '/editar/usuario'),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            'id': user.id,
            'nome': user.name,
            'endereco': user.address,
            'cidade': user.city,
            'email': user.email
          }),
          encoding: Encoding.getByName("utf-8"));
      if (response.statusCode == 200) {
        asuka.AsukaSnackbar.success("Usuário editado com sucesso").show();
      } else {
        asuka.AsukaSnackbar.alert("Erro ao tentar editar este usuário").show();
      }
      notifyListeners();
    }
  }

  Future<void> remove(User user) async {
    if (user != null) {
      final response = await http.delete(Uri.parse(_baseURL + '/usuario'),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            'id': user.id,
            'nome': user.name,
            'endereco': user.address,
            'cidade': user.city,
            'email': user.email
          }),
          encoding: Encoding.getByName("utf-8"));
      if (response.statusCode == 200) {
        asuka.AsukaSnackbar.success("Usuário deletado com sucesso").show();
      } else {
        asuka.AsukaSnackbar.alert("Erro ao tentar deletar este usuário").show();
      }
      notifyListeners();
    }
  }
}
