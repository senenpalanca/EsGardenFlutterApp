import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_login1/Library/Globals.dart';
import 'package:flutter_login1/Structure/DataElement.dart';
import 'package:flutter_login1/Structure/Orchard.dart';
import 'package:flutter_login1/Structure/Plot.dart';

class SimpleLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  int highest;
  int lowest;
  SimpleLineChart(this.seriesList, this.highest, this.lowest, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory SimpleLineChart.createDataTemperature(List data, int maxValue) {
    return new SimpleLineChart(
      _createDataTemperature(data),
      maxValue,
      0,
      animate: true,
    );
  }
  factory SimpleLineChart.createDataLuminosity(List data, int maxValue) {
    return new SimpleLineChart(
      _createDataLuminosity(data),
      maxValue,
      0,
      animate: true,
    );
  }
  factory SimpleLineChart.createDataHumidity(
      List data1, List data2, int maxValue) {
    return new SimpleLineChart(
      _createDataHumidity(data1, data2),
      100,
      0, //
      animate: true,
    );
  }
  factory SimpleLineChart.createDataCO2(List data, int maxValue) {
    return new SimpleLineChart(
      _createDataCO2(data),
      maxValue, //
      0, //_getLowestValue(plot.CO2),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(seriesList,
        defaultRenderer: new charts.LineRendererConfig(
            includeArea: true,
            stacked: true,
            includePoints: true,
            includeLine: true),
        animate: false,
        behaviors: [
          new charts.PanAndZoomBehavior(),
          new charts.SlidingViewport(),
        ],
        primaryMeasureAxis: new charts.NumericAxisSpec(
          showAxisLine: false,
          tickProviderSpec:
              new charts.BasicNumericTickProviderSpec(desiredTickCount: 4),
          //viewport:  charts.NumericExtents(0,highest),
          renderSpec: new charts.GridlineRendererSpec(
              //minimumPaddingBetweenLabelsPx: 25,
              // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 13, // size in Pts.
                  color: charts.MaterialPalette.black),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.transparent)),
        ),
        domainAxis: new charts.DateTimeAxisSpec(
            tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
                day: new charts.TimeFormatterSpec(
                    format: 'h', transitionFormat: 'HH')))

        /// Assign a custom style for the measure axis.

        );
  }

  /// Create one series with sample hard coded data.

  static List<charts.Series<TimeSeriesValue, DateTime>> _createDataTemperature(
      List<DataElement> data) {
// final data = [
//   new DataItem(0, 5),
//   new DataItem(1, 25),
//   new DataItem(2, 100),
//   new DataItem(3, 75),
// ];

    List<DataElement> DataElements = new List<DataElement>.from(data);
    DataElements.removeWhere((value) => value == null);
    final List<TimeSeriesValue> dataList = [];
    //dataList.add(new TimeSeriesValue(DateTime.now(), 10));

    for (var i = 0; i < DataElements.length; i++) {
      int j = DataElements[i].Types.indexOf(CATALOG_TYPES["upperHumidity"]);
      if (j != -1) {
        dataList.add(new TimeSeriesValue(
            DataElements[i].timestamp, DataElements[i].Fields[j]));
      }
    }

    return [
      new charts.Series<TimeSeriesValue, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        areaColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.lighter,
        domainFn: (TimeSeriesValue item, _) => item.time,
        measureFn: (TimeSeriesValue item, _) => item.value,
        data: dataList,
      )
    ];
  }

  static List<charts.Series<DataItem, int>> _createDataLuminosity(List data) {
// final data = [
//   new DataItem(0, 5),
//   new DataItem(1, 25),
//   new DataItem(2, 100),
//   new DataItem(3, 75),
// ];

    List installment = new List<int>.from(data);
    installment.removeWhere((value) => value == null);
    final List dataList = <DataItem>[];
    for (var i = 0; i < installment.length; i++) {
      dataList.add(new DataItem(i, installment[i]));
    }
    return [
      new charts.Series<DataItem, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
        areaColorFn: (_, __) =>
            charts.MaterialPalette.yellow.shadeDefault.lighter,
        domainFn: (DataItem sales, _) => sales.no,
        measureFn: (DataItem sales, _) => sales.value,
        data: dataList,
      )
    ];
  }

  static List<charts.Series<TimeSeriesValue, DateTime>> _createDataCO2(
      List<DataElement> data) {
// final data = [
//   new DataItem(0, 5),
//   new DataItem(1, 25),
//   new DataItem(2, 100),
//   new DataItem(3, 75),
// ];

    List<DataElement> DataElements = new List<DataElement>.from(data);
    DataElements.removeWhere((value) => value == null);
    final List<TimeSeriesValue> dataList = [];
    //dataList.add(new TimeSeriesValue(DateTime.now(), 10));

    for (var i = 0; i < DataElements.length; i++) {
      int j = DataElements[i].Types.indexOf(CATALOG_TYPES["CO2"]);
      if (j != -1) {
        dataList.add(new TimeSeriesValue(
            DataElements[i].timestamp, DataElements[i].Fields[j]));
      }
    }

    return [
      new charts.Series<TimeSeriesValue, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        areaColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.lighter,
        domainFn: (TimeSeriesValue item, _) => item.time,
        measureFn: (TimeSeriesValue item, _) => item.value,
        data: dataList,
      )
    ];
  }

  static List<charts.Series<DataItem, int>> _createDataHumidity(
      List data1, List data2) {
// final data = [
//   new DataItem(0, 5),
//   new DataItem(1, 25),
//   new DataItem(2, 100),
//   new DataItem(3, 75),
// ];

    List installment = new List<int>.from(data1);
    installment.removeWhere((value) => value == null);
    final List dataList = <DataItem>[];
    int n1 = 0;
    for (var i = 0; i < installment.length; i++) {
      if (installment[i] != null) {
        dataList.add(new DataItem(n1, installment[i]));
        n1++;
      }
    }
    List installment2 = new List<int>.from(data2);
    installment2.removeWhere((value) => value == null);
    final List dataList2 = <DataItem>[];
    int n2 = 0;
    for (var i = 0; i < installment2.length; i++) {
      if (installment[i] != null) {
        dataList2.add(new DataItem(n2, installment2[i]));
        n2++;
      }
    }
    return [
      new charts.Series<DataItem, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.cyan.shadeDefault.darker,
        areaColorFn: (_, __) =>
            charts.MaterialPalette.cyan.shadeDefault.lighter,
        domainFn: (DataItem sales, _) => sales.no,
        measureFn: (DataItem sales, _) => sales.value,
        data: dataList2,
      ),
      new charts.Series<DataItem, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        areaColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
        domainFn: (DataItem sales, _) => sales.no,
        measureFn: (DataItem sales, _) => sales.value,
        data: dataList,
      )
    ];
  }

  static int _getLowestValue(List entrada) {
    List installment = entrada;
    int lowest = 100000;

    for (var i = 0; i < installment.length; i++) {
      if (installment[i] < lowest) {
        lowest = installment[i];
      }
    }
    return lowest;
  }
}

/// Sample linear data type.
class DataItem {
  final int no;
  final int value;

  DataItem(this.no, this.value);
}

class TimeSeriesValue {
  final DateTime time;
  final int value;

  TimeSeriesValue(this.time, this.value);
}
