import 'package:flutter/material.dart';
import 'package:interdisciplinar/db/figurinha_database.dart';
import 'package:interdisciplinar/model/figurinha.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NovaFigPage extends StatefulWidget {
  @override
  State<NovaFigPage> createState() {
    return NovaFigPageState();
  }
}

class NovaFigPageState extends State<NovaFigPage> {

  String figname = "", figimage = "";

  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  String UName = "", UPhone = "";

  @override
  void initState()
  {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;

    setState(() {
      UName = sp.getString("_name")!;
      UPhone = sp.getString("_telefone")!;
    });
  }

  NewFig(String FName, String FImage) 
  {
    final fig = Figurinha(
      name: FName,
      imagem: FImage,
      username: UName,
      contato: UPhone);

    FigurinhaDatabase.instance.create(fig);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 168, 36),
      appBar: AppBar(
        title: const Text('Nova Figurinha', style: TextStyle(color: Colors.black, fontSize: 30)),
        backgroundColor: const Color.fromARGB(255, 250, 235, 32),
      ),
      body: Form(
        child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               TextField(
                onChanged: (val){
                  figname = val;
                },
                autofocus: true,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.white, fontSize: 30),
                decoration: InputDecoration(
                  labelText:"Nome",
                  labelStyle: TextStyle(color: Colors.black),
                )
              ),
              TextField(
                onChanged: (val){
                  figimage = val;
                },
                autofocus: true,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.white, fontSize: 30),
                decoration: InputDecoration(
                  labelText:"Link Imagem",
                  labelStyle: TextStyle(color: Colors.black),
                )
              ),
              const SizedBox(height: 15),
              ButtonTheme(
                height: 60.0,
                child: RaisedButton(
                  onPressed: () => {NewFig(figname, figimage)},
                  shape: RoundedRectangleBorder(borderRadius:
                  BorderRadius.circular(30.0)),
                  child: const Text(
                    "Adicionar",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  color:const Color.fromARGB(255, 46, 60, 255),
                ),
              ),
            ]
    )))
      )
      );
  }
}