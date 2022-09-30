import 'package:flutter/material.dart';

//Lista de itens do dropdown
const List<String> dropDownItems = <String>[
  "Adulto",
  "Criança ou adolescente",
  "Gestante ou lactante",
  "Sensível á cafeína"
];

const List<Widget> coffeesList = <Widget>[
  Text('Espresso'),
  Text('Coado')
];

void main() {
  runApp(MaterialApp(
    home: Home(),//stateful widget para podermos interagir
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //tamanhos de fontes, paddings e ícones
  double _tamanhoTextoCampoDeTexto = 25.0;
  double _tamanhoFonteTextoInfo = 30.0;
  double _tamanhoFonteBotao = 20.0;
  double _paddingBotao = 30.0;
  double _paddingScrollView = 30.0;
  double _tamanhoIcone = 100.00;
  double _alturaContainerBotao = 50.00;

  //controllers
  TextEditingController cafeController = TextEditingController();

  //Dropdown
  String _dropdownValue = dropDownItems.first;

  //Toggle button
  final List<bool> _selectedCoffee = <bool>[true, false];
  bool vertical = false;

  //Texto final
  String _textInfo = "Informe os dados";

  //Chave do formulário
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields(){
    setState(() {
      _formKey = GlobalKey<FormState>();
      cafeController.text = "";
      _textInfo = "Informe seus dados";
    });
  }

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String){
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }

  void _calcularCafe(){
    setState(() {
      String perfil = _dropdownValue;
      int doses = int.parse(cafeController.text); //transformando texto em double
      int cafeina = 0;

      if(_selectedCoffee.first){
        cafeina = doses * 60;
      }
      else{
        cafeina = doses * 85 * 2;
      }

      //alterando o info
      if(perfil == dropDownItems[0] && cafeina > 400){
        _textInfo = "Dose diária recomendada excedida";
      }
      else if(perfil == dropDownItems[0]  && cafeina <= 400){
        _textInfo = "Tudo certo";
      }
      if(perfil == dropDownItems[1] && cafeina > 100){
        _textInfo = "Dose diária recomendada excedida";
      }
      else if(perfil == dropDownItems[1] && cafeina <= 100){
        _textInfo = "Tudo certo";
      }
      if(perfil == dropDownItems[2] && cafeina > 200){
        _textInfo = "Dose diária recomendada excedida";
      }
      else if(perfil == dropDownItems[2] && cafeina <= 200){
        _textInfo = "Tudo certo";
      }
      if(perfil == dropDownItems[3] && cafeina > 200){
        _textInfo = "Dose diária recomendada excedida";
      }
      else if(perfil == dropDownItems[3] && cafeina <= 200){
        _textInfo = "Tudo certo";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cafezin?", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.brown,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: 'Reiniciar',
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(_paddingScrollView, 0.0, _paddingScrollView, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //esticar para preencher
            children: <Widget>[
              Icon(Icons.coffee, size: _tamanhoIcone, color: Colors.brown),
              Container(
                width: 50.00,
                child: DropdownButton<String>(
                  //textAlign: TextAlign.center,
                  icon: const Icon(Icons.arrow_downward),
                  style: const TextStyle(color: Colors.brown),
                  underline: Container(
                    height: 1,
                    color: Colors.brown,
                  ),
                  items:
                    dropDownItems.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  value: _dropdownValue,
                  onChanged: dropdownCallback,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number, //aciona o teclado numérico
                decoration: InputDecoration(//rotulo do campo de texto
                  labelText: "Quantos cafés?",
                  labelStyle: TextStyle(
                      color: Colors.brown,
                      fontSize: _tamanhoTextoCampoDeTexto
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.brown,
                    fontSize: _tamanhoTextoCampoDeTexto
                ),
                controller: cafeController,
                validator: (value){
                  if(value.toString().isEmpty){
                    return "Insira a quantidade";
                  }
                  if(double.parse(value.toString()) < 0){
                    return "Digite um valor válido";
                  }
                  if(double.parse(value.toString()) == null){
                    return "Digite um valor válido";
                  }
                }, //validator
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: Center(
                  child:ToggleButtons(
                    direction: vertical ? Axis.vertical : Axis.horizontal,
                    onPressed: (int index) {
                      setState(() {
                        // The button that is tapped is set to true, and the others to false.
                        for (int i = 0; i < _selectedCoffee.length; i++) {
                          _selectedCoffee[i] = i == index;
                        }
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.brown[700],
                    selectedColor: Colors.black,
                    fillColor: Colors.brown[400],
                    color: Colors.brown,
                    constraints: const BoxConstraints(
                      minHeight: 40.0,
                      minWidth: 80.0,
                    ),
                    isSelected: _selectedCoffee,
                    children: coffeesList,
                    ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: _paddingBotao, bottom: _paddingBotao),
                child: Container(
                  height: _alturaContainerBotao,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.brown[400]),
                    ),
                    child: Text('Calcular o cafezinho',
                        style: TextStyle(
                            fontSize: _tamanhoFonteBotao,
                            color: Colors.black,
                        ),
                    ),
                    onPressed: () {
                      if(_formKey.currentState!.validate()){ //se meu formulário estiver validado
                        _calcularCafe();
                      }
                    },
                  ),
                ),
              ),
              Text(
                "$_textInfo",
                style: TextStyle(
                  color: Colors.brown[400],
                  fontSize: _tamanhoFonteTextoInfo,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
