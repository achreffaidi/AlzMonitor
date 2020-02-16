import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:monitor/Api/location.dart';
import 'package:monitor/Constant/colors.dart';
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
import 'package:monitor/UI/Dashboard/MapSettingsPopUp.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';



class MapUI extends StatefulWidget {
  @override
  _MapUIState createState() => _MapUIState();
}

class _MapUIState extends State<MapUI> {
  double headerSize = 100 ;

  bool mapIsReady = false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.transparent,
      body: Container(
        child:  Column(
          children: <Widget>[
            _getBody()
          ],
        ),
      ) ,
    );
  }

  Widget _getBody() {
    return Container(
      height: MediaQuery.of(context).size.height-headerSize-56,

      child: Container(
        child: Container(
            width: MediaQuery.of(context).size.width,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getMapWidget()

              ],)
        ),
      ),
    );
  }





  var titleStyle = TextStyle(fontSize: 20 , fontWeight: FontWeight.bold , color: c1);



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




  Location location ;

  Widget getLocation(){

    http.get(baseUrl+"getPosition").then((http.Response response){

      location = Location.fromJson(response.body) ;
      message = location.message ;
      mapIsReady = true ;
      setState(() {

      });

    });
  }
  List<Marker> markers;

  int pointIndex;
  List points ;

  String  message ="" ;


  @override
  void initState() {
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


  Widget getMap(BuildContext context){
    points = [
      LatLng(location.latitude , location.longitude ),
    ];
    pointIndex = 0;
    markers = [
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 180,
        width: 250,
        point: points[0],

        builder: (ctx) => Column(

          children: <Widget>[
Container(
  height: 60,
  child: Card(child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(

        (location.distanceFromSafeZone/1000).toStringAsFixed(1) +" klm \n from Safe-Zone"

    ),
  ),),
),
            Container(
      height: 60
    ,
                child: Center(child: Icon(Icons.pin_drop , color: Colors.redAccent,size: 50,))),
          SizedBox(height: 60,)
          ],
        ),
      ),

    ];
    return
      Container(
        height: MediaQuery.of(context).size.height*0.65,
        width: 500,
        margin: EdgeInsets.symmetric(vertical:20 , horizontal: 20),
        child: Card(child: _getMap(context),),
      );

  }


  Widget getMapWidget(){
    return Container(
      height: 850,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(

      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          mapIsReady?getMap(context):Container(
            child: Card(child: Container( height: MediaQuery.of(context).size.height*0.65,
              width: 500,child: Center(child : CircularProgressIndicator()),),),


          ) ,
          Text(message , textAlign: TextAlign.center,style: TextStyle(
            fontWeight: FontWeight.w300 , fontSize: 25
          ),) ,
          RaisedButton.icon( color : c1 ,  onPressed: (){
            showMapPopUp() ;
          }, icon: Icon(Icons.settings , color: Colors.white,), label: Text("Safe-Zone settings",style: TextStyle(color: Colors.white),))
        ],
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
