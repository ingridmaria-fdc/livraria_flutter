// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'Book/book_page.dart';
import 'Dashboard/dashboard_page.dart';
import 'Rets/rets_page.dart';
import 'User/user_page.dart';
import 'Publishing/publishing_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: [
          DashboardPage(),
          BookPage(),
          UserPage(),
          PublishingPage(),
          RetsPage(),
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue[900]),
          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Livros',
              backgroundColor: Colors.blue[700]),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Usuários',
              backgroundColor: Colors.blue[700]),
          BottomNavigationBarItem(
              icon: Icon(Icons.align_vertical_bottom_sharp),
              label: 'Editoras',
              backgroundColor: Colors.blue[900]),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: 'Aluguéis',
              backgroundColor: Colors.blue[700]),
        ],
        onTap: (pagina) {
          pc.animateToPage(pagina,
              duration: Duration(microseconds: 400), curve: Curves.ease);
        },
      ),
    );
  }
}
