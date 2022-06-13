// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:livraria_flutter/models/rets.dart';
import 'package:livraria_flutter/routes/MyAppRoutes.dart';
import 'package:provider/provider.dart';

class RetsList extends StatelessWidget {
  final Rets rets;
  const RetsList(this.rets);

  chip() {
    var data_aluguel = rets.rent_date;
    var data_previsao = rets.forecast_date;
    var data_devolucao = rets.return_date;

    if (data_devolucao != null && data_devolucao.compareTo(data_previsao) > 0) {
      return Chip(
        labelPadding: EdgeInsets.all(2),
        label: const Text('Entregue com atraso'),
        labelStyle: TextStyle(color: Colors.white),
        backgroundColor: Colors.red,
      );
    } else if (data_devolucao != null &&
        data_devolucao.compareTo(data_previsao) < 0) {
      return Chip(
        labelPadding: EdgeInsets.all(2),
        label: const Text('Entregue no prazo'),
        labelStyle: TextStyle(color: Colors.white),
        backgroundColor: Colors.blue,
      );
    } else if (data_devolucao != null && data_devolucao.compareTo(data_previsao) == 0){
       return Chip(
        labelPadding: EdgeInsets.all(2),
        label: const Text('Entregue no prazo'),
        labelStyle: TextStyle(color: Colors.white),
        backgroundColor: Colors.blue,
      );
    }
    else{
      return Chip(
        labelPadding: EdgeInsets.all(2),
        label: const Text('Livro em aluguel'),
        labelStyle: TextStyle(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 31, 142, 33),
      );
    }
  }

  

  @override
  Widget build(BuildContext context) {
    void onSelected(BuildContext context, int item) {
      switch (item) {
        case 1:
          Navigator.of(context)
              .pushNamed(MyAppRoutes.FORMEDITRETS, arguments: rets);
          break;
        case 2:
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => AlertDialog(
                    title: const Text('Excluir Aluguel'),
                    content:
                        const Text('Deseja realmente excluir este aluguel?'),
                    actions: [
                      TextButton(
                        style: TextButton.styleFrom(),
                        onPressed: () {
                          Navigator.pop(ctx);
                        },
                        child: const Text(
                          'Não',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(),
                        onPressed: () {
                          // Provider.of<BookProvider>(context, listen: false)
                          //     .remove(Book(
                          //   id: book.id,
                          //   name: book.name,
                          //   publishing: book.publishing?.name,
                          //   author: book.author,
                          //   launch: book.launch,
                          //   quantity: book.quantity,
                          // ));
                          Navigator.pop(ctx);
                        },
                        child: const Text('Sim'),
                      ),
                    ],
                  ));
          break;
      }
    }

    return Container(
     alignment: Alignment.bottomLeft,
      margin: const EdgeInsets.only(bottom: 7),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            spreadRadius: 0.1,
            blurRadius: 4,
            color: Colors.black26,
          )
        ],
      ),
      child: ExpansionTile(
        leading: CircleAvatar(child: Icon(Icons.contact_page)),
        title: Padding(padding: EdgeInsets.only(bottom: 12),
        child: Text(rets.book?.name)
        ),
        subtitle: Align(
          alignment: Alignment.bottomLeft,          
          child: chip()),
        trailing: Container(
          width: 65,         
          child: 
          rets.return_date == null ?
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            const Icon(Icons.expand_more),  
            PopupMenuButton<int>(
                onSelected: (item) => onSelected(context, item),
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: const [
                          Icon(        
                            Icons.bookmark_added_rounded,
                            color: Colors.blue,
                          ),
                          Text(
                            '   Devolver',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      )),
                  PopupMenuItem<int>(
                      value: 2,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          Text(
                            '   Deletar',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          )
                        ],
                      )),
                ],
              )
              
            ],
          )
          :  const Icon(Icons.expand_more), 
        ),
        children: [
          Container(
            height: 250,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  title: Text('${rets.book?.name}'),
                  leading: Icon(Icons.book),
                ),
                ListTile(
                  title: Text('${rets.user?.name}'),
                  leading: Icon(Icons.person),
                ),
                ListTile(
                  title: Text('Data do Aluguel: ${rets.rent_date}'),
                  leading: Icon(Icons.calendar_month),
                ),
                ListTile(
                  title: Text('Previsão de Devolução: ${rets.forecast_date}'),
                  leading: Icon(Icons.calendar_month),
                ),
                ListTile(
                  title: rets.return_date != null ? Text('Data da Devolução: ${rets.return_date}') : Text('Data da Devolução: Não devolvido'),
                  leading: Icon(Icons.calendar_month),
                ),
              ],
            ),
          )
        ],
      ),
    );

  }
}
