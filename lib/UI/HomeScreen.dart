import 'package:monitor/Api/Tips.dart';
import 'package:monitor/Api/memories.dart';
import 'package:monitor/Api/tasks.dart';
import 'package:monitor/Constant/Strings.dart';
import 'package:monitor/Constant/colors.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Contact/ContactUI.dart';
import 'Emergency/Emergency.dart';
import 'Memories/MemoryDetails.dart';
import 'Storage/Storage.dart';
import 'Tasks/TaskDetails.dart';
import 'Tasks/tasksUI.dart';
import 'Tips/TipCategory.dart';
import 'User/User.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {






  List<ImageProvider> images = new List();
  Memories memories ;
  List<List<ListElement>> days  = new List();
  double headerSize = 100 ;
  Widget tasksHolder ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: c1,
        child:  Column(
          children: <Widget>[
            _getHeader(),
            _getBody()
          ],
        ),
      ) ,
    );
  }


  @override
  void initState() {
    loadTips();
    loadTasks();
  }

  Widget _getBody() {
    return Container(


      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
            topLeft:   Radius.circular(70.0)

        )
        ,
        boxShadow: [
          new BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            spreadRadius:0.2,
            offset: new Offset(-3, -2.0),
          )
        ],),
      child: Container(
        margin: EdgeInsets.only(top: 40),
          height: MediaQuery.of(context).size.height-headerSize-40,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getAlz(),
                Container( margin : EdgeInsets.symmetric(horizontal: 20 , vertical: 10) ,child: Text("Daily Tasks" , style: TextStyle(fontSize: 40),),),
                tasksHolder==null?Container():tasksHolder ,
                Container( margin : EdgeInsets.symmetric(horizontal: 20 , vertical: 10) ,child: Text("Memory Game Score", style: TextStyle(fontSize: 40),),),
                getChart(),
                Container( margin : EdgeInsets.symmetric(horizontal: 20 , vertical: 10) ,child: Text("Tips", style: TextStyle(fontSize: 40),),),
                getTips(),
                Container(height: 100,)
              ],),
          )
      ),
    );
  }

  Widget _getHeader(){
    return Container(
      height: headerSize,
    );
  }

  Widget _getDaysList(){
    return
    tasks==null?Container():
        Container(
          height: 500,
        margin: EdgeInsets.only(left: 10),
        child  :
         new ListView.builder
          (
          scrollDirection: Axis.horizontal,
            itemCount: days.length , //litems.length,
            itemBuilder: (BuildContext ctxt, int index) => getDay(days[index],index)
        ),);

  }

 Widget getDay(List<ListElement> item  , int day) {

    return Container(

      height: 400,
      width: 350,
      margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
            topLeft:   Radius.circular(70.0),
            topRight:   Radius.circular(70.0),
            bottomLeft:   Radius.circular(70.0),
            bottomRight:   Radius.circular(70.0)

        )
        ,
        boxShadow: [
          new BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            spreadRadius:0.2,
            offset: new Offset(-3, -2.0),
          )
        ],),
      child: Container(
        child: Column(

          children: <Widget>[

            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TaskDetails(item)),
                );
              },
              child: Container(

                height: 100,
                width: 350,

                decoration: new BoxDecoration(
                  gradient: LinearGradient(
                    // Where the linear gradient begins and ends
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    // Add one stop for each color. Stops should increase from 0 to 1
                    stops: [0.4, 0.7, 0.8, 1],
                    colors: [
                      // Colors are easy thanks to Flutter's Colors class.

                      Color.lerp(c1, Colors.white, 0.0),
                      Color.lerp(c1, Colors.white, 0.5),
                      Color.lerp(c1, Colors.white, 0.7),
                      Color.lerp(c1, Colors.white, 0.9),
                    ],
                  ),
                  borderRadius: new BorderRadius.only(
                      topLeft:   Radius.circular(70.0),
                      topRight:   Radius.circular(70.0)
                  )
                  ,
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                      spreadRadius:0.2,
                      offset: new Offset(-3, -2.0),
                    )
                  ],),
                child: Container(

                 child: Container(
                     margin: EdgeInsets.only(top: 35 , left: 35),
                     child:
                 Text(getDayName(day),style: TextStyle(fontSize: 28 , color: Colors.white , fontWeight: FontWeight.bold),)

                 ),

                ),
              ),
            ),
            getTasks(item)

          ],

        ),

      ),
    );

 }

  Widget getTasks(List<ListElement> list){
   return  list==null ? Container():Container(
     height: 300,
     child: new ListView.builder
       (
         scrollDirection: Axis.vertical,
         itemCount: list.length, //litems.length,
         itemBuilder: (BuildContext ctxt, int index) => getOneTask(list[index])
     )
   );
  }


  Widget getOneTask(ListElement item){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Row(children: <Widget>[
          Checkbox(value: item.done ,onChanged: (val){
            if(item.done){
              setUnDone(item.id.toString());
            }else{
              setDone(item.id.toString());
            }
            setState(() {
              item.done = ! item.done ;
            });
          },) ,
          Text(item.title ,style: TextStyle(fontSize: 20 , color: Colors.black54),)
        ],) ,
        Padding(
          padding: const EdgeInsets.only(left :50.0),
          child: Text(item.time,textAlign: TextAlign.left,style: TextStyle(color: Colors.grey),),
        )
      ],),
    );
  }


  Widget getAlz(){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => User()),
        );
      },
      child: Container(

        height: 200,
        width: 500,
        margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
        decoration: new BoxDecoration(
          color: Color.lerp(c1, Colors.white, 0.8),
          borderRadius: new BorderRadius.only(
              topLeft:   Radius.circular(80.0),
              topRight:   Radius.circular(30.0),
              bottomLeft:   Radius.circular(30.0),
              bottomRight:   Radius.circular(30.0)

          )
          ,
          boxShadow: [
            new BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              spreadRadius:0.2,
              offset: new Offset(-3, -2.0),
            )
          ],),
        child: Container(
          child: Row(

            children: <Widget>[
              getUserImage(),
              getUserDetails()
            ],

          ),

        ),
      ),
    );
  }


