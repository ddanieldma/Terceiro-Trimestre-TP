//biblioteca material design para coisas bonitinhas
import 'package:flutter/material.dart';

void main() {
  //comando para rodar o aplicativo
  runApp(MaterialApp(
    //instancia do widget que ele vai rodar
      title: "Contando os alunos", //usado internamente
      home: Home()
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _numAlunos = 0;
  String _textoFinal = "CodiguinhoTop";

  void _change(int increment){
    setState(() {
      _numAlunos += increment;
    });
    if(_numAlunos < 0){
      _textoFinal = "Não existem alunos negativos!";
    }
    else if(_numAlunos >= 35){
      _textoFinal = "Turma lotada";
    }
    else{
      _textoFinal = "Codiguinho top";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      //colocar widgets um em cima do outro
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Alunos: $_numAlunos",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextButton(
                child: Text(
                  "-",
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
                onPressed: () {
                  _change(-1);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextButton(
                child: Text(
                  "+",
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
                onPressed: () {
                  _change(1);
                },
              ),
            ),
          ],
        ),
        Text(
          "$_textoFinal",
          style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontSize: 30.0),
        )
      ],
    );
  }
}
