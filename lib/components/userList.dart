import 'package:flutter/material.dart';
import 'package:livraria_flutter/models/user.dart';
import 'package:livraria_flutter/provider/users_provider.dart';
import 'package:livraria_flutter/routes/MyAppRoutes.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  final User user;
  const UserList(this.user);

  @override
  Widget build(BuildContext context) {
    void onSelected(BuildContext context, int item) {
      switch (item) {
        case 1:
          Navigator.of(context)
              .pushNamed(MyAppRoutes.FORMUSERS, arguments: user);
          break;
        case 2:
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => AlertDialog(
                    title: const Text('Excluir Usuário'),
                    content:
                        const Text('Deseja realmente excluir este usuário?'),
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
                          Provider.of<UserProvider>(context, listen: false)
                              .remove(User(
                                  id: user.id,
                                  name: user.name,
                                  address: user.address,
                                  city: user.city,
                                  email: user.email));
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
        leading: CircleAvatar(child: Icon(Icons.person)),
        title: Text(user.name),
        subtitle: Text(user.email),
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
            height: 155,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  title: Text('${user.email}'),
                  leading: Icon(Icons.mail),
                ),
                ListTile(
                  title: Text('${user.address}'),
                  leading: Icon(Icons.location_on),
                ),
                ListTile(
                  title: Text('${user.city}'),
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
