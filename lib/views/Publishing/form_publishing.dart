import 'package:flutter/material.dart';
import 'package:livraria_flutter/models/publishing.dart';
import 'package:livraria_flutter/provider/publishing_provider.dart';
import 'package:provider/provider.dart';

class FormPublishing extends StatefulWidget {
  const FormPublishing({Key? key}) : super(key: key);

  @override
  _FormPublishingState createState() => _FormPublishingState();
}

class _FormPublishingState extends State<FormPublishing> {
  final formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};
  late final String? Function(String? text)? validator;
  late final void Function(String? text)? onSaved;
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final publishing = arg as Publishing;
        _formData['id'] = publishing.id.toString();
        _formData['nome'] = publishing.name;
        _formData['cidade'] = publishing.city;
      }
    }
  }

  titulo() {
    if (_formData['id'] != null) {
      return Text(
        'Editar Editora',
        style: TextStyle(color: Colors.white),
      );
    } else {
      return Text(
        'Nova Editora',
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
                  if (text.length > 50) {
                    return 'O máximo de caracteres é 50';
                  }
                },
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  labelText: 'Nome*',
                  hintText: 'Nome da editora',
                  suffixIcon: Icon(Icons.align_vertical_bottom_sharp),
                ),
                onSaved: (value) => _formData['nome'] = value!,
              ),
              SizedBox(
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
                  if (text.length > 50) {
                    return 'O máximo de caracteres é 50';
                  }
                },
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  labelText: 'Cidade*',
                  hintText: 'Nome da cidade',
                  suffixIcon: Icon(Icons.location_city),
                ),
                onSaved: (value) => _formData['cidade'] = value!,
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
                          Provider.of<PublishingProvider>(context,
                                  listen: false)
                              .update(Publishing(
                            id: _formData['id'],
                            name: _formData['nome'],
                            city: _formData['cidade'],
                          ));
                        } else {
                          Provider.of<PublishingProvider>(context,
                                  listen: false)
                              .save(Publishing(
                            name: _formData['nome'],
                            city: _formData['cidade'],
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
