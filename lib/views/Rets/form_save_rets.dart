// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:livraria_flutter/models/book.dart';
import 'package:livraria_flutter/models/publishing.dart';
import 'package:livraria_flutter/models/rets.dart';
import 'package:livraria_flutter/models/user.dart';
import 'package:livraria_flutter/provider/book_provider.dart';
import 'package:livraria_flutter/provider/rets_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FormSaveRets extends StatefulWidget {
  const FormSaveRets({Key? key}) : super(key: key);

  @override
  _FormSaveRetsState createState() => _FormSaveRetsState();
}

class _FormSaveRetsState extends State<FormSaveRets> {
  @override
  void initState() {
    loadBooks();
    loadUsers();
    super.initState();
  }

  Future<List<Book>> loadBooks() async {
    final _baseURL = 'https://locadoradelivros-api.herokuapp.com/api';

    final response = await http.get(Uri.parse(_baseURL + '/livros'));
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    for (var livro in data) {
      setState(() {
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
      });
    }

    return listBooks;
  }

  Future<List<User>> loadUsers() async {
    final _baseURL = 'https://locadoradelivros-api.herokuapp.com/api';

    final response = await http.get(Uri.parse(_baseURL + '/usuarios'));
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    for (var usuario in data) {
      setState(() {
        listUsers.add(User(
            id: usuario['id'].toString(),
            name: usuario['nome'],
            address: usuario['endereco'],
            email: usuario['email'],
            city: usuario['cidade']));
      });
    }
    return listUsers;
  }

  List<Book> listBooks = [];
  List<User> listUsers = [];
  final formKey = GlobalKey<FormState>();
  late final Map<String, String> _formData = {};
  late final String? Function(String? text)? validator;
  late final void Function(String? text)? onSaved;
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final rets = arg as Rets;
        _formData['id'] = rets.id.toString();
        _formData['livro'] = rets.book?.name;
        _formData['usuario'] = rets.user?.name;
        _formData['data_aluguel'] = rets.rent_date.toString();
        _formData['data_previsao'] = rets.forecast_date.toString();
        _formData['data_devolucao'] = rets.return_date.toString();
      }
    }
  }

  titulo() {
    if (_formData['id'] != null) {
      return Text(
        'Editar Aluguel',
        style: TextStyle(color: Colors.white),
      );
    } else {
      return Text(
        'Novo Aluguel',
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
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                hint: Text(
                  'Escolha um Livro*',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                value: _formData['livro'],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                onChanged: (value) {
                  setState(() {
                    _formData['livro'] = value!;
                  });
                },
                items: listBooks.map((item) {
                  return DropdownMenuItem(
                    value: item.id.toString(),
                    child: Text(item.name),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 15,
              ),
              DropdownButtonFormField<String>(
                hint: Text(
                  'Escolha um Usuário*',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                value: _formData['usuario'],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                onChanged: (value) {
                  setState(() {
                    _formData['usuario'] = value!;
                  });
                },
                items: listUsers.map((item) {
                  return DropdownMenuItem(
                    value: item.id.toString(),
                    child: Text(item.name),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                  initialValue: _formData['data_aluguel'],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Este campo não pode ser nulo';
                    }
                    if (text.length < 3) {
                      return 'O mínimo de caracteres é 3';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Data do aluguel*',
                    hintText: '',
                    suffixIcon: Icon(Icons.calendar_month),
                  ),
                  onSaved: (value) => _formData['data_aluguel'] = value!,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      setState(() {
                        _formData['data_aluguel'] = formattedDate;
                      });
                    }
                  }),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                  initialValue: _formData['data_previsao'],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Este campo não pode ser nulo';
                    }
                    if (text.length < 3) {
                      return 'O mínimo de caracteres é 3';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Previsão de Devolução*',
                    hintText: '',
                    suffixIcon: Icon(Icons.calendar_month),
                  ),
                  onSaved: (value) => _formData['data_previsao'] = value!,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      setState(() {
                        _formData['data_previsao'] = formattedDate;
                      });
                    }
                  }),
              SizedBox(
                height: 15,
              ),
              // TextFormField(
              //     initialValue: _formData['data_devolucao'],
              //     decoration: InputDecoration(
              //       labelText: 'Data da Devolução*',
              //       hintText: '',
              //       suffixIcon: Icon(Icons.calendar_month),
              //     ),
              //     onSaved: (value) => _formData['data_devolucao'] = value!,
              //     onTap: () async {
              //       DateTime? pickedDate = await showDatePicker(
              //           context: context,
              //           initialDate: DateTime.now(),
              //           firstDate: DateTime(2000),
              //           lastDate: DateTime(2101));
              //       if (pickedDate != null) {
              //         String formattedDate =
              //             DateFormat('dd-MM-yyyy').format(pickedDate);
              //         setState(() {
              //           _formData['data_devolucao'] = formattedDate;
              //         });
              //       }
              //     }),
              // SizedBox(
              //   height: 15,
              // ),
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
                      //  if (formKey.currentState!.validate()) {
                      //   formKey.currentState!.save();

                        if (_formData['id'] != null) {
                          Provider.of<RetsProvider>(context, listen: false)
                              .update(Rets(
                                  id: _formData['id'],                                  
                                  book: Book(
                                      id: _formData['livro'],
                                      name: "",
                                      author: "",
                                      launch: "",
                                      quantity: ""
                                      ),
                                  user: User(
                                      id: _formData['livro'],
                                      name: "",
                                      address: "",
                                      city: "",
                                      email: ""
                                      ),
                                  rent_date: _formData['data_aluguel'],
                                  forecast_date: _formData['data_previsao'],
                                  return_date: _formData['data_devolucao']));
                        } else {
                          Provider.of<BookProvider>(context, listen: false)
                              .save(Book(
                                  name: _formData['nome'],
                                  publishing: Publishing(
                                      id: _formData['editora'],
                                      name: "",
                                      city: ""),
                                  author: _formData['autor'],
                                  launch: _formData['lancamento'],
                                  quantity: _formData['quantidade']));
                        }

                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.save),
                    label: Text(
                      'Salvar',
                      style: TextStyle(fontSize: 20),
                    )),
  
              ),
            ],
          ),
        ),
      )),
    );
  }
}
