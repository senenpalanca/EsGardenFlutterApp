import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login1/Structure/Orchard.dart';
import 'package:flutter_login1/UI/CardGarden.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login1/Structure/CatalogItem.dart';
import '../UI/PersonalizedField.dart';
import '../Library/Globals.dart' as Globals;


class FormGarden extends StatefulWidget {
  @override
  FormGardenState createState () => FormGardenState();
}

class FormGardenState extends State<FormGarden> {

  final nameContoller = TextEditingController();
  final cityContoller = TextEditingController();
  final imgContoller = TextEditingController();
  final _database = FirebaseDatabase.instance.reference();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        floatingActionButton: createGardenButton(context),
        appBar: AppBar(
          title: Text("Create new Garden"),
         )
    ,   body: Form(
          child: formUI()),);
  }

  @override
  void dispose() {
    nameContoller.dispose();
    cityContoller.dispose();
    imgContoller.dispose();
    super.dispose();
  }

  Widget formUI(){

    return Container(
      color: Colors.green,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: ListView(
          children: <Widget>[
            Container(

              height: 600,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset('images/esGardenIconv2.png',width: 300.0,),
                    PersonalizedField2(nameContoller,"Name of the Garden", false,Icon(Icons.note_add, color: Colors.white)),
                    PersonalizedField2(cityContoller,"City of the Garden",false,Icon(Icons.location_city, color: Colors.white)),
                    //PersonalizedField2(vegetableContoller,"Vegetables to plant",false,Icon(Icons.assignment, color: Colors.white)),
                    PersonalizedField2(imgContoller,"Image URL Logo",false,Icon(Icons.assignment, color: Colors.white)),



                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget createGardenButton(BuildContext context){
    return new FloatingActionButton.extended(
      onPressed: () {
        if(!_ValidateFields()){
          showDialog(context: context,builder:(context){
            return AlertDialog(
              title: Text("Error with some Fields"),
              content: Text("Some fields where empty or with errors"),
            );
          });
        }else{
          showDialog(context: context,builder:(context){
            return AlertDialog(
              title: Text("Garden Created"),
              content: Text("The garden "+nameContoller.text+" has been created!"),
            );
          });
        }
      },
      label: Text('Create Garden',style: TextStyle(fontSize: 20.0),),
      icon: Icon(Icons.thumb_up),
      backgroundColor: Colors.deepOrange,
    );
  }

  bool _ValidateFields(){
    String name= nameContoller.text;
    String city= cityContoller.text;
    //String vegetable= vegetableContoller.text;
    String image= imgContoller.text;
    if(name.length>0&&city.length>0&&image.length>=0){
      print("Fields validated");
      createRecord();
      return true;
    }else{
      print("Fields not validated");
      return false;
    }
}

  void createRecord(){
    String img = imgContoller.text;
    if(img.length==0){
      img="https://northgwinnettcoop.org/wp-content/uploads/2017/06/Fresh-Fruits-Vegetables.jpg";
    }
    final databaseReference =_database.child("usuarios");
    databaseReference.child(nameContoller.text).set({
      'City': cityContoller.text,
      //'Vegetable': vegetableContoller.text,
      //'Alerts' : {"C1" : [ "No Notifications" ],"H1" : [ "No notifications"], "T1" : [ "No notifications"]},
      "Humidity30" : [ 0,0,0,0,0,0,0,0,0,0,0,0],
      "Humidity40" : [ 0,0,0,0,0,0,0,0,0,0,0,0 ],
      "Latitude" : "41.643641",
      "Longitude" : "-0.879529",
      "Temperature" : [0,0,0,0,0,0,0,0,0,0,0,0],
      "CO2" : [0,0,0,0,0,0,0,0,0,0,0,0],
      "Img" :img,
      "sensorData" : {
        "General" : {
          "Name": "General",
          "Data" : {

          },
          "Alerts" : {
            "C1" : [ "No Notifications" ],
            "H1" : [ "No notifications" ],
            "T1" : [ "No notifications" ]
          },
          "City" : cityContoller.text,
          "Items" : ["Ambient Temperature", "Air Quality", "Ambient Humidity", "Luminosity"],
          "Img" : img,
          "Parent" : nameContoller.text,
          "Vegetable" : "General"
        },
        "Nursery" : {
          "Name": "Nursery",
          "Data" : {

          },
          "Alerts" : {
            "C1" : [ "No Notifications" ],
            "H1" : [ "No notifications" ],
            "T1" : [ "No notifications" ]
          },
          "City" : cityContoller.text,
          "Items" : ["Ambient Temperature", "Air Quality", "Ambient Humidity"],
          "Img" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS00nWqHZ57mt3iJ0TOKJ1_V3b7tgG6vzmjmljFavacyCc1fsvd&s",
          "Parent" : nameContoller.text,
          "Vegetable" : "General"
        },
        "SoilCompost" : {
          "Name": "Compost",
          "Data" : {

          },
          "Alerts" : {
            "C1" : [ "No Notifications" ],
            "H1" : [ "No notifications" ],
            "T1" : [ "No notifications" ]
          },
          "City" : cityContoller.text,
          "Items" : ["Compost Temperature", "Compost Humidity", "Air Quality"],
          "Img" : "https://www.trustvets.com/uploads/news-pictures/665-saint-paul-blog-post-image-20160304101125.png",
          "Parent" : nameContoller.text,
          "Vegetable" : "General"
        }
      }
    });


  }
  String _getDate(DateTime now){

    String day;
    String month =  Globals.months[now.month-1];;
    String year = now.year.toString();
    if(now.day.toInt()<10){
      day='0'+now.day.toString();
    } else day = now.day.toString();


    return(day+month+year);

  }
}
