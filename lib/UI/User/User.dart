import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:monitor/Api/Tips.dart';
import 'package:monitor/Api/location.dart';
import 'package:monitor/Api/memories.dart';
import 'package:monitor/Constant/Strings.dart';
import 'package:monitor/Constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';
import 'package:monitor/Game/DoubleChoiceGame/DoubleChoiceGame.dart';
import 'package:monitor/UI/ExtandBrain/ExtandBrain.dart';
import 'package:monitor/UI/Memories/MemoriesSettings.dart';
import 'package:monitor/UI/Memories/MemoryDetails.dart';
import 'package:monitor/UI/Memories/addMemories.dart';
import 'package:http/http.dart' as http;
import 'package:monitor/UI/Settings/Settings.dart';
import 'package:monitor/UI/Tips/TipCategory.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'Graphs/Circuler.dart';
import 'Graphs/TimeSerie.dart';
import 'LocationPicker.dart';
import 'MapSettingsPopUp.dart';


class Dashboard extends StatefulWidget {


  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  double headerSize = 100 ;


  bool mapIsReady = false ;
  @override
  void initState() {
    loadTips();

    super.initState();
  }

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

  Widget _getBody() {
    return Container(
      height: MediaQuery.of(context).size.height-headerSize-56,

      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getTips(),
                getCard(getTasksBoard(), 220) ,






              ],)
        ),
      ),
    );
  }


  Widget getDeviceBoard(){

    double size = (MediaQuery.of(context).size.width-100)/2 ;

    return Container(
      child :
        Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

           Text("Device State " , style : titleStyle),
            Row(
              children: <Widget>[
                Container(
                  width: size,
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Last Seen : 2 hours") ,
                      Text("Position : In the Safe Zone") ,
                    ],
                  ),
                ) ,
                Container(
                  width: size,
                  child : new CircularPercentIndicator(
                  radius  : size*0.6,
                  lineWidth: 14.0,
                  percent: 0.60,
                  center: new Icon(Icons.battery_charging_full , size: 50,),
                  progressColor: Colors.yellow,
                ),)
              ],
            ),
          ],
        )
    );



  }


  var titleStyle = TextStyle(fontSize: 20 , fontWeight: FontWeight.bold , color: c1);

  Widget getTasksBoard(){
 double size = (MediaQuery.of(context).size.width-100)/2 ;
    return
        Container(
          child  : Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Tasks of today" , style: titleStyle,) ,

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: size,

                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Icon(Icons.check_box ,color: Colors.green,size: 50,) ,
                        Text("3/7",style: TextStyle(color: Colors.blue , fontWeight: FontWeight.bold,fontSize: 50),) ,
                        Padding(
                          padding: const EdgeInsets.only(bottom : 8.0 , left: 0),
                          child: Text("Done",style: TextStyle(color: Colors.grey ,fontSize: 18),),
                        ) ,
                      ],) ,
                  ) ,
                  Container(
                    width: size,

                    child:
                    Column(
                      mainAxisSize: MainAxisSize.max,

                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("So Important"),
                        ) ,
                        LinearPercentIndicator(
                          width: 140.0,
                          lineHeight: 14.0,
                          percent: 0.8,
                          backgroundColor: Colors.grey,
                          progressColor: Colors.red,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Important"),
                        ) ,
                        LinearPercentIndicator(
                          width: 140.0,
                          lineHeight: 14.0,
                          percent: 0.2,
                          backgroundColor: Colors.grey,
                          progressColor: Colors.orange,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Normal"),
                        ) ,
                        LinearPercentIndicator(
                          width: 140.0,
                          lineHeight: 14.0,
                          percent: 0.5,
                          backgroundColor: Colors.grey,
                          progressColor: Colors.green,
                        ),
                      ],
                    ),
                  ) ,



                ],
              ),
            ],
          )
        ) ;

  }


  Widget getCard(Widget body , double height){
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 25 , vertical: 20),
      elevation: 8,
      child:
      Container(
        width: 1e10,

        height: height,
        padding: EdgeInsets.all(20),
        child: body
        ,
      )
      ,) ;


  }
  Widget _getHeader(){
    return Container(
      height: 180,
      width: 1e5,
    );
  }




  Tips tips ;

  void loadTips() async {

    http.get(baseUrl+"lists").then((http.Response response){

      tips = Tips.fromJson(response.body);

      setState(() {

      });

    }) ;

  }

  Widget getTips(){
    return tips==null? Container():
    Container(
      height: 320,
      margin: EdgeInsets.only(),
      child  :
      new CarouselSlider.builder(

        autoPlay: true,
      autoPlayAnimationDuration: Duration(seconds: 1),
      enableInfiniteScroll: true,

      itemCount: tips.lists.length,enlargeCenterPage: true,
    itemBuilder: (BuildContext context, int itemIndex) =>
    Container(
    child: getTipCategory(tips.lists[itemIndex])),
    ),
    );

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

        height: 220,
        width: 350,
        margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.all(
                Radius.circular(20.0),

          )
          ,
          boxShadow: [
            new BoxShadow(
              color: c1,
              blurRadius: 2,
              spreadRadius:0.2,
              offset: new Offset(0, 0),
            )
          ],),
        child: Container(
          child: Column(

            children: <Widget>[

              Container(

                height: 200,
                width: 350,

                decoration: new BoxDecoration(
                  image: DecorationImage(image: Image.network(item.link,fit: BoxFit.cover,).image,fit: BoxFit.cover),
                  borderRadius: new BorderRadius.only(
                      topLeft:   Radius.circular(20.0),
                      topRight:   Radius.circular(20.0)
                  )
                  ,
                  boxShadow: [
                    new BoxShadow(
                      color: c1 ,
                      blurRadius: 3,
                      spreadRadius:0.2,
                      offset: new Offset(0, 0),
                    )
                  ],),
                child: Container(

                ),
              ),
              Container(height: 50,child: Center(child: Text(item.title,style: TextStyle(fontSize: 22 , fontWeight: FontWeight.w300),textAlign: TextAlign.center,))),

            ],

          ),

        ),
      ),
    );

  }







}
