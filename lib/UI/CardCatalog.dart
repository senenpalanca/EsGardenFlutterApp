import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_login1/Structure/CatalogItem.dart';
import 'package:flutter_login1/Structure/Orchard.dart';

class CardCatalog extends StatelessWidget{


  String Key;
  String Descr;
  String img;
  int TempMax;
  int TempMin;
  CatalogItem catalogItem;

  CardCatalog(this.catalogItem);

  createAlertDialog(BuildContext context){
    return  showDialog(context: context,builder:(context){
      return AlertDialog(
        title: Text(Key),
        content: Text(Descr),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    //key = catalogItem.Key;
    img = catalogItem.Img;
    Descr = catalogItem.Description;
    Key = catalogItem.key;
    TempMax = catalogItem.tmpMax;
    TempMin = catalogItem.tmpMin;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: new Card(

          child: GestureDetector(
            onTap: (){
              createAlertDialog(context);
            },
            child: Material(
                color: Colors.white,
                elevation: 5.0,

                shadowColor: Color(0x802196F3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: myDetailsContainer(),
                      ),
                    ),

                    Container(
                      width: 100,
                      height: 90,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          //borderRadius: new BorderRadius.only(topRight: Radius.circular(24.0), bottomRight: Radius.circular(24.0)),
                          child: Image(
                            fit: BoxFit.fill,
                            alignment: Alignment.topRight,
                            image: NetworkImage(
                                img),
                          ),
                        ),
                      ),),
                  ],)
            ),
          )
        ),
      ),
    );
  }

  Widget myDetailsContainer() {
    return Padding(
      padding: const EdgeInsets.only(right: 1.0),
      child: Column(

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(child: Text(Key,
              style: TextStyle(color: Color(0xffe6020a), fontSize: 24.0,fontWeight: FontWeight.bold),)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(child: Text("Min "+TempMin.toString()+"º C \u00B7 ",
                      style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),

                    Container(child: Text("Max "+TempMax.toString()+"º C",
                      style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
                  ],)),
          ),

        ],
      ),
    );
  }
}
