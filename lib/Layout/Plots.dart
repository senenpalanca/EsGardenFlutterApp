import 'package:flutter/cupertino.dart';
import 'package:flutter_login1/Layout/Home.dart';
import 'package:flutter_login1/Layout/Panel.dart';
import 'package:flutter_login1/Structure/Orchard.dart';
import 'package:flutter_login1/UI/CardPlot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login1/Layout/createPlot.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_login1/Structure/Plot.dart';
import 'package:flutter_login1/Library/Globals.dart' as Globals;

class PlotsOfGarden extends StatelessWidget {
  final FirebaseDatabase _databasePlots = FirebaseDatabase.instance;
  List plots = new List();
  Orchard OrchardKey;
  PlotsOfGarden({Key key, @required this.OrchardKey}) : super(key: key);

  Future<String> getDataFromFuture() async {
    return new Future.delayed(Duration(milliseconds: 500), () => "WaitFinish");
  }

  void _manageMenuOptions(int value) {
    if (value == 2) {
      // _showDialog();
    }
  }

  void _showDeleteDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Delete Garden " + OrchardKey.key),
          content: new Text("Are you sure you want to delete this garden?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                final _database = FirebaseDatabase.instance.reference();
                final databaseReference =
                    _database.child("usuarios").child(OrchardKey.key).remove();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _handleData();

    return Scaffold(
        appBar: AppBar(
          title: Text(OrchardKey.key),
          actions: <Widget>[
            PopupMenuButton<int>(
                onSelected: _manageMenuOptions,
                enabled: Globals.isAdmin,
                itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        enabled: false,
                        value: 1,
                        child: Text(
                          "Options",
                          style: TextStyle(color: Colors.green, fontSize: 16.0),
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        enabled: Globals.isAdmin,
                        child: FlatButton(
                          onPressed: () {
                            _showDeleteDialog(context);
                          },
                          child: Text(
                            "Delete Garden",
                            style: TextStyle(
                                color: Colors.black45, fontSize: 18.0),
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FormPlot(
                                        OrchardKey: OrchardKey,
                                      )),
                            );
                          },
                          child: Text(
                            "Create Plot",
                            style: TextStyle(
                                color: Colors.black45, fontSize: 18.0),
                          ),
                        ),
                      ),
                    ]),

            /*IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormPlot(OrchardKey: OrchardKey,)),
                );
              },
            ),*/
          ],
          backgroundColor: Colors.green,
        ),
        body: FutureBuilder(
          future: getDataFromFuture(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Container(
                color: Colors.white,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(10.0),
                  children:
                      plots.map<Widget>((data) => _buildItem(data)).toList(),
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  _handleData() {
    DatabaseReference usuarios = _databasePlots.reference().child('usuarios');
    DatabaseReference usuario = usuarios.reference().child(OrchardKey.key);
    usuario.reference().child('sensorData').onChildAdded.listen(_onNewPlot);
  }

  _onNewPlot(Event event) {
    Plot n = Plot.fromSnapshot(event.snapshot);
    plots.add(n);
  }

  Widget _buildItem(Plot target) {
    if (target != null) {
      return CardPlot(target);
    }
    return Container();
  }
}
