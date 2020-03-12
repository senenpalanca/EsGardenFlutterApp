import 'package:flutter/cupertino.dart';
import 'package:flutter_login1/Structure/Orchard.dart';
import 'package:flutter_login1/UI/CardGarden.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login1/Layout/createGarden.dart';
import 'package:flutter_login1/Library/Globals.dart' as Globals;

import 'package:firebase_database/firebase_database.dart';
import '../Structure/Orchard.dart';

class Home extends StatelessWidget {

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  List<Orchard> gardens = new List();

  Home({Key key}) : super(key: key);

  Future<String> getDataFromFuture() async{
    return new Future.delayed(Duration(milliseconds: 1000), ()=>"WaitFinish");
  }

  @override
  Widget build(BuildContext context) {
    _handleData();

    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormGarden()),
                );
              },
            ),
          ],
          backgroundColor: Colors.green,
        ),
        body: FutureBuilder(
          future: getDataFromFuture(),
          builder: (context,snapshot){
            if(snapshot.data!=null){
              return Container(
                  color: Colors.white,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(10.0),
                    children: gardens.map<Widget>((data) => _buildItem(data)).toList(),
                  )
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        )


        );
  }

  CardGarden _buildItem(Orchard target) {

    if (target != null) {
      return CardGarden(target);
    }
  }

  _handleData(){
    DatabaseReference gardensref  = _database.reference().child('usuarios');
    gardensref.reference()
        .onChildAdded.listen(_onNewGarden);
  }
  _onNewGarden(Event event){
    Orchard n = Orchard.fromSnapshot(event.snapshot);
    gardens.add(n);
  }
}
