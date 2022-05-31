// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:livraria_flutter/models/book.dart';
import 'package:livraria_flutter/models/publishing.dart' as publishing;
import 'package:asuka/asuka.dart' as asuka;
import 'package:livraria_flutter/models/publishing.dart';
import 'package:date_format/date_format.dart';

class BookProvider with ChangeNotifier {
  final _baseURL = 'https://locadoradelivros-api.herokuapp.com/api';

  Future<List<Book>> loadBooks() async {
    final response = await http.get(Uri.parse(_baseURL + '/livros'));
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Book> listBooks = [];

    for (var livro in data) {
      listBooks.add(Book(
        id: livro['id'].toString(),
        name: livro['nome'],
        author: livro['autor'],
        publishing: livro['editora'] != null
            ? Publishing.fromJson(livro['editora'])
            : null,
        launch: livro['lancamento'],
        quantity: livro['quantidade'],
      ));
    }

    return listBooks;
  }

  Future<void> save(Book book) async {
    try {
      if (book != null) {
        String date = book.launch;
        String day = date.substring(0, 2);
        String month = date.substring(3, 5);
        String year = date.substring(6, 10);
        date = year + '-' + month + '-' + day;

        Map params = {
          'nome': book.name,
          "editora": {"id": int.parse(book.publishing?.id)},
          'autor': book.author,
          'lancamento': date,
          'quantidade': book.quantity,
        };

        String jsonS = json.encode(params);

        final response = await http.post(Uri.parse(_baseURL + '/livro'),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json"
            },
            body: jsonS,
            encoding: Encoding.getByName("utf-8"));
        if (response.statusCode == 200) {
          asuka.AsukaSnackbar.success("Livro salvo com sucesso").show();
        } else {
          asuka.AsukaSnackbar.alert("Erro ao tentar salvar o livro").show();
        }
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> update(Book book) async {
    if (book != null) {
      String date = book.launch;
      String day = date.substring(0, 2);
      String month = date.substring(3, 5);
      String year = date.substring(6, 10);
      date = year + '-' + month + '-' + day;

      Map params = {
        'id': book.id,
        'nome': book.name,
        'editora': {"id": int.parse(book.publishing?.id)},
        'autor': book.author,
        'lancamento': date,
        'quantidade': book.quantity,
      };
      String jsonS = json.encode(params);

      final response = await http.put(Uri.parse(_baseURL + '/editar/livro'),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonS,
          encoding: Encoding.getByName("utf-8"));
      if (response.statusCode == 200) {
        asuka.AsukaSnackbar.success("Livro editado com sucesso").show();
      } else {
        asuka.AsukaSnackbar.alert("Erro ao tentar editar o livro").show();
      }
      notifyListeners();
    }
  }

  Future<void> remove(Book book) async {
    if (book != null) {
      String date = book.launch;
      String day = date.substring(0, 2);
      String month = date.substring(3, 5);
      String year = date.substring(6, 10);
      date = year + '-' + month + '-' + day;

      Map params = {
        'id': book.id,
        'nome': book.name,
        "editora": {"id": int.parse(book.publishing?.id)},
        'autor': book.author,
        'lancamento': date,
        'quantidade': book.quantity,
      };
      String jsonS = json.encode(params);
      final response = await http.delete(Uri.parse(_baseURL + '/livro'),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonS,
          encoding: Encoding.getByName("utf-8"));
      if (response.statusCode == 200) {
        asuka.AsukaSnackbar.success("Livro deletado com sucesso").show();
      } else {
        asuka.AsukaSnackbar.alert("Erro ao tentar deletar este livro").show();
      }
      notifyListeners();
    }
  }
}
