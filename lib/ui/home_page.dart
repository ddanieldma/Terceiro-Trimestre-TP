import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gifs_api/ui/gif_page.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _getCount(List data){
    if(_search == null){
      return data.length;
    }
    else{
      return data.length + 1;
    }
  }
  
  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0
        ),
        itemCount: _getCount(snapshot.data["data"]),
        itemBuilder: (context, index) {
          if(_search == null || index < snapshot.data["data"].length) {
            return GestureDetector(
              child: Image.network(
                  snapshot.data["data"][index]["images"]["fixed_height"]["url"],
                  height: 300.0,
                  fit: BoxFit.cover
              ),
              onTap: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GifPage(snapshot.data["data"][index]))
                );
              },
            );
          }
          else{
            return Container(
              child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.add, color: Colors.white, size: 70.0),
                    Text(
                      "Carregar mais...",
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    )
                  ],
                ),
              ),
            );
          }
        }
    );
  }

  String _search = "";
  int _offset = 0;

  //tamanho de fontes e paddings
  double _tamanhoFonteInputPesquisa = 10.0;
  double _tamanhoPaddingInputPesquisa = 10.0;

  _getGifs() async{
    http.Response response;
    if(_search == ""){
      //pega os gifs do trendind, caso o usuário 
      //não tenha pesquisado nada
      response = await http.get(
          Uri.parse("https://api.giphy.com/v1/gifs/trending?api_key=crE11Zk3DyWYXAi6jKh0hkyzcjOYKscq&limit=25&rating=g")
      );
    }
    else{
      //faz a pesquisa com o que for inserido 
      //pelo usuário
      response = await http.get(
          Uri.parse("https://api.giphy.com/v1/gifs/search?api_key=crE11Zk3DyWYXAi6jKh0hkyzcjOYKscq&q=$_search&limit=25&offset=$_offset&rating=g&lang=en")
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: snapshot.data["data"][index]["images"]["fixed_height"]["url"])
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(_tamanhoPaddingInputPesquisa),
              child: TextField(
                decoration: InputDecoration(
                  labelText:"Pesquise aqui",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder()
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: _tamanhoFonteInputPesquisa,
                ),
                textAlign: TextAlign.center,
                onSubmitted: (text){
                  setState(() { //para atualizar o estado do app
                    _search = text;
                  });
                },
              ),
          ),
          Expanded(
              child: FutureBuilder(
                future: _getGifs(),
                builder: (context, snapshot){
                  switch(snapshot.connectionState){
                    case ConnectionState.waiting://nada ainda
                    case ConnectionState.none:
                      return Container(
                        width: 200.0,
                        height: 200.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 5.0,
                        ),
                      );
                    default:
                      if(snapshot.hasError) return Container();
                      else return _createGifTable(context, snapshot);
                  }
                }
              )
          ),
        ],
      ),
    );
    }
}
