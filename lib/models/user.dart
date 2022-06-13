import 'package:flutter/material.dart';

class User {
   dynamic id;
   dynamic name;
   dynamic address;
   dynamic city;
   dynamic email;

   User({
    this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.email,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['nome'];
    address = json['endereco'];
    city = json['cidade'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.name;
    data['endereco'] = this.address;
    data['cidade'] = this.city;
    data['email'] = this.email;
    return data;
  }
}

