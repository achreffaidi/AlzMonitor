import 'package:flutter/material.dart';
import 'package:monitor/Api/Tips.dart';
import 'package:monitor/Constant/colors.dart';

class TipCatergory extends StatefulWidget {

  TipsList tiplist ;

  TipCatergory(this.tiplist);

  @override
  _TipCatergoryState createState() => _TipCatergoryState(tiplist);
}

class _TipCatergoryState extends State<TipCatergory> {

  _TipCatergoryState(this.tiplist);

  TipsList tiplist ;

  double headerSize = 100 ;

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
          height: MediaQuery.of(context).size.height-headerSize,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              getList(),



            ],)
      ),
    );
  }

  Widget _getHeader(){
    return Container(
      height: headerSize,
      child: Center(child: Text("Tips Category",style: TextStyle(fontSize: 30 , color: Colors.white , fontWeight: FontWeight.bold), )),
    );
  }


  Widget getList(){

    return
      Container(

        height: MediaQuery.of(context).size.height - headerSize,
        margin: EdgeInsets.only(left: 10 ),
        child  :
        new ListView.builder
          (
            scrollDirection: Axis.vertical,
            itemCount: tiplist.list.length , //litems.length,
            itemBuilder: (BuildContext ctxt, int index) => getOneTip( tiplist.list[index])
        ),);



  }

  Widget getOneTip(ListList item) {

    return Container(


      width: 500,
      margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
            topLeft:   Radius.circular(50.0),
            topRight:   Radius.circular(50.0),
            bottomLeft:   Radius.circular(50.0),
            bottomRight:   Radius.circular(50.0)

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

              height: 100,
              width: 500,

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
                    topLeft:   Radius.circular(50.0),
                    topRight:   Radius.circular(50.0)
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
                    margin: EdgeInsets.only(top: 20),
                    child:
                    Text(item.title,style: TextStyle(fontSize: 22 , color: Colors.white , fontWeight: FontWeight.bold),textAlign: TextAlign.center,)

                ),

              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20 , horizontal: 10),child: Text(item.description),)

          ],

        ),

      ),
    );


  }
}
