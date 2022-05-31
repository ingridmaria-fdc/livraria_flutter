// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:livraria_flutter/models/publishing.dart';
import 'package:livraria_flutter/routes/MyAppRoutes.dart';
import 'package:livraria_flutter/provider/publishing_provider.dart';
import 'package:provider/provider.dart';

class PublishingList extends StatelessWidget {
  final Publishing publishing;
  const PublishingList(this.publishing);

  @override
  Widget build(BuildContext context) {
    void onSelected(BuildContext context, int item) {
      switch (item) {
        case 1:
          Navigator.of(context)
              .pushNamed(MyAppRoutes.FORMPUBLISHING, arguments: publishing);
          break;
        case 2:
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => AlertDialog(
                    title: const Text('Excluir Editora'),
                    content:
                        const Text('Deseja realmente excluir esta editora?'),
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
                          Provider.of<PublishingProvider>(context,
                                  listen: false)
                              .remove(Publishing(
                            id: publishing.id,
                            name: publishing.name,
                            city: publishing.city,
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
        leading: CircleAvatar(child: Icon(Icons.align_vertical_bottom_sharp)),
        title: Text(publishing.name),
        subtitle: Text(publishing.city),
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
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  title: Text('${publishing.city}'),
                  leading: Icon(Icons.location_city),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
