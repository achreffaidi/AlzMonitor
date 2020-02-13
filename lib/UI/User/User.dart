import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
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
import 'package:monitor/UI/Memories/MemoryDetails.dart';
import 'package:monitor/UI/Memories/addMemories.dart';
import 'package:http/http.dart' as http;
import 'package:monitor/UI/Settings/Settings.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'Graphs/Circuler.dart';
import 'Graphs/TimeSerie.dart';
import 'LocationPicker.dart';
import 'MapSettingsPopUp.dart';


class User extends StatefulWidget {


  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  double headerSize = 100 ;
  List<ImageProvider> images = new List();
  Memories memories ;

  bool mapIsReady = false ;
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

  Widget _getBody() {
    return Container(
      height: MediaQuery.of(context).size.height-headerSize-56,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(

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
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
getCard(getTasksBoard(), 220) ,
getCard(getDeviceBoard(), 200) ,
getCard(getGameBoardLast(), 200) ,
getCard(getGameBoardHist(), 260) ,




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

  Widget getGameBoardLast(){
 double size = (MediaQuery.of(context).size.width-100)/2 ;
    return
        Container(
          child  : Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Last game" , style: titleStyle,) ,

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: size,

                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[

                        Text("52",style: TextStyle(color: Colors.blue , fontWeight: FontWeight.bold,fontSize: 50),) ,
                        Padding(
                          padding: const EdgeInsets.only(bottom : 8.0 , left: 8),
                          child: Text("Game Played",style: TextStyle(color: Colors.grey ,fontSize: 18),),
                        ) ,
                      ],) ,
                  ) ,
                  Container(
                    width: size,

                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                        Row(children: <Widget>[

                          Container(
                            height: size/1.8 ,
                            width: size/1.8,
                            child: DonutPieChart.withSampleData(),
                          ) ,
                          Column(
                            children: <Widget>[
                              Row(children: <Widget>[Icon(Icons.adjust , color: Colors.green,) , Text("Correct")],),
                              Row(children: <Widget>[Icon(Icons.adjust , color: Colors.red,) , Text("Wrong")],),
                            ],
                          )

                        ],)
                      ],
                    ),
                  ) ,



                ],
              ),
            ],
          )
        ) ;

  }
  Widget getTasksBoard(){
 double size = (MediaQuery.of(context).size.width-100)/2 ;
    return
        Container(
          child  : Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Tasks" , style: titleStyle,) ,

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
  Widget getGameBoardHist(){
 double size = (MediaQuery.of(context).size.width-100)/2 ;
    return
        Container(
          child  : Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Game Score History" , style: titleStyle,),

              Container(
                width: size*2,
                height: size,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: SimpleTimeSeriesChart.withSampleData(),
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
      height: 20,
      width: 1e5,
    );
  }

  Widget getUserImage(){
    return  Container(
      margin: EdgeInsets.only(left: 20 ,right: 20,top: 30),
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
          width: 500.0,
          fit: BoxFit.cover,
        ),
      ),
    ) ;
  }


  Location location ;

  Widget getLocation(){

    http.get(baseUrl+"getPosition").then((http.Response response){

       location = Location.fromJson(response.body) ;

       mapIsReady = true ;
       setState(() {

       });

    });
  }
  List<Marker> markers;

  int pointIndex;
  List points ;
  @override
  void initState() {

    loadPicture();
    getLocation() ;

    super.initState();
  }

  Widget _getMap(BuildContext context) {



    return new FlutterMap(
      options: new MapOptions(
        center: LatLng( location.latitude  ,location.longitude ),
        zoom: 15,
        plugins: [
          MarkerClusterPlugin(),
        ],
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://atlas.microsoft.com/map/tile/png?api-version=1&layer=basic&style=main&tileSize=256&view=Auto&zoom={z}&x={x}&y={y}&subscription-key={subscriptionKey}",
          additionalOptions: {
            'subscriptionKey': 'cqq6XOiiBJVwgSUb2EfrzI3mDb63ZpKyOrX5cK2ZKJk'
          },
        ),
        MarkerClusterLayerOptions(
          showPolygon: false,

          maxClusterRadius: 120,
          size: Size(40, 40),
          anchor: AnchorPos.align(AnchorAlign.center),
          fitBoundsOptions: FitBoundsOptions(
            padding: EdgeInsets.all(50),
          ),
          markers: markers,
          polygonOptions: PolygonOptions(

              borderColor: Colors.blueAccent,
              color: Colors.black12,
              borderStrokeWidth: 3),
          builder: (context, markers) {
            return Icon(Icons.person,);
          },
        ),
      ],

    );
  }
  Widget getUserDetails(){
    return Container(
      margin: EdgeInsets.only(top :20, right: 20,left: 20),
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

  Widget getMap(BuildContext context){
    points = [
      LatLng(location.latitude , location.longitude ),
    ];
    pointIndex = 0;
    markers = [
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: points[0],
        builder: (ctx) => Icon(Icons.pin_drop),
      ),

    ];
    return
      Container(
        height: 400,
        width: 500,
        margin: EdgeInsets.symmetric(vertical:20 , horizontal: 20),
        child: Card(child: _getMap(context),),
      );

  }

  Widget getMemories(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 40,right: 20,left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                  Text("Memories" , style: TextStyle(fontSize: 30),),
                  RaisedButton.icon( color : c1 ,  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddMemories()),
                    ).then((value){
                      loadPicture();
                    });
                  }, icon: Icon(Icons.add , color: Colors.white,), label: Text("Add Memory",style: TextStyle(color: Colors.white),))
                ,
              ],
            ),
          ),          getCarsoulet(),
        ],
      ),
    );

  }
  Widget getMapWidget(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 40,right: 20,left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                  Text("Map" , style: TextStyle(fontSize: 30),),
                  RaisedButton.icon( color : c1 ,  onPressed: (){
                    showMapPopUp() ;
                  }, icon: Icon(Icons.add , color: Colors.white,), label: Text("Settings",style: TextStyle(color: Colors.white),))
                ,
              ],
            ),
          ),           mapIsReady?getMap(context):Container()
        ],
      ),
    );

  }

  void loadPicture() async {

    print("loading pictures ") ;
    await http.get(baseUrl+"memories").then((http.Response response){
      print(response.statusCode) ;
      memories = Memories.fromJson(response.body);
      images = new List();
      for(Picture picture in memories.pictures){
        images.add(Image.network(picture.pictureUrl).image);
      }
      setState(() {

      });
    });
  }
  Widget getCarsoulet(){
    return images.isEmpty?Container():Container(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      height: 300,

      child: Carousel(
        dotColor: c2,
        radius: Radius.circular(60),
        borderRadius: true,
        images: images,
        onImageTap: (index){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MemoryDetail(memories.pictures[index])),
          );
        },
      ),
    );
  }

  void showMapPopUp() async {

    showDialog(
      context: context,
      builder: (BuildContext context) =>
          MapSettingsPopUp());
  }


}
