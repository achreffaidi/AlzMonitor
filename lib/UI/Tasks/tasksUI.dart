import 'dart:async';

import 'package:kf_drawer/kf_drawer.dart';
import 'package:monitor/Api/DeviceState.dart';
import 'package:monitor/Api/Tips.dart';
import 'package:monitor/Api/memories.dart';
import 'package:monitor/Api/tasks.dart';
import 'package:monitor/Constant/Strings.dart';
import 'package:monitor/Constant/colors.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:monitor/Api/tasksByDay.dart' as tsk;


import 'package:charts_flutter/flutter.dart' as charts;
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'TaskDetails.dart';

class TasksUI extends StatefulWidget {
  @override
  _TasksUIState createState() => _TasksUIState();
}


class _TasksUIState extends State<TasksUI> {

  List<List<ListByDay>> days  = new List();
  List<MyExpanded> myList  = new List();
  Widget tasksHolder ;

  double headerSize = 100 ;

  bool mapIsReady = false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child:  Column(
          children: <Widget>[
            _getHeader(),
            _getBody()
          ],
        ),
      ) ,
    );
  }


/*
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

  }  Tasks tasks ;


  Widget getDay(List<ListByDay> item  , int day) {

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
                  MaterialPageRoute(builder: (context) => TaskDetails(_day.dw.selected)),
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
 */

  Widget getOneTask(ListByDay item){
    return Card(
      child: Container(
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
              child: Text(item.time??"",textAlign: TextAlign.left,style: TextStyle(color: Colors.grey),),
            )
          ],),
      ),
    );
  }


  Widget getTasks(List<ListByDay> list){
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
/*
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
  void loadTasks() async {
    tasksHolder =  Container( height: 300, child: Center(child: CircularProgressIndicator())) ;
    setState(() {

    });
    days  = new List();
    myList = new List();
    await http.get(baseUrl+"getAll").then((http.Response response){

      tasks = Tasks.fromJson(response.body);
      for(int  i = 0 ; i<7 ; i++){

        List<ListByDay> temp = new List();
        for(ListByDay e in tasks.listByDay) if (e.day==i) temp.add(e);
        days.add(temp) ;
        myList.add(MyExpanded(temp));
      }
      setState(() {
        tasksHolder = _getDaysList() ;
      });

    }) ;

  }

*/
  Widget _getBody() {
    var now = new DateTime.now();
    var formatter = new DateFormat('EEEE, d MMM y');
    String formatted = formatter.format(now);

    return Container(
      height: MediaQuery.of(context).size.height-headerSize-70,

      child: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Container(
                    margin: EdgeInsets.only(top: 100),

                    height: 150,
                    width: 1e3,

                    decoration: new BoxDecoration(
                      color: Colors.white,

                      borderRadius: new BorderRadius.only(
                        topLeft: new Radius.circular(20.0),
                        bottomLeft: new Radius.circular(20.0),
                        topRight: new Radius.circular(20.0),
                        bottomRight: new Radius.circular(20.0),
                      ),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.grey,
                          offset: new Offset(0.0, 0.0),
                          blurRadius: 10.0,
                        )
                      ],

                    ),
                    child:
                    Column(

                      children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top : 20 , left: 30),
                        child:

                      Row(
                          children: <Widget>[
                            Icon(Icons.calendar_today , color: Colors.lightBlue,) ,
                            Text("  "+formatted , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w500 , color: Colors.blueGrey),)
                          ],
                        ),) ,

                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child:
                          DayWeek()
                          ,)


                      ],

                    ),
                  ),
                ),


                getTasksWidget(),
              ],)
        ),
      ),
    );
  }


  Padding getTasksWidget() {
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Container(
                  margin: EdgeInsets.only(top: 30),

                  height: 500,
                  width: 1e3,

                  decoration: new BoxDecoration(
                    color: Colors.white,

                    borderRadius: new BorderRadius.only(
                      topLeft: new Radius.circular(20.0),
                      bottomLeft: new Radius.circular(20.0),
                      topRight: new Radius.circular(20.0),
                      bottomRight: new Radius.circular(20.0),
                    ),
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.grey,
                        offset: new Offset(0.0, 0.0),
                        blurRadius: 5.0,
                      )
                    ],

                  ),
                  child:
                  Column(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                              onTap:(){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TaskDetails(selected)),
                ).then((value){
                  loadTask(selected);
                });
                } ,
                              child: Text("Details" ,style: TextStyle(fontSize: 23 , fontWeight: FontWeight.w400, color: Colors.blueGrey), textAlign: TextAlign.right,)),


                        ],
                      ),
                    ) ,
                    Container(
                      height: 300,
                      padding: EdgeInsets.symmetric(horizontal: 30 , vertical: 20),
                      child: ListView.builder
                        (
                          itemCount: listTempTask.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return listTempTask[index].getTask();
                          }
                      ),
                    ),
                    Container(
                      height: 60,
                      margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                      child:
                      Column(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(done.toString()+"/"+total.toString()+" Done" , style: TextStyle(fontSize : 20 , color: Colors.blueGrey),)
                            ],
                          ),
                          LinearPercentIndicator(
                            lineHeight: 14.0,
                            percent: (total==0)?0:done/total,
                            backgroundColor: c1,
                            progressColor: Colors.lightBlueAccent,
                          ),
                        ],
                      ),
                    )

                    ],

                  ),
                ),
              );
  }









  Widget _getHeader(){
    return Container(
      height: 20,
      width: 1e5,
    );
  }





  List<bool> listExp  ;












