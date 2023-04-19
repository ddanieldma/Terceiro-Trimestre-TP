import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_share/flutter_share.dart';


class GifPage extends StatelessWidget {

  final Map _gifData; //qual gif será apresentado

  GifPage(this._gifData); //construtor

  Future<void> share() async{
    await FlutterShare.share(
        title: 'GIF', linkUrl:_gifData["title"]["fixed_height"]["url"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_gifData["title"]),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: (){
              share();
            }, )
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(_gifData["images"]["fixed_height"]["url"]),
      ),
    );
  }
}






