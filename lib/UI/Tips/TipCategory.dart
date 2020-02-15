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
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/profilebackground.png"),
            fit: BoxFit.cover,
          ),
        ),
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

      child: Container(
          height: MediaQuery.of(context).size.height-headerSize - 100,
          child: getList(),
      ),
    );
  }

  Widget _getHeader(){
    return Column(
      children: <Widget>[
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: (){
              Navigator.pop(context);
            },),
        ),
        Container(
          margin: EdgeInsets.only(top: 0),
          height: headerSize,
          child: Center(child: Text(tiplist.title,style: TextStyle(fontSize: 40 , color: Colors.white , fontWeight: FontWeight.w300), textAlign: TextAlign.center,)),
        ),
      ],
    );
  }


  Widget getList(){

    return
      Container(

        height: MediaQuery.of(context).size.height - headerSize ,
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
        borderRadius: new BorderRadius.all(
               Radius.circular(20.0),


        )
        ,
        boxShadow: [
          new BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            spreadRadius:0.2,
            offset: new Offset(0, 0),
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
                    Color.lerp(c1, Colors.white, 0.3),
                    Color.lerp(c1, Colors.white, 0.3),
                    Color.lerp(c1, Colors.white, 0.3),
                  ],
                ),
                borderRadius: new BorderRadius.only(
                    topLeft:   Radius.circular(20.0),
                    topRight:   Radius.circular(20.0)
                )
                ,
                boxShadow: [
                  new BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    spreadRadius:0.2,
                    offset: new Offset(0, 0),
                  )
                ],),
              child: Container(

                child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child:
                    Center(child: Text(item.title,style: TextStyle(fontSize: 22 , color: Colors.white , fontWeight: FontWeight.w400),textAlign: TextAlign.center,))

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
