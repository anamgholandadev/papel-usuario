import 'package:flutter/material.dart';
import 'package:userpapeis/pages/custom_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
          title: const Text("Página Inicial"),
        ),
        body: const Center(
          child: Text(
            "Bem-vindo",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.purple),
          ),
        ),
      ),
    );
  }
}
