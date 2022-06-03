import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:interdisciplinar/db/figurinha_database.dart';
import 'package:interdisciplinar/model/figurinha.dart';
import 'package:interdisciplinar/widgets/fig.dart';
import 'package:interdisciplinar/widgets/user.dart';
import 'package:interdisciplinar/widgets/carrinho.dart';
import 'package:interdisciplinar/widgets/figUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  
  String UName = "";
  late List<Figurinha> figurinhas;
  bool isLoading = false;

  @override
  void initState()
  {
    super.initState();
    RefreshFigs();
  }

  Future RefreshFigs() async {
    final SharedPreferences sp = await _pref;

    setState(() {
      UName = sp.getString("_name")!;
    });

    setState((() => isLoading = true));

    this.figurinhas = await FigurinhaDatabase.instance.readFigHomePag(UName);

    setState((() => isLoading = false));
  }

  Future setSP(Figurinha figurinha) async
  {
    final SharedPreferences spf = await _pref;

    spf.setString("_nameFig", figurinha.name);
    spf.setString("_imagem", figurinha.imagem);
    spf.setString("_username", figurinha.username);
    spf.setString("_contato", figurinha.contato);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text('Navegação', style: TextStyle(fontSize: 25)),
            ),
            ListTile(
              title: const Text('Usuário'),
              onTap: () {
                debugPrint('Página do usuário');
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => UserPage())
                );
              },
            ),
            /*ListTile(
              title: const Text('Lista de Desejos'),
              onTap: () {
                debugPrint('Lista de Desejos');
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CarrinhoPage())
                );
              } 
            ),*/
            ListTile(
              title: const Text('Minhas Figurinhas'),
              onTap: () {
                debugPrint('Figurinhas do Usuário');
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FigUserPage())
                );
              },
            )
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 168, 36),
      appBar: AppBar(
        title:  Text('Home Page', style: TextStyle(color: Colors.black, fontSize: 30)),
        backgroundColor: const Color.fromARGB(255, 250, 235, 32),
      ),
      body: Center(
        child: isLoading
        ? CircularProgressIndicator()
        : figurinhas.isEmpty
        ? Text("Sem figurinhas...")
        : buildFigs()
        )
    );
  }

  Widget buildFigs() => StaggeredGridView.countBuilder(
    padding: EdgeInsets.all(8),
    itemCount: figurinhas.length,
    staggeredTileBuilder: (index) => StaggeredTile.fit(2),
    crossAxisCount: 4,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    itemBuilder: (context, index) {
      final fig = figurinhas[index];

      return GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FigPage())
                  );
          RefreshFigs();
        },
        child: Card(
          child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                debugPrint('clicou no card');
                FigurinhaDatabase.instance.getFigPage(fig.name).then((FigData){
                  if (FigData != null) {
                    setSP(FigData).whenComplete(() {
                      Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => FigPage()));
                    });
                  }
                  else
                  {
                    debugPrint('Impossível abrir');
                  }
                }).catchError((error){
                  print(error);
                  debugPrint('Get error');
                });
              },
              child: Column(
                children: <Widget>[
                  Text(fig.name),
                  Image(
                    width: 150,
                    height: 150,
                    image: NetworkImage(fig.imagem)),
                  Text(fig.username)
                ],   
              ),
            )
        ),
      );
    },
  );
}