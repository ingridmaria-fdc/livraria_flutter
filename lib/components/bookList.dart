// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:livraria_flutter/models/book.dart';
import 'package:livraria_flutter/models/publishing.dart';
import 'package:livraria_flutter/provider/book_provider.dart';
import 'package:livraria_flutter/routes/MyAppRoutes.dart';
import 'package:provider/provider.dart';

class BookList extends StatelessWidget {
  final Book book;
  const BookList(this.book);

  @override
  Widget build(BuildContext context) {
    void onSelected(BuildContext context, int item) {
      switch (item) {
        case 1:
          Navigator.of(context)
              .pushNamed(MyAppRoutes.FORMBOOK, arguments: book);
          break;
        case 2:
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => AlertDialog(
                    title: const Text('Excluir Livro'),
                    content: const Text('Deseja realmente excluir este livro?'),
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
                          Provider.of<BookProvider>(context, listen: false)
                              .remove(Book(
                            id: book.id,
                            name: book.name,
                            publishing: book.publishing?.name,
                            author: book.author,
                            launch: book.launch,
                            quantity: book.quantity,
                          ));
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
        leading: CircleAvatar(child: Icon(Icons.book)),
        title: Text(book.name),
        subtitle: Text(book.author),
        trailing: Container(
          width: 65,
          child: Row(
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
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          Text(
                            '   Editar',
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
              ),
            ],
          ),
        ),
        children: [
          Container(
            height: 195,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  title: Text('${book.publishing?.name}'),
                  leading: Icon(Icons.align_vertical_bottom_sharp),
                ),
                ListTile(
                  title: Text('${book.author}'),
                  leading: Icon(Icons.contact_page),
                ),
                ListTile(
                  title: Text('${book.launch}'),
                  leading: Icon(Icons.calendar_month),
                ),
                ListTile(
                  title: Text('${book.quantity}'),
                  leading: Icon(Icons.pin),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
