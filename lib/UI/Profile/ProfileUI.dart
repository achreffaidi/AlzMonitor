import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:monitor/Constant/colors.dart';
import 'package:monitor/UI/User/Graphs/Circuler.dart';
import 'package:monitor/UI/User/Graphs/TimeSerie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProfileUI extends KFDrawerContent {
  @override
  _ProfileUIState createState() => _ProfileUIState();
}

class _ProfileUIState extends State<ProfileUI> {
  @override
  Widget build(BuildContext context){
    return Scaffold(


      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/profilebackground.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.transparent,
              title: Text("Profile", style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.menu,color: Colors.white,),
                onPressed: widget.onMenuPressed,),

            )

            ,
            _getBody()


          ],
        ) /* add child content here */,
      ),
    );
  }

  var image_size = 180.0 ;
  _getBody() {
    ScrollController sc = new ScrollController();
    sc.addListener((){
      print(sc.position) ;
      if(sc.offset<180){
        image_size =  180 - sc.offset*1.2 ;
      }else{
        image_size = 0 ;
      }

      if(image_size<0) image_size = 0 ;
      setState(() {

      });
    });
    return Container(
      height: MediaQuery.of(context).size.height-100,
      width: MediaQuery.of(context).size.width,

      child: SingleChildScrollView(
controller: sc,
        child:Stack(

          children: <Widget>[

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.only(top: 100),
                margin: EdgeInsets.only(top: 130),
                height: 1400,

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

                    Container(child: Text("Elon Musk" , style: TextStyle(fontSize: 30 , color: c1),))
                    , Container(
                      margin: EdgeInsets.only(top: 10),
                        child: Text("He is in the Safe Zone" , style: TextStyle(fontSize: 20 , color: c1 , fontWeight: FontWeight.w200),)) ,
                    Container(
                      margin: EdgeInsets.only(top: 20),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(  child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("    Call  " , style: TextStyle(color: Colors.white , fontSize: 22),),

                          ), color: c1, onPressed: (){},) ,
                          RaisedButton(  child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Message" , style: TextStyle(color: Colors.white , fontSize: 22),),

                          ), color: Color.lerp(c1, Colors.black, 0.4), onPressed: (){},) ,
                        ],
                      ),
                    ) ,
                  //  getCard(getTasksBoard(), 220) ,
                    SizedBox(height: 40,),
                    getCard(getDeviceBoard(), 200) ,
                    getCard(getGameBoardLast(), 200) ,
                    getCard(getGameBoardHist(), 260) ,


                  ],

                ),
              ),
            ),
            Positioned(
              top: 130,
              right: 20,
              child: Container(
                height: 60,
                width: 60,
                decoration: new BoxDecoration(
                  color: Colors.red,

                  borderRadius: new BorderRadius.only(
                    bottomLeft: new Radius.circular(20.0),
                    topRight: new Radius.circular(20.0),
                  ),


                ),
                child:
                Center(child: Container(child: Icon(Icons.phone , color: Colors.white , size: 35,),)),
              ),
            ),
            _getProfilePicture(),

          ],
        ),


      ),
    ) ;

  }

  Container _getProfilePicture() {
    return Container(
      margin: EdgeInsets.only(top: 30 + (180-image_size)*0.8),
          height: image_size,
          child: Center(
            child: Container(
                width: image_size,
                height: image_size,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: new NetworkImage(
                            "https://ak8.picdn.net/shutterstock/videos/14152598/thumb/1.jpg")
                    )
                )),
          ),
        );
  }
  Widget getDeviceBoard(){

    double size = (MediaQuery.of(context).size.width-120)/2 ;

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
    double size = (MediaQuery.of(context).size.width-120)/2 ;
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
    double size = (MediaQuery.of(context).size.width-120)/2 ;
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
    double size = (MediaQuery.of(context).size.width-120)/2 ;
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
      margin: EdgeInsets.symmetric(horizontal: 15 , vertical: 15),
      elevation: 3,
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

}