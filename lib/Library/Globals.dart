library globals;

import "package:firebase_database/firebase_database.dart";
import "package:flutter_login1/Structure/CatalogItem.dart";
import "package:flutter_login1/Structure/Orchard.dart";

bool isLogged = false;
bool isAdmin;
List<Orchard> orchards = new List();
List<CatalogItem> catalog = new List();
List months = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];

const Map<String, String> CATALOG_TYPES = const {
  "soilhumidity": "00",
  "upperhumidity": "01",
  "lowerhumidity": "02",
  "co2": "03",
  "soiltemperature": "04",
  "luminosity": "05",
  "ambienttemperature": "06",
  "relativenoise": "07",
  "ambienthumidity": "08",
};

const Map<String, String> CATALOG_NAMES = const {
  "00": "Soil Humidity",
  "01": "Upper Humidity",
  "02": "Lower Humidity",
  "03": "Air Quality",
  "04": "Soil Temperature",
  "05": "Luminosity",
  "06": "Ambient Temperature",
  "07": "Relative Noise",
  "08": "Ambient Humidity"
};
const Map<String, String> CATALOG_NAMES2 = const {
  //AMBIENTE
  "00": "Soil Humidity", //Luminosidad
  "01": "Upper Humidity", //Temp ambiente
  "02": "Lower Humidity", //Hum. ambiente
  "03": "Air Quality", //PH
  "04": "Soil Temperature", //Ruido relativo
  "05": "Luminosity", //Calidad del aire
  "06": "Ambient Temperature", //Pluviometría
  "07": "Relative Noise", //Viento
  //PLOTS
  "08": "Ambient Humidity" // Temp suelo, hum suelo,

};

const Map<String, String> MEASURING_UNITS = const {
  "upperhumidity": "%",
  "lowerhumidity": "%",
  "co2": "PPM",
  "soiltemperature": "º C",
  "soilhumidity": "%",
  "luminosity": "Lux",
  "ambienttemperature": "º C",
  "ambienthumidity": "%",
  "relativenoise": " units"
};

const Map<String, List<String>> VALUE_RELATION = const {
  "soilhumidity": ["upperhumidity", "lowerhumidity"],
};
