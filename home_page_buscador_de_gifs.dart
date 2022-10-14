import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gifs_api/ui/gif_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Image.network(
              snapshot.data["data"][index]["images"]["fixed_height"]["url"],
              height: 300.0,
              fit: BoxFit.cover,
            ),
          );
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
    if(_search == null){
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
        title: Image.network("https://miro.medium.com/max/640/1*FQtt6g_7dxYh1gkmNt20EQ.jpeg"),
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
