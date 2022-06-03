import 'package:flutter/material.dart';

class CarrinhoPage extends StatefulWidget {
  @override
  State<CarrinhoPage> createState() {
    return CarrinhoPageState();
  }
}

class CarrinhoPageState extends State<CarrinhoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 168, 36),
      appBar: AppBar(
        title: const Text('Lista de Desejos', style: TextStyle(color: Colors.black, fontSize: 30)),
        backgroundColor: const Color.fromARGB(255, 250, 235, 32),
      ),
      body: Center(
        
        child: Card(
          color: const Color.fromARGB(255, 46, 60, 255),
          child: Column(
                children: const <Widget>[
                  Text("Sua Lista",style: TextStyle(color: Colors.white, fontSize: 15)),
                ],
              ),
        ),
      
      ),
    );
  }
}