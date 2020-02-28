import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:monitor/Api/LastScore.dart';
import 'package:monitor/Api/ScoreList.dart';

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory SimpleTimeSeriesChart.withSampleData(ScoreList scoreList) {
    return new SimpleTimeSeriesChart(
      _createSampleData(scoreList),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(

      seriesList,
      animate: animate,
      animationDuration: Duration(seconds: 2),

      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData(ScoreList scoreList) {

    List<TimeSeriesSales> data = new List();

    for(ScoreListElement x in scoreList.scoreList){
      data.add(new TimeSeriesSales(x.date, (x.rapport*100).floor()),);
    }
    data.add(new TimeSeriesSales(data.last.time.add(Duration(minutes: 10)), 100)) ;

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        measureFormatterFn:(TimeSeriesSales sales, _) => format,
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,

        data: data,
      )
    ];
  }

 static String format(num number){
    return  number.round().toString()+"%" ;
  }

}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}