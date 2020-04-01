import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login1/Structure/Orchard.dart';
import 'package:flutter_login1/Structure/Plot.dart';
import 'package:flutter_login1/UI/CardGarden.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login1/Structure/CatalogItem.dart';
import 'package:flutter_login1/UI/PersonalizedField.dart';
import 'package:flutter_login1/Library/Globals.dart' as Globals;

import 'package:flutter_login1/Structure/Vegetable.dart';

class FormPlot extends StatefulWidget {
  Orchard OrchardKey;
  List<Vegetable> vegetables;
  List<Plot> plots;
  FormPlot({Key key, @required this.OrchardKey}) : super(key: key);

  @override
  FormPlotState createState() {
    vegetables = new List<Vegetable>();
    plots = new List<Plot>();
    // if(!vegetables.isEmpty){vegetables.clear();}
    final _database = FirebaseDatabase.instance.reference();
    final databaseReferenceVegetable =
        _database.child("Vegetable").onChildAdded.listen(_onNewVegetable);
    final databaseReferencePlot = _database
        .child("usuarios")
        .child(OrchardKey.key)
        .child("sensorData")
        .onChildAdded
        .listen(_onNewPlot);
    return FormPlotState();
  }

  _onNewVegetable(Event event) {
    Vegetable n = Vegetable.fromSnapshot(event.snapshot);
    vegetables.add(n);
  }

  _onNewPlot(Event event) {
    Plot n = Plot.fromSnapshot(event.snapshot);
    plots.add(n);
  }
}

class FormPlotState extends State<FormPlot> {
  List<String> vegetableNames;
  final nameContoller = TextEditingController();
  final imgContoller = TextEditingController();
  final vegetableContoller = TextEditingController();
  final _database = FirebaseDatabase.instance.reference();
  String vegetableValue = '0';

  Future<String> getDataFromFuture() async {
    return new Future.delayed(Duration(milliseconds: 1000), () => "WaitFinish");
  }

  @override
  Widget build(BuildContext context) {
    //print(vegetableNames);
    return FutureBuilder(
        future: getDataFromFuture(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            vegetableNames = widget.vegetables.map((Vegetable v) {
              return (v.name);
            }).toList();

            return Scaffold(
              floatingActionButton: createGardenButton(context),
              appBar: AppBar(
                title: Text("Create new Plot"),
              ),
              body: formUI(),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  @override
  void dispose() {
    nameContoller.dispose();
    imgContoller.dispose();
    vegetableContoller.dispose();
    super.dispose();
  }

  Widget formUI() {
    return Container(
      color: Colors.green,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: ListView(
          children: <Widget>[
            Container(
              height: 500,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Image.asset(
                      'images/esGardenIconv2.png',
                      width: 300.0,
                    ),
                    PersonalizedField2(nameContoller, "Name of the Plot", false,
                        Icon(Icons.note_add, color: Colors.white)),
                    //PersonalizedField2(cityContoller,"City of the Plot",false,Icon(Icons.location_city, color: Colors.white)),
                    //PersonalizedField2(vegetableContoller,"Vegetables to plant",false,Icon(Icons.assignment, color: Colors.white)),
                    //PersonalizedField2(imgContoller,"Image URL Logo",false,Icon(Icons.image, color: Colors.white)),
                    Container(
                      width: 310,
                      child: Material(
                          elevation: 5.0,
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0,
                                    left: 8.0,
                                    right: 8.0,
                                    bottom: 16.0),
                                child: Icon(
                                  Icons.library_books,
                                  color: Colors.white,
                                ),
                              ),
                              /*Container(
                                width: 170,
                                child: TextField(


                                  //obscureText: this.obscureText,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))),
                                    fillColor: Colors.white,
                                    filled: true,
                                    //hintText: this.hintText,


                                  ),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,

                                  ),
                                ),
                              ),*/
                              Material(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0)),
                                child: Container(
                                  width: 270,
                                  height: 58,
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: DropdownButton<String>(
                                          value: vegetableValue,
                                          items: <String>[
                                            '0',
                                            '1',
                                            '2',
                                            '3',
                                            '4'
                                          ].map((String value) {
                                            return new DropdownMenuItem<String>(
                                              value: value,
                                              child: _createDropDownItem(value),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              vegetableValue = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _createDropDownItem(String value) {
    switch (value) {
      case '0':
        return new Text(
          _getTextVegetable(value),
          style: TextStyle(fontSize: 20.0, color: Colors.black54),
          textAlign: TextAlign.center,
        );
        break;
      default:
        return new Text(
          _getTextVegetable(value),
          style: TextStyle(fontSize: 20.0, color: Colors.black54),
          textAlign: TextAlign.center,
        );
        break;
    }
    return new Text(
      _getTextVegetable(value),
      style: TextStyle(fontSize: 20.0, color: Colors.black54),
      textAlign: TextAlign.center,
    );
  }

  String _getTextVegetable(String num) {
    if (int.parse(num) > 0) {
      return widget.vegetables[int.parse(num) - 1].name;
    }
    return "Select a Vegetable";
  }

  Widget createGardenButton(BuildContext context) {
    return new FloatingActionButton.extended(
      onPressed: () {
        if (!_ValidateFields()) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Error with some fields!!"),
                  content:
                      Text("Check your fields, maybe your name it's used yet."),
                );
              });
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Plot Created"),
                  content: Text(
                      "The plot " + nameContoller.text + " has been created!"),
                );
              });
        }
      },
      label: Text(
        'Create Plot',
        style: TextStyle(fontSize: 20.0),
      ),
      icon: Icon(Icons.thumb_up),
      backgroundColor: Colors.deepOrange,
    );
  }

  bool _ValidateFields() {
    String name = nameContoller.text;
    String vegetable = vegetableValue;
    String image = imgContoller.text;

    if (widget.OrchardKey.plots[name] == null) {
      if (name.length > 0 && vegetableValue != "0") {
        print("Fields validated");
        createRecord();
        return true;
      } else {
        print("Fields not validated");
        return false;
      }
    } else
      return false;
  }

  String _getDate(DateTime now) {
    String day;
    String month = Globals.months[now.month - 1];
    ;
    String year = now.year.toString();
    if (now.day.toInt() < 10) {
      day = '0' + now.day.toString();
    } else
      day = now.day.toString();

    return (day + month + year);
  }

  void createRecord() {
    final databaseReference = _database.child("usuarios");
    final databaseOrchard = databaseReference.child(widget.OrchardKey.key);
    final databasePlot = databaseOrchard.child("sensorData");
    var set =
        databasePlot.child("plot " + (widget.plots.length - 2).toString()).set({
      "Name": nameContoller.text,
      "Alerts": {
        "C1": ["No Notifications"],
        "H1": ["No notifications"],
        "T1": ["No notifications"]
      },
      "Data": {},
      "City": widget.OrchardKey.City,
      "Img": widget.vegetables[int.parse(vegetableValue) - 1]
          .Img, //La llave del misterio
      "Items": ["Vegetable"],
      "Parent": widget.OrchardKey.key,
      "Vegetable": _getTextVegetable(vegetableValue),
      "VegetableIndex": vegetableValue,
    });
  }
}
