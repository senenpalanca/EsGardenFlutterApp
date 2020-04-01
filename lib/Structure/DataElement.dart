import 'package:firebase_database/firebase_database.dart';

class DataElement {
  String key;
  int Field1;
  int Field2;
  int Field3;
  int Field4;
  List Fields;
  List Types;
  String FieldType1;
  String FieldType2;
  String FieldType3;
  String FieldType4;

  DateTime timestamp;

  DataElement(this.Field1, this.FieldType1);

  DataElement.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        Field1 = snapshot.value["F1"],
        Field2 = snapshot.value["F2"],
        Field3 = snapshot.value["F3"],
        Field4 = snapshot.value["F"],
        Fields = _createFields(snapshot),
        Types = _createTypes(snapshot),
        FieldType1 = snapshot.value["T1"],
        FieldType2 = snapshot.value["T2"],
        FieldType3 = snapshot.value["T3"],
        FieldType4 = snapshot.value["T4"],
        timestamp = DateTime.fromMillisecondsSinceEpoch(
            snapshot.value["timestamp"],
            isUtc: true);

  toJson() {
    return {
      "key": key,
      "timestamp": timestamp.toString(),
    };
  }

  static List _createFields(DataSnapshot snapshot) {
    List fields = [];
    for (int i = 1; i < 5; i++) {
      fields.add(snapshot.value["F" + i.toString()]);
    }
    return fields;
  }

  static List _createTypes(DataSnapshot snapshot) {
    List fields = [];
    for (int i = 1; i < 5; i++) {
      fields.add(snapshot.value["T" + i.toString()]);
    }
    return fields;
  }
}