List<TempTask> listTempTask ;
  @override
  void initState() {
    listTempTask  = new List();

    names.add("Sun") ;
    names.add("Mon") ;
    names.add("Tue") ;
    names.add("Wed") ;
    names.add("Thu") ;
    names.add("Fri") ;
    names.add("Sat") ;
    var now = new DateTime.now();
    int day = now.weekday ;
    selected = day ;
    loadTask(selected);

    DateTime ref = now.subtract(Duration(days :day)) ;
    for(int i = 0 ; i<7 ; i++) numbers.add(ref.add(Duration(days:i)).day) ;
    super.initState();
  }

  void loadTask(int day) async {
    print(baseUrl + "getbyday/" + day.toString());
    http
        .get(baseUrl + "getbyday/" + day.toString())
        .then((http.Response response) {
      List<tsk.ListByDay> tasks =
          tsk.TasksByDay.fromJson(response.body).listByDay;
      print(response.body);

      listTempTask = new List() ;
      done = 0 ;
      total = tasks.length  ;
      for(tsk.ListByDay t in tasks){
        listTempTask.add(new TempTask(t.title,t.time,t.done));
        if(t.done) done++;
      }



      setState(() {});
    });
  }




  List<String> names = new List() ;
  List<int>   numbers = new List() ;
  int selected  ;
  int total =0 ;
  int done  = 0 ;


  Widget DayWeek() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          getDay(0),
          getDay(1),
          getDay(2),
          getDay(3),
          getDay(4),
          getDay(5),
          getDay(6),
        ],
      ),
    );
  }

  Widget getDay(int i ){

    double circle = 30 ;

    Widget temp ;
    if(i == selected)
      temp =  Container(
          height: 80,
          child  :
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[

              Container(
                child:
                Text(names[i] , style: TextStyle(fontWeight: FontWeight.w500),),
              ) ,

              Container(
                width: circle,
                height: circle,
                child: new Container(
                  child: Center(
                    child: Text(numbers[i].toString() ,style: TextStyle(fontSize:15 , color: Colors.white), ),
                  ),
                  decoration: new BoxDecoration(

                    gradient: new LinearGradient(
                        colors: [c1, Colors.cyan],
                        begin: Alignment.centerRight,
                        end: new Alignment(-1.0, -1.0)
                    ),

                    shape: BoxShape.circle,

                  ),
                ),
              ),
            ],
          )
      );

    else temp =  Container(
        height: 80,
        child  :
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[

            Container(
              child:
              Text(names[i] , style: TextStyle(fontWeight: FontWeight.w300),),
            ) ,

            Container(
              width: circle,
              height: circle,
              child: new Container(
                child: Center(
                  child: Text(numbers[i].toString() ,style: TextStyle(fontSize:15 , color: Colors.blueGrey), ),
                ),

              ),
            ),
          ],
        )
    );
    return GestureDetector(child: Container(
        width: 60,
        child: temp) , onTap: (){
      selected = i ;
      setState(() {
loadTask(selected);
      });
    }, ) ;

  }





}


class MyExpanded {
  MyExpanded( List<ListByDay> x){
    item = x ;
  }
  List<ListByDay> item ;
  bool isExpanded = false ;
}



class TempTask{

  String name ;
  String time;
  bool done ;
  double circle = 30 ;
  TempTask(this.name, this.time, this.done);

  getTask(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(time+"     "+name , style: TextStyle(fontWeight: FontWeight.w400 , fontSize: 20 , color: Colors.blueGrey),) ,
          (!done)?Container():Container(

            child: new Container(
              width: 40,
              height: 25,

              child: Center(
                child: Icon(Icons.check , color: Colors.white,),
              ),
              decoration: new BoxDecoration(

                gradient: new LinearGradient(
                    colors: [c1, Colors.cyan],
                    begin: Alignment.centerRight,
                    end: new Alignment(-1.0, -1.0)
                ),
                borderRadius: new BorderRadius.only(
                  topLeft: new Radius.circular(20.0),
                  bottomLeft: new Radius.circular(20.0),
                  topRight: new Radius.circular(20.0),
                  bottomRight: new Radius.circular(20.0),
                ),
                shape: BoxShape.rectangle,

              ),
            ),
          ),
        ],
      )
    ) ;


  }


}










