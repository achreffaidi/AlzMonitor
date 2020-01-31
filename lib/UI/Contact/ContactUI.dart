import 'package:monitor/Constant/colors.dart';
import 'package:monitor/Model/Contact.dart';
import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class ContactUI extends StatefulWidget {
  @override
  _ContactUIState createState() => _ContactUIState();
}






class _ContactUIState extends State<ContactUI> {

  double headerSize = 100 ;

  List<TimelineModel> items = [
  ];
  @override
  void initState() {

    List<Contact> list = new List();
    list.add(new Contact("Foulen", "52005985", "Sister", "https://www.goldennumber.net/wp-content/uploads/2013/08/florence-colgate-england-most-beautiful-face.jpg")) ;
    list.add(new Contact("Foulen", "52005985", "Sister", "https://www.goldennumber.net/wp-content/uploads/2013/08/florence-colgate-england-most-beautiful-face.jpg")) ;
    list.add(new Contact("Foulen", "52005985", "Sister", "https://www.goldennumber.net/wp-content/uploads/2013/08/florence-colgate-england-most-beautiful-face.jpg")) ;
    list.add(new Contact("Foulen", "52005985", "Sister", "https://www.goldennumber.net/wp-content/uploads/2013/08/florence-colgate-england-most-beautiful-face.jpg")) ;
    list.add(new Contact("Foulen", "52005985", "Sister", "https://www.goldennumber.net/wp-content/uploads/2013/08/florence-colgate-england-most-beautiful-face.jpg")) ;
    list.add(new Contact("Foulen", "52005985", "Sister", "https://www.goldennumber.net/wp-content/uploads/2013/08/florence-colgate-england-most-beautiful-face.jpg")) ;

    for(int  i = 0  ; i< list.length ; i++){
      Contact contact  =list[i] ;

      items.add(
        TimelineModel(getItem(contact),
            position: i%2==0? TimelineItemPosition.left:TimelineItemPosition.right,
            iconBackground: Colors.purple,
            icon: Icon(Icons.person_pin,color: Colors.white,)) );

    }

  }

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
          child: getList()
      ),
    );
  }

  Widget _getHeader(){
    return Container(
      height: headerSize,
      child: Center(child: Text("Contacts",style: TextStyle(fontSize: 30 , color: Colors.white , fontWeight: FontWeight.bold), )),
    );
  }



  Widget getList(){
    return Timeline(children: items, position: TimelinePosition.Center);
  }

  Widget getItem(Contact contact){

    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
              child: Image.network(contact.url),
              height: 200,
              width: 200,
            ),
            Container( margin : EdgeInsets.symmetric(vertical: 10),child: Text(contact.name , style: TextStyle(fontSize: 25),),),
            Container(child: Text("("+contact.desc+")", style: TextStyle(fontSize: 18)),),
            Container( child: RaisedButton.icon(
                onPressed:(){
              _call(contact.phoneNumber);
            }, icon: Icon(Icons.phone,color: Colors.white,),color: Colors.green , label: Container(width: 80, child: Center(child: Text("Call",style: TextStyle(color: Colors.white),)))),),

          ],
        ),
      ),
    );
  }

  _call(String phoneNumber) {}


}
