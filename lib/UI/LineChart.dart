import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_login1/Library/Globals.dart';
import 'package:flutter_login1/Structure/DataElement.dart';

class LineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  int highest;
  int lowest;

  LineChart( this.seriesList, this.highest, this.lowest, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory LineChart.createData(Color color, List data, String type, int maxValue) {
    return new LineChart(
      _createData(color, data, type),
      maxValue,
      0,
      animate: true,
    );
  }
  factory LineChart.createDoubleData(List data, List dataTypes, int maxValue) {
    return new LineChart(
      _createDoubleData( data, dataTypes),
      maxValue,
      0,
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
          //HIDE Domain Axis:
          renderSpec: new charts.NoneRenderSpec(),
//          renderSpec: charts.SmallTickRendererSpec(
//            // Tick and Label styling here.
//            labelStyle: new charts.TextStyleSpec(
//              color: charts.MaterialPalette.black,
//            )
//          ),
            tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(

                day: new charts.TimeFormatterSpec(

                    format: 'h', transitionFormat: 'HH')))

        /// Assign a custom style for the measure axis.

        );
  }

  /// Create one series with sample hard coded data.


  static List<charts.Series<TimeSeriesValue, DateTime>> _createData(
      Color color, List<DataElement> data, String type,) {
    List<DataElement> DataElements = new List<DataElement>.from(data);
    DataElements.removeWhere((value) => value == null);
    final List<TimeSeriesValue> dataList = [];
    //dataList.add(new TimeSeriesValue(DateTime.now(), 10));

    for (var i = 0; i < DataElements.length; i++) {
      int j = DataElements[i].Types.indexOf(CATALOG_TYPES[type.toLowerCase()]);
      if (j != -1) {
        dataList.add(new TimeSeriesValue(
            DataElements[i].timestamp, DataElements[i].Fields[j]));
      }
    }

    return [
      new charts.Series<TimeSeriesValue, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.Color(
            r: color.red,
            g: color.green,
            b: color.blue,
            a: color.alpha),
        areaColorFn: (_, __) =>charts.Color(
            r: color.red,
            g: color.green,
            b: color.blue,
            a: color.alpha).lighter.lighter,
        domainFn: (TimeSeriesValue item, _) => item.time,
        measureFn: (TimeSeriesValue item, _) => item.value,
        data: dataList,
      )
    ];
  }

  static List<charts.Series<TimeSeriesValue, DateTime>> _createDoubleData(
      List<DataElement> data, List<String> types) {

    List<DataElement> DataElements = new List<DataElement>.from(data);
    DataElements.removeWhere((value) => value == null);
    final List<TimeSeriesValue> dataList1 = [];
    final List<TimeSeriesValue> dataList2 = [];


    for (var i = 0; i < DataElements.length; i++) {
      int j = DataElements[i].Types.indexOf(CATALOG_TYPES[types[0].toLowerCase()]);
      if (j != -1) {
        dataList1.add(new TimeSeriesValue(
            DataElements[i].timestamp, DataElements[i].Fields[j]));
      }
      int k = DataElements[i].Types.indexOf(CATALOG_TYPES[types[1].toLowerCase()]);
      if (k != -1) {
        dataList2.add(new TimeSeriesValue(
            DataElements[i].timestamp,  DataElements[i].Fields[k] - DataElements[i].Fields[j]  ));
      }
    }

    return [
      new charts.Series<TimeSeriesValue, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.cyan.shadeDefault.darker,
        areaColorFn: (_, __) => charts.MaterialPalette.cyan.shadeDefault.lighter,
        domainFn: (TimeSeriesValue item, _) => item.time,
        measureFn: (TimeSeriesValue item, _) => item.value,
        data: dataList1,
      ),
      new charts.Series<TimeSeriesValue, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        areaColorFn: (_, __) => charts.MaterialPalette.blue  .shadeDefault.lighter,
        domainFn: (TimeSeriesValue item, _) => item.time,
        measureFn: (TimeSeriesValue item, _) => item.value,
        data: dataList2,
      )
    ];
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
