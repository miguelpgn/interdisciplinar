import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  @override
  State<UserPage> createState() {
    return UserPageState();
  }
}

class UserPageState extends State<UserPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 168, 36),
      appBar: AppBar(
        title: const Text('Usuário', style: TextStyle(color: Colors.black, fontSize: 30)),
        backgroundColor: const Color.fromARGB(255, 250, 235, 32),
      ),
      body: Center(
        child: Container(
          height: 480,
          child:Card(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40), // if you need this
          side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
            ),
          ),
          color: const Color.fromARGB(255, 46, 60, 255),
          
          child: Column(
                children: <Widget>[
                  const Image(
                    width: 350,
                    height: 350,
                    image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Breezeicons-actions-22-im-user.svg/1200px-Breezeicons-actions-22-im-user.svg.png')),
                  Text('Nome de usuario: $UName', style: TextStyle(color: Colors.white, fontSize: 20)),
                  Text('Contato: $UPhone', style: TextStyle(color: Colors.white, fontSize: 20)),
                ],   
              ),
        ),
      ),
      ),
    );
  }
}