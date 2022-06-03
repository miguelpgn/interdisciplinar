import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class FigPage extends StatefulWidget {
  @override
  State<FigPage> createState() {
    return FigPageState();
  }
}

class FigPageState extends State<FigPage> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  String FName = "", FImage = "", FUser = "", FCont = "";

  @override
  void initState()
  {
    super.initState();
    getFigData();
  }

  Future<void> getFigData() async {
    final SharedPreferences sp = await _pref;

    setState(() {
      FName = sp.getString("_nameFig")!;
      FImage = sp.getString("_imagem")!;
      FUser = sp.getString("_username")!;
      FCont = sp.getString("_contato")!;
    });
  }

  void launchWhatsapp({@required number, @required message}) async {
    String _url = "https://wa.me/$number";
   await launch(_url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 168, 36),
      appBar: AppBar(
        title: const Text('Detalhes', style: TextStyle(color: Colors.black, fontSize: 30)),
        backgroundColor: const Color.fromARGB(255, 250, 235, 32),
      ),
      body: Center(
        child: Container(
          width: 400,
          height: 590,
          child:Card(
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40), // if you need this
          side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
            ),
          ),         
              child: Column(
                    children: <Widget>[
                      Text('\n'),
                      Image(
                        width: 470,
                        height: 470,
                        image: NetworkImage(FImage)),
                      Text(FName, style: TextStyle(fontSize: 20)),
                      Text("Vendedor: "+FUser, style: TextStyle(fontSize: 20)),
                      GestureDetector(
                        onTap: (){
                          launchWhatsapp(number: FCont, message: "oi");
                        },
                        child: Text("WhatsApp", style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 5, 52, 109), decoration: TextDecoration.underline)),
                      )
                    ],
                  ),
        ),
      ),
      ),
    );
  }
}
