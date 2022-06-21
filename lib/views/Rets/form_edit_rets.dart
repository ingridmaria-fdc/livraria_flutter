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

class FormEditRets extends StatefulWidget {
  const FormEditRets({Key? key}) : super(key: key);

  @override
  _FormEditRetsState createState() => _FormEditRetsState();
}

class _FormEditRetsState extends State<FormEditRets> {
  @override
  void initState() {    
    super.initState();
  }

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
        _formData['livro'] = rets.book!.id.toString();
        _formData['usuario'] = rets.user!.id.toString();
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
              TextFormField(
                  initialValue: _formData['data_devolucao'],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Este campo não pode ser nulo';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Data da Devolução*',
                    hintText: '',
                    suffixIcon: Icon(Icons.calendar_month),
                  ),
                  onSaved: (value) => _formData['data_previsao'] = value!,
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
                  //       _formData['data_previsao'] = formattedDate;
                  //     });
                  //   }
                  // }
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
                         Provider.of<RetsProvider>(context, listen: false)
                              .update(Rets(
                                  id: _formData['id'],                                  
                                  book: Book(
                                      id: _formData['livro'],
                                      name: "",
                                      publishing: Publishing(
                                      id: _formData['editora'],
                                      name: "",
                                      city: ""),
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
                                  return_date: _formData['data_devolucao']
                                  ));
                        } else {
                          Provider.of<RetsProvider>(context, listen: false)
                              .save(Rets(
                                 book: Book(
                                      id: _formData['livro'],
                                      name: "",
                                      publishing: Publishing(
                                      id: _formData['editora'],
                                      name: "",
                                      city: ""),
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
                                  return_date: _formData['data_devolucao']
                                  ));
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
