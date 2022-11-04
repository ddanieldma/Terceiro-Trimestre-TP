import 'package:flutter/material.dart';
import 'package:share/share.dart' ; //PRECISAMOS ACRESCENTAR UMA DEPENDENCIAimport 'package:flutter_share/flutter_share.dart';
import 'package:transparent_image/transparent_image.dart';

class GifPage extends StatelessWidget {
  final Map _gifData;
  const GifPage(this ._gifData, {super.key});

  Future<void> share() async {
    await FlutterShare.share(
        title: 'GIF', linkUrl: (_gifData["images"]["fixed_height"]["url"]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_gifData["title"]),
        actions: [
          IconButton(icon: const Icon(Icons.share),
              onPressed: (){
                Share.share(_gifData["images"]["fixed_height"]["url"]);
              })
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: FadeInImage.memoryNetwork(
            key: UniqueKey(),
            placeholder: kTransparentImage,
            image: _gifData["images"]["fixed_height"]["url"],
            height: 300.0,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

