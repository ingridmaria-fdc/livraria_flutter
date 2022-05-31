import 'package:flutter/material.dart';

class User {
  final dynamic id;
  final dynamic name;
  final dynamic address;
  final dynamic city;
  final dynamic email;

  const User({
    this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.email,
  });
}
