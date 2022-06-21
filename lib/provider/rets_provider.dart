// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:livraria_flutter/models/book.dart';
import 'package:livraria_flutter/models/publishing.dart' as publishing;
import 'package:asuka/asuka.dart' as asuka;
import 'package:livraria_flutter/models/publishing.dart';
import 'package:date_format/date_format.dart';
import 'package:livraria_flutter/models/rets.dart';
import 'package:livraria_flutter/models/user.dart';

class RetsProvider with ChangeNotifier {
  final _baseURL = 'https://locadoradelivros-api.herokuapp.com/api';

  Future<List<Rets>> loadRets() async {
    final response = await http.get(Uri.parse(_baseURL + '/alugueis'));
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Rets> listRets = [];

    for (var alugueis in data) {
      listRets.add(Rets(
        id: alugueis['id'].toString(),
        book: alugueis['livro'] != null
            ? Book.fromJson(alugueis['livro'])
            : null,
        user: alugueis['usuario'] != null
            ? User.fromJson(alugueis['usuario'])
            : null,
        rent_date: alugueis['data_aluguel'],
        forecast_date: alugueis['data_previsao'],
        return_date: alugueis['data_devolucao'],
      ));
    }

    return listRets;
  }

  Future<void> save(Rets rets) async {
    try {
      if (rets != null) {
        String rentDate = rets.rent_date;
        String day = rentDate.substring(0, 2);
        String month = rentDate.substring(3, 5);
        String year = rentDate.substring(6, 10);
        rentDate = year + '-' + month + '-' + day;

        String forecastDate = rets.forecast_date;
        String forecastDay = forecastDate.substring(0, 2);
        String forecastMonth = forecastDate.substring(3, 5);
        String forecastYear = forecastDate.substring(6, 10);
        forecastDate = forecastYear + '-' + forecastMonth + '-' + forecastDay;

        String returnDate = rets.rent_date;
        String returnDay = returnDate.substring(0, 2);
        String returnMonth = returnDate.substring(3, 5);
        String returnYear = returnDate.substring(6, 10);
        returnDate = year + '-' + month + '-' + day;

        Map params = {         
          "livro": {"id": rets.book?.id},
          "usuario": {"id": rets.user?.id},
          'data_aluguel': rentDate,
          'data_previsao': forecastDate,  
          'data_devolucao': returnDate,      
        };

        String jsonS = json.encode(params);

        final response = await http.post(Uri.parse(_baseURL + '/aluguel'),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json"
            },
            body: jsonS,
            encoding: Encoding.getByName("utf-8"));
        if (response.statusCode == 200) {
          asuka.AsukaSnackbar.success("Aluguel salvo com sucesso").show();
        } else {
          asuka.AsukaSnackbar.alert("Erro ao tentar salvar este aluguel").show();
        }
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> update(Rets rets) async {
    if (rets != null) {
      String returnDate = rets.rent_date;
      String day = returnDate.substring(0, 2);
      String month = returnDate.substring(3, 5);
      String year = returnDate.substring(6, 10);
      returnDate = year + '-' + month + '-' + day;


       Map params = {  
          "id": rets.id,   
          "livro": {"id": rets.book?.id},
          "usuario": {"id": rets.user?.id},
          'data_aluguel': rets.rent_date,
          'data_previsao': rets.forecast_date,            
          'data_devolucao': returnDate,
        };
      String jsonS = json.encode(params);

      final response = await http.put(Uri.parse(_baseURL + '/editar/aluguel'),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonS,
          encoding: Encoding.getByName("utf-8"));
      if (response.statusCode == 200) {
        asuka.AsukaSnackbar.success("Aluguel editado com sucesso").show();
      } else {
        asuka.AsukaSnackbar.alert("Erro ao tentar editar este aluguel").show();
      }
      notifyListeners();
    }
  }

  Future<void> remove(Rets rets) async {
    if (rets != null) {     

      Map params = {
        "id": rets.id, 
        "livro": {"id": rets.book?.id},
        "usuario": {"id": rets.user?.id},
        'data_aluguel': rets.rent_date,
        'data_previsao': rets.forecast_date,
        'data_devolucao': rets.return_date,
      };
      String jsonS = json.encode(params);
      final response = await http.delete(Uri.parse(_baseURL + '/aluguel'),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonS,
          encoding: Encoding.getByName("utf-8"));
      if (response.statusCode == 200) {
        asuka.AsukaSnackbar.success("Aluguel deletado com sucesso").show();
      } else {
        asuka.AsukaSnackbar.alert("Erro ao tentar deletar este aluguel").show();
      }
      notifyListeners();
    }
  }
}