Widget getUserImage(){
    return  Container(
      margin: EdgeInsets.only(left: 20),
      child: new ClipRRect(
        borderRadius: new BorderRadius.only(
            topLeft:   Radius.circular(80.0),
            topRight:   Radius.circular(30.0),
            bottomLeft:   Radius.circular(30.0),
            bottomRight:   Radius.circular(30.0)

        ),
        child: Image.asset(
          "assets/oldman.jpg",
          height: 180.0,
          width: 180.0,
          fit: BoxFit.cover,
        ),
      ),
    ) ;
}

Widget getUserDetails(){
    return Container(
      margin: EdgeInsets.all(20),
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
        Container(child: Text("Mr. Bean" , style: TextStyle(fontSize: 30),),) ,
        Container(child: Text("Device: Connected 📳" , style: TextStyle(fontSize: 20),),) ,
        ],)
      ,);

}

Widget getTips(){
  return tips==null? Container():
    Container(
      height: 300,
      margin: EdgeInsets.only(left: 10),
      child  :
      new ListView.builder
        (
          scrollDirection: Axis.horizontal,
          itemCount: tips.lists.length , //litems.length,
          itemBuilder: (BuildContext ctxt, int index) =>  getTipCategory(tips.lists[index])
    ),);

}


  Tips tips ;
  Tasks tasks ;

void loadTips() async {

    http.get(baseUrl+"lists").then((http.Response response){

      tips = Tips.fromJson(response.body);

      setState(() {

      });

    }) ;

}

void loadTasks() async {
     tasksHolder =  Container( height: 300, child: Center(child: CircularProgressIndicator())) ;
     setState(() {

     });
     days  = new List();

    await http.get(baseUrl+"getAll").then((http.Response response){

      tasks = Tasks.fromJson(response.body);
      for(int  i = 0 ; i<7 ; i++){
        List<ListElement> temp = new List();
        for(ListElement e in tasks.list) if (e.day==i) temp.add(e);
        days.add(temp) ;
      }
      setState(() {
      tasksHolder = _getDaysList() ;
      });

    }) ;

}

  Widget getTipCategory(TipsList item) {
    return GestureDetector(
      onTap: (){

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TipCatergory(item)),
        );
      },
      child: Container(

        height: 200,
        width: 350,
        margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
              topLeft:   Radius.circular(70.0),
              topRight:   Radius.circular(70.0),
              bottomLeft:   Radius.circular(70.0),
              bottomRight:   Radius.circular(70.0)

          )
          ,
          boxShadow: [
            new BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              spreadRadius:0.2,
              offset: new Offset(-3, -2.0),
            )
          ],),
        child: Container(
          child: Column(

            children: <Widget>[

              Container(

                height: 150,
                width: 350,

                decoration: new BoxDecoration(
                  image: DecorationImage(image: Image.network(item.link,fit: BoxFit.cover,).image,fit: BoxFit.cover),
                  borderRadius: new BorderRadius.only(
                      topLeft:   Radius.circular(70.0),
                      topRight:   Radius.circular(70.0)
                  )
                  ,
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                      spreadRadius:0.2,
                      offset: new Offset(-3, -2.0),
                    )
                  ],),
                child: Container(

                ),
              ),
               Container(height: 100,child: Center(child: Text(item.title,style: TextStyle(fontSize: 25),textAlign: TextAlign.center,))),

            ],

          ),

        ),
      ),
    );

  }



  String getDayName(int day){

  switch(day){
    case 0 : return "Monday" ;
    case 1 : return "Tuesday" ;
    case 2 : return "Wednesday" ;
    case 3 : return "Thursday" ;
    case 4 : return "Friday" ;
    case 5 : return "Saturday" ;
    case 6 : return "Sunday" ;
  }
  return "";
  }

  void setDone(String id) async {
   http.get(baseUrl+"setdone/"+id).then((http.Response response){
     print(response.statusCode);
   });


  }
  void setUnDone(String id) async {
    http.get(baseUrl+"setundone/"+id).then((http.Response response){
      print(response.statusCode);
    });


  }



  Widget getChart(){
  return Container(
    margin: EdgeInsets.all(20),
    height: 300,
    child: Card(child : SimpleTimeSeriesChart.withSampleData()),) ;


  }









}



class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory SimpleTimeSeriesChart.withSampleData() {
    return new SimpleTimeSeriesChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 25),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 100),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 75),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}