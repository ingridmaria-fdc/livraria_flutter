// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/cupertino.dart';
import 'package:livraria_flutter/models/publishing.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:asuka/asuka.dart' as asuka;

class PublishingProvider with ChangeNotifier {
  final _baseURL = 'https://locadoradelivros-api.herokuapp.com/api';

  Future<List<Publishing>> loadPublishing() async {
    final response = await http.get(Uri.parse(_baseURL + '/editoras'));
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Publishing> listPublishing = [];

    for (var editora in data) {
      listPublishing.add(Publishing(
          id: editora['id'], name: editora['nome'], city: editora['cidade']));
    }
    return listPublishing;
  }

  Future<void> save(Publishing publishing) async {
    if (publishing != null) {
      final response = await http.post(Uri.parse(_baseURL + '/editora'),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            'nome': publishing.name,
            'cidade': publishing.city,
          }),
          encoding: Encoding.getByName("utf-8"));
      if (response.statusCode == 200) {
        asuka.AsukaSnackbar.success("Editora salva com sucesso").show();
      } else {
        asuka.AsukaSnackbar.alert("Erro ao tentar salvar a editora").show();
      }
      notifyListeners();
    }
  }

  Future<void> update(Publishing publishing) async {
    if (publishing != null) {
      final response = await http.put(Uri.parse(_baseURL + '/editar/editora'),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            'id': publishing.id,
            'nome': publishing.name,
            'cidade': publishing.city,
          }),
          encoding: Encoding.getByName("utf-8"));
      if (response.statusCode == 200) {
        asuka.AsukaSnackbar.success("Editora editada com sucesso").show();
      } else {
        asuka.AsukaSnackbar.alert("Erro ao tentar editar esta editora").show();
      }
      notifyListeners();
    }
  }

  Future<void> remove(Publishing publishing) async {
    if (publishing != null) {
      final response = await http.delete(Uri.parse(_baseURL + '/editora'),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            'id': publishing.id,
            'nome': publishing.name,
            'cidade': publishing.city,
          }),
          encoding: Encoding.getByName("utf-8"));
      if (response.statusCode == 200) {
        asuka.AsukaSnackbar.success("Editora deletada com sucesso").show();
      } else {
        asuka.AsukaSnackbar.alert(
                "Erro: Não é possível excluir esta editora, pois possui livros associados")
            .show();
      }
      notifyListeners();
    }
  }
}
