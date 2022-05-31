// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:livraria_flutter/provider/book_provider.dart';
import 'package:livraria_flutter/provider/publishing_provider.dart';
import 'package:livraria_flutter/provider/users_provider.dart';
import 'package:livraria_flutter/views/Book/form_book.dart';
import 'package:livraria_flutter/views/Publishing/form_publishing.dart';
import 'package:livraria_flutter/views/User/form_user.dart';
import 'package:livraria_flutter/views/Book/book_page.dart';
import 'package:livraria_flutter/views/Publishing/publishing_page.dart';
import 'package:livraria_flutter/views/Rets/rets_page.dart';
import 'package:livraria_flutter/views/User/user_page.dart';
import 'package:livraria_flutter/views/home_page.dart';
import 'package:livraria_flutter/routes/MyAppRoutes.dart';
import 'package:provider/provider.dart';
import 'package:asuka/asuka.dart' as asuka;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => PublishingProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => UserProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => BookProvider(),
          )
        ],
        child: MaterialApp(
            title: 'WDA Livraria',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            builder: asuka.builder,
            navigatorObservers: [
              asuka.asukaHeroController
            ],
            routes: {
              MyAppRoutes.HOME: (context) => HomePage(),
              MyAppRoutes.BOOKS: (context) => BookPage(),
              MyAppRoutes.FORMBOOK: ((context) => FormBook()),
              MyAppRoutes.USERS: (context) => UserPage(),
              MyAppRoutes.FORMUSERS: (context) => FormUser(),
              MyAppRoutes.PUBLISHING: (context) => PublishingPage(),
              MyAppRoutes.FORMPUBLISHING: (context) => FormPublishing(),
              MyAppRoutes.RETS: (context) => RetsPage(),
            }));
  }
}
