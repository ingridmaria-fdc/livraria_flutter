import 'package:flutter/material.dart';
import 'package:livraria_flutter/models/book.dart';
import 'package:livraria_flutter/models/user.dart';


class Rets {
  dynamic id;
  Book? book;
  User? user;
  dynamic rent_date;
  dynamic forecast_date;
  dynamic return_date;

  Rets({
    this.id,
    @required this.book,
    @required this.user,
    @required this.rent_date,
    @required this.forecast_date,
    @required this.return_date
  });

  Rets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    book = json['livro'] != null
        ? new Book.fromJson(json['livro'])
        : null;
    user = json['usuario'] != null
        ? new User.fromJson(json['usuario'])
        : null;
    rent_date = json['data_aluguel'];
    forecast_date = json['data_previsao'];
    return_date = json['data_devolucao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.book != null) {
      data['livro'] = this.book!.toJson();
    }
    if (this.user != null) {
      data['usuario'] = this.user!.toJson();
    }
    data['data_aluguel'] = this.rent_date;
    data['data_previsao'] = this.forecast_date;
    data['data_devolucao'] = this.return_date;
    return data;
  }
}


