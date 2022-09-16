import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(), //stateful widget para podermos interagir
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _tamanhoTextoCampoDeTexto = 25.0;
  double _tamanhoFonteTextoInfo = 30.0;
  double _tamanhoFonteBotao = 20.0;
  double _paddingBotao = 30.0;
  double _paddingScrollView = 30.0;

  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String _textoInfo = "Informe seus dados";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields(){
    _formKey = GlobalKey<FormState>();

    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _textoInfo = "Informe seus dados";
    });
  }

  void _calcular(){
    setState(() {
      double peso = double.parse(pesoController.text); //transformando o texto em double
      double altura = double.parse(alturaController.text) / 100.0; //por 100 pois a altura precisa ser em metros

      double imc = peso / (altura * altura);

      //alterando o info
      if(imc < 18.5){
        _textoInfo = "Abaixo do peso";
      } else if(imc == 18.5 || imc < 25){
        _textoInfo = "Peso normal";
      } else if(imc == 25 || imc < 30){
        _textoInfo = "Sobrepeso";
      } else if(imc == 30 || imc < 35){
        _textoInfo = "Obesidade grau 1";
      } else if(imc == 35 || imc < 40){
        _textoInfo = "Obesidade grau 2";
      } else if(imc >= 40){
        _textoInfo = "Obesidade grau 3";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                tooltip: 'Reinicia tudo paizão', //ao segurar o butão
                onPressed: _resetFields
            ),
          ]),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(_paddingScrollView, 0.0, _paddingScrollView, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //esticar para preencher
            children: <Widget>[
              Icon(Icons.person_outline, size: 100.0, color: Colors.blue),
              TextFormField(
                  keyboardType: TextInputType.number, //aciona o teclado numérico
                  decoration: InputDecoration(//rotulo do campo de texto
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(
                        color: Colors.blueGrey, fontSize: _tamanhoTextoCampoDeTexto),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blueGrey, fontSize: _tamanhoTextoCampoDeTexto),
                  controller: pesoController,
                  validator: (value){
                      if(value.toString().isEmpty){
                        return "Insira o peso";
                      }
                      if(double.parse(value.toString()) > 500){
                        return "Digite um valor válido";
                      }
                      if(double.parse(value.toString()) == 0){
                        return "Digite um valor válido";
                      }
                      if(double.parse(value.toString()) == null){
                        return "Digite um valor válido";
                      }
                }, //validator
              ),
              TextFormField(
                  keyboardType: TextInputType.number, //aciona o teclado numérico
                  decoration: InputDecoration(
                    //rotulo do campo de texto
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(
                        color: Colors.blueGrey, fontSize: _tamanhoTextoCampoDeTexto),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blueGrey, fontSize: _tamanhoTextoCampoDeTexto),
                  controller: alturaController,
                validator: (value){
                  if(value.toString().isEmpty){
                    return "Insira o peso";
                  }
                  if(double.parse(value.toString()) > 300){
                    return "Digite um valor válido";
                  }
                  if(double.parse(value.toString()) == 0){
                    return "Digite um valor válido";
                  }
                  if(double.parse(value.toString()) == null){
                    return "Digite um valor válido";
                  }
                }, //validator
              ),
              Padding(
                padding: EdgeInsets.only(top: _paddingBotao, bottom: _paddingBotao),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    child: Text('Calcular',
                        style: TextStyle(fontSize: _tamanhoFonteBotao)),
                    onPressed: () {
                      if(_formKey.currentState!.validate()){ //se meu formulário estiver validado
                        _calcular();
                      }
                    },
                  ),
                ),
              ),
              Text(
                "$_textoInfo",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: _tamanhoFonteTextoInfo,
                ),
                textAlign: TextAlign.center,
              ),
              //Testar dps
              /*IconButton(
                icon: Icon(Icons.filter_drama),
                onPressed: () {},
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
