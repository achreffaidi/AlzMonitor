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

import 'Contact/ContactUI.dart';
import 'Emergency/Emergency.dart';
import 'Memories/MemoryDetails.dart';
import 'Storage/Storage.dart';
import 'Tasks/TaskDetails.dart';
import 'Tips/TipCategory.dart';
import 'User/User.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomeScreen extends KFDrawerContent  {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {






  List<ImageProvider> images = new List();
  Memories memories ;
  double headerSize = 100 ;

  String _Battery ="loading .. " ;
  String _LastSeen ="loading .. " ;

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
    const oneSec = const Duration(seconds:60);
    new Timer.periodic(oneSec, (Timer t) =>_loadDeviceState() );
    _loadDeviceState() ;
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

                Container( margin : EdgeInsets.symmetric(horizontal: 20 , vertical: 10) ,child: Text("Memory Game Score", style: TextStyle(fontSize: 40),),),
                getChart(),
                Container( margin : EdgeInsets.symmetric(horizontal: 20 , vertical: 10) ,child: Text("Tips", style: TextStyle(fontSize: 40),),),

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









  Widget getAlz(){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
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
        Container(child: Text("Battery State : "+_Battery , style: TextStyle(fontSize: 17),),) ,
        Container(child: Text("Last Seen : "+_LastSeen , style: TextStyle(fontSize: 17),),) ,
        ],)
      ,);

}










  Widget getChart(){
  return Container(
    margin: EdgeInsets.all(20),
    height: 300,
    child: Card()) ;


  }

  void _loadDeviceState(){
  http.get(baseUrl+"getPhoneState").then((http.Response response){

    if(response.statusCode == 200){
      DeviceState  ds = DeviceState.fromJson(response.body)   ;
      _LastSeen  = _convertTime(ds.difference)  ;
      _Battery = ds.battery.toString()+"%" ;

      setState(() {

      });
    }
  }) ;


  }

  String _convertTime(int s ){

  if(s<60) return "Connected" ;
  if(s<3600) return (s/60).floor().toString()+" minuts" ;
  return (s/3600).floor().toString()+" hours" ;
  }







}



