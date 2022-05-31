import 'package:flutter/material.dart';
import 'package:livraria_flutter/models/publishing.dart';

class Book {
  dynamic id;
  dynamic name;
  dynamic author;
  Publishing? publishing;
  dynamic launch;
  dynamic quantity;

  Book({
    this.id,
    @required this.name,
    @required this.publishing,
    @required this.author,
    @required this.launch,
    @required this.quantity,
  });

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['nome'];
    publishing = json['editora'] != null
        ? new Publishing.fromJson(json['editora'])
        : null;
    author = json['autor'];
    launch = json['lancamento'];
    quantity = json['quantidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.name;
    if (this.publishing != null) {
      data['editora'] = this.publishing!.toJson();
    }
    data['autor'] = this.author;
    data['lancamento'] = this.launch;
    data['quantidade'] = this.quantity;
    return data;
  }
}

// class Publishing {
//   dynamic id;
//   dynamic name;
//   dynamic city;

//   Publishing({this.id, this.name, this.city});

//   Publishing.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['nome'];
//     city = json['cidade'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['cidade'] = this.city;
//     data['id'] = this.id;
//     data['nome'] = this.name;
//     return data;
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:livraria_flutter/models/publishing.dart';

// class Book {
//   dynamic id;
//   dynamic name;
//   dynamic author;
//   Publishing publishing;
//   int launch;
//   int quantity;

//   Book(
//       {this.id,
//       required this.name,
//       required this.publishing,
//       required this.author,
//       required this.launch,
//       required this.quantity});
// }
