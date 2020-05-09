import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Cálculo de IMC",
    home: Home(),

  ));

}

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _pesoController = TextEditingController();
  TextEditingController _alturaController = TextEditingController();
  String _msgText = "Informe os dados!";
  GlobalKey<FormState> _formChave = GlobalKey<FormState>();

  void _calcularImc() {
    double peso = double.parse(_pesoController.text);
    double altura = double.parse(_alturaController.text);
    double imc = peso * altura/2;

    setState(() {
      _msgText = "O IMC é de: ${imc.toStringAsPrecision(4)} ";
    });
  }

  void resetarCampos() {
    _pesoController.clear();
    _alturaController.clear();
    setState(() {
      _msgText = "Informe os dados!";
      _formChave = GlobalKey<FormState>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              "Cálculo de IMC",
              style: TextStyle(fontSize: 25.0)
          ),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: resetarCampos
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formChave,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline,
                    size: 120.0, color: Colors.blueGrey
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (Kg)",
                    labelStyle: TextStyle(
                        color: Colors.blueGrey, fontSize: 25.0
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 25.0),
                  controller: _pesoController,
                  validator: (value) {
                    if (value.isEmpty) {
                      // ignore: missing_return
                      return "Informe o peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (Cm)",
                    labelStyle: TextStyle(
                        color: Colors.blueGrey, fontSize: 25.0
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 25.0),
                  controller: _alturaController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Informe a altura!";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                      height: 50.0,
                      child: RaisedButton(
                          onPressed: () {
                            if (_formChave.currentState.validate()) {
                              _calcularImc();
                            } else {
                              setState(() {
                                _msgText = "Informe os dados!";
                              });
                            }
                          },
                          child: Text(
                              "Calcular",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25.0)
                          ),
                          color: Colors.blueGrey
                      )

                  ),

                ),
                Text(
                  _msgText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 25.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}