import 'package:flutter/material.dart';
import 'package:interdisciplinar/db/usuario_database.dart';
import 'package:interdisciplinar/model/usuario.dart';
//import 'package:toast/toast.dart';

class NovoUsuarioPage extends StatefulWidget {
  @override
  State<NovoUsuarioPage> createState() {
    return NovoUsuarioPageState();
  }
}

//https://www.youtube.com/watch?v=olnurZylCzc
class NovoUsuarioPageState extends State<NovoUsuarioPage> {

  String username = "", userphone = "", userpass = "", confirmpass = "";
  final formKey = new GlobalKey<FormState>();

  signUp(String UName, String UPhone, String UPass, String UCPass) 
  {
    if (UName == "")
    {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Usuário não confirmada")));
    }
    else if (UPhone == "")
    {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Telefone não inserido")));
    }
    else if (UPass == "")
    {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Senha não foi inserida")));
    }
    else if (UPass != UCPass)
    {
      debugPrint('ERRO: Senha não confirmada');
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("ERRO: Senha não confirmada")));
    }
    else
    {
      final user = Usuario(
      name: UName,
      telefone: UPhone,
      senha: UPass);

      UsuarioDatabase.instance.create(user);
    }
    /*final form = formKey.currentState;
    if(UName.isEmpty)
    {
      Toast.show("Insira um nome", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
    else if(UPhone.isEmpty)
    {
      Toast.show("Insira um telefone", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
    else if(UPass.isEmpty)
    {
      Toast.show("Insira uma senha", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
    
    if (formKey.currentState.validate())
    {
      formKey.currentState.save();

      final user = Usuario(
      name: UName,
      telefone: UPhone,
      senha: UPass);

      UsuarioDatabase.instance.create(user);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 168, 36),
      appBar: AppBar(
        title: const Text('Novo Usuário', style: TextStyle(color: Colors.black, fontSize: 30)),
        backgroundColor: const Color.fromARGB(255, 250, 235, 32),
      ),
      body: Form(
        key: formKey,
        child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               TextField(
                onChanged: (val){
                  username = val;
                },
                autofocus: true,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.white, fontSize: 30),
                decoration: InputDecoration(
                  labelText:"Nome do usuário",
                  labelStyle: TextStyle(color: Colors.black),
                )
              ),
              TextField(
                onChanged: (val){
                  userphone = val;
                },
                autofocus: true,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white, fontSize: 30),
                decoration: InputDecoration(
                  labelText:"Telefone do usuário",
                  labelStyle: TextStyle(color: Colors.black),
                )
              ),
              TextField(
                onChanged: (val){
                  userpass = val;
                },
                autofocus: true,
                obscureText: true,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.white, fontSize: 30),
                decoration: InputDecoration(
                  labelText:"Senha do usuário",
                  labelStyle: TextStyle(color: Colors.black),
                )
              ),
              TextField(
                onChanged: (val){
                  confirmpass = val;
                },
                autofocus: true,
                obscureText: true,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.white, fontSize: 30),
                decoration: InputDecoration(
                  labelText:"Confirmar senha",
                  labelStyle: TextStyle(color: Colors.black),
                )
              ),
              const SizedBox(height: 15),
              ButtonTheme(
                height: 60.0,
                child: RaisedButton(
                  onPressed: () => {signUp(username, userphone, userpass, confirmpass)},
                  shape: RoundedRectangleBorder(borderRadius:
                  BorderRadius.circular(30.0)),
                  child: const Text(
                    "Criar",
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