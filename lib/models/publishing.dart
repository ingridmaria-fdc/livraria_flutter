import 'package:flutter/material.dart';

class Publishing {
  dynamic id;
  dynamic name;
  dynamic city;

  Publishing({
    this.id,
    required this.name,
    required this.city,
  });

  Publishing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['nome'];
    city = json['cidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cidade'] = this.city;
    data['nome'] = this.name;
    return data;
  }
}
