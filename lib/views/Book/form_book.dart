// ignore_for_file: unused_local_variable, prefer_const_constructors, unused_label
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:livraria_flutter/models/book.dart';
import 'package:livraria_flutter/models/publishing.dart';
import 'package:livraria_flutter/provider/book_provider.dart';
import 'package:livraria_flutter/provider/publishing_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FormBook extends StatefulWidget {
  const FormBook({Key? key}) : super(key: key);

  @override
  _FormBookState createState() => _FormBookState();
}

class _FormBookState extends State<FormBook> {
  @override
  void initState() {
    loadPublishing();
    super.initState();
  }

  Future<List<Publishing>> loadPublishing() async {
    final _baseURL = 'https://locadoradelivros-api.herokuapp.com/api';

    final response = await http.get(Uri.parse(_baseURL + '/editoras'));
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    for (var editora in data) {
      setState(() {
        listPublishing.add(Publishing(
            id: editora['id'], name: editora['nome'], city: editora['cidade']));
      });
    }

    return listPublishing;
  }

  String? selectedDate;
  List<Publishing> listPublishing = [];
  final formKey = GlobalKey<FormState>();
  late final Map<String, String> _formData = {};
  late final String? Function(String? text)? validator;
  late final void Function(String? text)? onSaved;
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final book = arg as Book;
        _formData['id'] = book.id.toString();
        _formData['nome'] = book.name;
        _formData['autor'] = book.author;
        _formData['editora'] = book.publishing!.id.toString();
        _formData['lancamento'] = book.launch.toString();
        _formData['quantidade'] = book.quantity.toString();
      }
    }
  }

  titulo() {
    if (_formData['id'] != null) {
      return Text(
        'Editar Livro',
        style: TextStyle(color: Colors.white),
      );
    } else {
      return Text(
        'Novo Livro',
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
                  hintText: 'Nome do Livro',
                  suffixIcon: Icon(Icons.book),
                ),
                onSaved: (value) => _formData['nome'] = value!,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                initialValue: _formData['autor'],
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
                  labelText: 'Autor*',
                  hintText: 'Nome do Autor',
                  suffixIcon: Icon(Icons.contact_page),
                ),
                onSaved: (value) => _formData['autor'] = value!,
              ),
              SizedBox(
                height: 15,
              ),
              // TextFormField(
              //   initialValue: _formData['editora'],
              //   autovalidateMode: AutovalidateMode.onUserInteraction,
              //   validator: (text) {
              //     if (text == null || text.isEmpty) {
              //       return 'Este campo não pode ser nulo';
              //     }
              //   },
              //
              //
              // ),

              DropdownButtonFormField<String>(
                hint: Text(
                  'Escolha uma Editora*',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                value: _formData['editora'],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                onChanged: (value) {
                  setState(() {
                    _formData['editora'] = value.toString();
                  });
                },
                items: listPublishing.map((item) {
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
                initialValue: _formData['lancamento'],
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
                  labelText: 'Lançamento*',
                  hintText: 'Data de Lançamento',
                  suffixIcon: Icon(Icons.calendar_month),
                ),
                onSaved: (value) => _formData['lancamento'] = value!,
                // onTap: () async {
                //   DateTime? pickedDate = await showDatePicker(
                //       context: context,
                //       initialDate: DateTime.now(),
                //       firstDate: DateTime(2000),
                //       lastDate: DateTime(2101));
                //   if (pickedDate != null) {
                //     String formattedDate =
                //         DateFormat('dd-MM-yyyy').format(pickedDate);
                //     setState(() {
                //       _formData['lancamento'] = formattedDate;
                //     });
                //   }
                // }
              ),
              SizedBox(
                height: 15,
              ),
              
              TextFormField(
                initialValue: _formData['quantidade'],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Este campo não pode ser nulo';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Quantidade*',
                  hintText: 'Quantidade do Livro',
                  suffixIcon: Icon(Icons.pin),
                ),
                onSaved: (value) => _formData['quantidade'] = value!,
              ),
              SizedBox(
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
                          Provider.of<BookProvider>(context, listen: false)
                              .update(Book(
                                  id: _formData['id'],
                                  name: _formData['nome'],
                                  publishing: Publishing(
                                      id: _formData['editora'],
                                      name: "",
                                      city: ""),
                                  author: _formData['autor'],
                                  launch: _formData['lancamento'],
                                  quantity: _formData['quantidade']));
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
                      }
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