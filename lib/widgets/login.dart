// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:interdisciplinar/db/usuario_database.dart';
import 'package:interdisciplinar/model/usuario.dart';
import 'package:interdisciplinar/widgets/home.dart';
import 'package:interdisciplinar/widgets/novoUsuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  String username = "", userpass = "";

  Login(String UName, String UPass) async
  {
    if(UName == "")
    {
      debugPrint('Nome não foi inserido');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Insira o nome de usuário")));
    }
    else if(UPass == "")
    {
      debugPrint('Senha não foi inserida');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Insira a senha do usuário")));
    }
    else
    {
      await UsuarioDatabase.instance.getLoginUser(UName, UPass).then((UserData){
        if (UserData != null) {
          setSP(UserData).whenComplete(() {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()));
          });
        }
        else
        {
          debugPrint('Usuário não encontrado');
        }
      }).catchError((error){
        print(error);
        debugPrint('Login Error');
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Combinação usuário e senha incorreta")));
      });
    }
  }

  Future setSP(Usuario user) async
  {
    final SharedPreferences sp = await _pref;

    sp.setString("_name", user.name);
    sp.setString("_telefone", user.telefone);
    sp.setString("_senha", user.senha);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 168, 36),
      appBar: AppBar(title: const Text("Login", style: TextStyle(color: Colors.black, fontSize: 30)), backgroundColor: const Color.fromARGB(255, 250, 235, 32)),
      body: Padding(
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
              const SizedBox(height: 15),
              ButtonTheme(
                height: 60.0,
                child: RaisedButton(
                  onPressed: () => { debugPrint("clicou no botão"),
                  Login(username, userpass) 
                    },
                  shape: RoundedRectangleBorder(borderRadius:
                  BorderRadius.circular(30.0)),
                  child: const Text(
                    "Enviar",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ), //Text
                  color:const Color.fromARGB(255, 46, 60, 255),
                ),//RaisedButton
              ),//ButtonTheme
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  debugPrint('Novo usuário');
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => NovoUsuarioPage())
                  );
                },
                child: const Text("novo usuário", style: TextStyle(color: Color.fromARGB(255, 6, 33, 65),fontSize: 20, decoration: TextDecoration.underline), textAlign: TextAlign.center),
              ),
            ],
         ),
        ),
      )     
    );
  }
}