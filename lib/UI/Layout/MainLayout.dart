import 'package:flutter/material.dart';

import '../../Constant/colors.dart';



double headerSize = 100;

 Widget  getMainLayout(String title , Widget body , BuildContext context ){

  return Scaffold(
    body: Container(
      color: c1,
      child: Column(
        children: <Widget>[_getHeader(), _getBody(context , body)],
      ),
    ),
  );


}

Widget _getBody(BuildContext context , Widget body) {
  return Container(
    decoration: new BoxDecoration(
      color: Colors.white,
      borderRadius: new BorderRadius.only(topLeft: Radius.circular(70.0)),
      boxShadow: [
        new BoxShadow(
          color: Colors.grey,
          blurRadius: 5,
          spreadRadius: 0.2,
          offset: new Offset(-3, -2.0),
        )
      ],
    ),
    child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - headerSize,
        child: body ),
  );
}

Widget _getHeader() {
  return Container(
    height: headerSize,
    child: Center(
        child: Text(
          "Train Face Recognition",
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        )),
  );
}