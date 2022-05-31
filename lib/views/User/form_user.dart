// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:livraria_flutter/models/user.dart';
import 'package:livraria_flutter/provider/users_provider.dart';

import 'package:provider/provider.dart';

class FormUser extends StatefulWidget {
  const FormUser({Key? key}) : super(key: key);

  @override
  _FormUserState createState() => _FormUserState();
}

class _FormUserState extends State<FormUser> {
  final formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};
  late final String? Function(String? text)? validator;
  late final void Function(String? text)? onSaved;
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final user = arg as User;
        _formData['id'] = user.id;
        _formData['nome'] = user.name;
        _formData['endereco'] = user.address;
        _formData['cidade'] = user.city;
        _formData['email'] = user.email;
      }
    }
  }

  titulo() {
    if (_formData['id'] != null) {
      return const Text(
        'Editar Usuário',
        style: TextStyle(color: Colors.white),
      );
    } else {
      return const Text(
        'Novo Usuário',
        style: TextStyle(color: Colors.white),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titulo(),
        elevation: 0,
        backgroundColor: Colors.blue[700],
      ),
      body: Container(
          child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              TextFormField(
                initialValue: _formData['nome'],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Este campo não pode ser nulo';
                  }
                  if (text.length < 3) {
                    return 'O mínimo de caracteres é 3';
                  }
                },
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  labelText: 'Nome*',
                  hintText: 'Nome do usuário',
                  suffixIcon: const Icon(Icons.person),
                ),
                onSaved: (value) => _formData['nome'] = value!,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                initialValue: _formData['endereco'],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Este campo não pode ser nulo';
                  }
                  if (text.length < 3) {
                    return 'O mínimo de caracteres é 3';
                  }
                },
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  labelText: 'Endereço*',
                  hintText: 'Endereço do Usuário',
                  suffixIcon: const Icon(Icons.location_on),
                ),
                onSaved: (value) => _formData['endereco'] = value!,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                initialValue: _formData['cidade'],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Este campo não pode ser nulo';
                  }
                  if (text.length < 3) {
                    return 'O mínimo de caracteres é 3';
                  }
                },
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  labelText: 'Cidade*',
                  hintText: 'Nome da cidade',
                  suffixIcon: const Icon(Icons.location_city),
                ),
                onSaved: (value) => _formData['cidade'] = value!,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                initialValue: _formData['email'],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Este campo não pode ser nulo';
                  }
                  if (text.length < 3) {
                    return 'O mínimo de caracteres é 3';
                  }
                  if (!text.contains("@")) {
                    return 'Formato de email inválido';
                  }
                },
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  labelText: 'Email*',
                  hintText: 'Email do Usuário',
                  suffixIcon: const Icon(Icons.mail),
                ),
                onSaved: (value) => _formData['email'] = value!,
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton.icon(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();

                        if (_formData['id'] != null) {
                          Provider.of<UserProvider>(context, listen: false)
                              .update(User(
                                  id: _formData['id'],
                                  name: _formData['nome'],
                                  address: _formData['endereco'],
                                  city: _formData['cidade'],
                                  email: _formData['email']));
                        } else {
                          Provider.of<UserProvider>(context, listen: false)
                              .save(User(
                                  name: _formData['nome'],
                                  address: _formData['endereco'],
                                  city: _formData['cidade'],
                                  email: _formData['email']));
                        }
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(Icons.save),
                    label: const Text(
                      'Salvar',
                      style: const TextStyle(fontSize: 20),
                    )),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
