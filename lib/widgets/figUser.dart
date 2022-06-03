import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:interdisciplinar/db/figurinha_database.dart';
import 'package:interdisciplinar/model/figurinha.dart';
import 'package:interdisciplinar/widgets/novaFig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FigUserPage extends StatefulWidget {
  @override
  State<FigUserPage> createState() {
    return FigUserPageState();
  }
}

class FigUserPageState extends State<FigUserPage> {
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

    this.figurinhas = await FigurinhaDatabase.instance.readUserFigurinha(UName);

    setState((() => isLoading = false));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 168, 36),
      appBar: AppBar(
        title: const Text('Suas Figurinhas', style: TextStyle(color: Colors.black, fontSize: 30)),
        backgroundColor: const Color.fromARGB(255, 250, 235, 32),
      ),
      body: Center(
        child: isLoading
        ? CircularProgressIndicator()
        : figurinhas.isEmpty
        ? Text("Sem figurinhas...")
        : buildFigs()
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Add figurinha');
          Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NovaFigPage())
                );
        },
        backgroundColor: const Color.fromARGB(255, 46, 60, 255),
        child: const Icon(Icons.add),
      ),
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
          
          RefreshFigs();
        },

        child: Card(
          child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                debugPrint('clicou no card');
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