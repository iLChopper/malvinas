import 'package:Malvinas/models/ambo.dart';
import 'package:Malvinas/models/talle.dart';
import 'package:flutter/material.dart';
import 'BO/dao.dart';

class Detalle extends StatefulWidget {
  final Ambo ambo;

  Detalle({Key key, this.ambo}) : super(key: key);

  @override
  _DetalleState createState() => _DetalleState();
}

class _DetalleState extends State<Detalle> {
  List<String> _telas = ['Arciel', 'Batista', 'Spandex'];
  String tipoTela = 'Arciel';

  final talles = <Talle>[
    Talle('XS', 2.0),
    Talle('S', 2.0),
    Talle('M', 2.0),
    Talle('L', 2.0),
    Talle('XL', 2.0),
    Talle('XXL', 2.0),
    Talle('XXXL', 2.0),
    Talle('S/T', 2.0)
  ];

  int _tallesChaqueta = 0;
  int _tallesPantalon = 0;
  @override
  Widget build(BuildContext context) {
    // Usa el objeto Todo para crear nuestra UI
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.ambo.nombre),
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0)))),
        body: Padding(
            padding: EdgeInsets.all(2.0),
            child: Stack(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Chaqueta",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.bold,
                              fontSize: 30)),
                      for (var i = 0; i < talles.length; i++)
                        _tallesC(talles[i], i)
                    ],
                  ),
                  SizedBox(width: 40),
                  Column(children: <Widget>[
                    Text("Pantalón",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.bold,
                            fontSize: 30)),
                    for (var i = 0; i < talles.length; i++)
                      _tallesP(talles[i], i)
                  ])
                ]),
                Positioned(
                    bottom: 80,
                    left: 80,
                    child: Row(children: [
                      Container(
                        width: 200,
                        child: DropdownButton<String>(
                          value: tipoTela,
                          isExpanded: true,
                          elevation: 50,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                          items: <String>['Arciel', 'Batista', 'Spandex']
                              .map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: Center(
                                  child: new Text(value,
                                      textAlign: TextAlign.center)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              tipoTela = value;
                              print(tipoTela);
                            });
                          },
                        ),
                      )
                    ])),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Expanded(
                            child: TextButton(
                                onPressed: () {
                                  //llamar al bo y cargar ambo luego dar mensaje
                                  showAlertDialog(context);
                                },
                                child: Text("Enviar",
                                    style: TextStyle(color: Colors.white)),
                                style: TextButton.styleFrom(
                                    textStyle: TextStyle(fontSize: 25),
                                    fixedSize: Size(50, 80),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.0))),
                                    backgroundColor: Colors.black,
                                    elevation: 30,
                                    shadowColor: Colors.black)))
                      ],
                    ))
              ],
            )));
  }

  Widget _tallesC(Talle t, pos) {
    return Container(
        width: 120,
        child: RadioListTile(
            dense: true,
            selectedTileColor: Colors.white,
            title: Text(
              t.nombre,
              style: TextStyle(color: Colors.white),
            ),
            value: pos,
            groupValue: _tallesChaqueta,
            tileColor: Colors.grey,
            onChanged: (value) {
              setState(() {
                _tallesChaqueta = value;
              });
            }));
  }

  Widget _tallesP(Talle t, pos) {
    return Container(
        width: 120,
        child: RadioListTile(
            selectedTileColor: Colors.white,
            tileColor: Colors.grey,
            dense: true,
            title: Text(
              t.nombre,
              style: TextStyle(color: Colors.white),
            ),
            value: pos,
            groupValue: _tallesPantalon,
            onChanged: (value) {
              setState(() {
                _tallesPantalon = value;
              });
            }));
  }

/*
  void _confirmacion() {
    SimpleDialog(
      title: Text('Confirmar'),
      children: [
        SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, 'Main');
            },
            child: Text('Confirmar')),
        SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, 'Main');
            },
            child: Text('Cancelar'))
      ],
    );
  }*/
  //Confirmacion si fue cargado con exito
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pushNamed(context, '/inicio');
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmación"),
      content: Text("Ambo Cargado"),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
