import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:monitor/Api/GameCategories.dart';
import 'package:monitor/Api/SettingVoice.dart';
import 'package:monitor/UI/Layout/MainLayout.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import '../../Constant/Strings.dart';



class Settings extends KFDrawerContent {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  Voices voices ;
  GameCategories categories ;
  List<bool> isChecked  ;
  var emergencyNumber ;


  @override
  void initState() {
    _loadListOfVoices() ;
    _loadListOfCategories();
    _loadEmergencyNumber() ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return getMainLayout("Settings",_getBody(),context) ;
  }

  Widget _getBody() {
    return Container(
        child :
    SingleChildScrollView(
      child: Container(
        child: Column(

          children: <Widget>[
              _getSettingBlock("Voices" , _getVoiceSettings() ),
              _getSettingBlock("Game Settings" , _getGameSettings() ),
              _getSettingBlock("Emergency Number" , _getEmergencyNumberSettings() ),

          ],
        ),
      ),
    )
    ) ;

  }

  _getSettingBlock(String title, Widget widget) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
        child:
      Card(
        color: Colors.white,
        child: 
        Container(
          child : Column(
            children: <Widget>[
              Container( child: 
                //Title
                Text(title , style: TextStyle(fontSize: 24),),) ,
                //Body
              Container(child : widget)
            ],
          )
        ),
      )
      ) ;
    
    
  }

  Widget _getVoiceSettings() {
       if(voices==null) return CircularProgressIndicator();
       return
         Container(
           height: 300,
           child: new ListView.builder
             (
               physics: const NeverScrollableScrollPhysics(),
             scrollDirection: Axis.vertical,
               itemCount: voices.list.length,
               itemBuilder: (BuildContext ctxt, int index) {
                 return _getVoiceItem(voices.list[index],index);
               }
           ),
         ) ;


  }
  Widget _getGameSettings() {
       if(categories==null) return CircularProgressIndicator();
       return
         Container(
           height: 300,
           child: new ListView.builder
             (
               physics: const NeverScrollableScrollPhysics(),
             scrollDirection: Axis.vertical,
               itemCount: categories.categoriesList.length,
               itemBuilder: (BuildContext ctxt, int index) {
                 return _getCategoryItem(categories.categoriesList[index],index);
               }
           ),
         ) ;


  }

  TextEditingController _textEditingController = new TextEditingController();
  Widget _getEmergencyNumberSettings() {
       if(emergencyNumber==null) return CircularProgressIndicator();
       return
         Container(
             margin: EdgeInsets.symmetric(horizontal: 30 , vertical: 20),

             height: 200,
           child   : Column(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: <Widget>[
           TextField(
             controller: _textEditingController,
           decoration: InputDecoration(
               labelText: "Emergency Number",
               hintText: "Emergency Number"
           ),
         ) ,

             RaisedButton.icon(onPressed: _updateEmergencyNumber, icon: Icon(Icons.update), label: Text("Update"))

           ],)
         ) ;


  }

  void _loadListOfVoices(){

    http.get(baseUrl+"listofvoices").then((http.Response response){

      if(response.statusCode==200){

        voices = Voices.fromJson(response.body);

        http.get(baseUrl+"getVoiceChoice").then((http.Response response ){

          for(int i = 0 ; i<voices.list.length;i++){

            if(voices.list[i].shortName == response.body)  _groupValue = i ;

          }

          setState(() {

          });

        }) ;

      }

    });
  }

  void _loadListOfCategories(){

    http.get(baseUrl+"photosGame/getCategories").then((http.Response response){

      if(response.statusCode==200){

        categories = GameCategories.fromJson(response.body);
        isChecked = new List(categories.categoriesList.length);
        for(int i =0 ; i<isChecked.length;i++) isChecked[i] = false ;
        setState(() {

        });
      }

    });
  }

  int _groupValue = 0 ;
  Widget _getVoiceItem(Voice item , index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
        child :
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Radio(value: index, groupValue: _groupValue, onChanged: (value){
            setState(() {
              _groupValue = index ;
            });
        }) ,
        Container(child: Text(_getName(item.shortName))) ,
        RaisedButton.icon(onPressed: (){
          _playTestExample(item.shortName,item.locale);

        }
        , icon: Icon(Icons.play_arrow,color: Colors.green,), label:Text("Play") )

      ],
    )
    ) ;
  }

  Widget _getCategoryItem(CategoriesList item , index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
        child :
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(  value: isChecked[index], onChanged: (value){
            setState(() {
              isChecked[index] = !isChecked[index];
            });
        }) ,
        Container(child: Text(item.category)) ,


      ],
    )
    ) ;
  }

  String _getName(String shortName) {
    var tab = shortName.split("-") ;
    if(tab.length==3){
      return tab[0]+"-"+tab[1]+" "+tab[2] ;
    }else if (tab.length==4){
      return tab[0]+"-"+tab[1]+" "+tab[2] +" "+tab[3] ;
    }else{
      return shortName ;
    }
  }



  void _playTestExample(String name , String local)async{


    http.get(baseUrl+"getVoiceSimple", headers: {
      "ShortName": name,
      "Locale": local
    }).then((http.Response response){

      print(response.body);
      print(response.headers);
      if(response.headers.containsKey("voice")) play(response.headers["voice"]) ;
    });

  }
  AudioPlayer audioPlayer ;

  play(String url ) async {

    print(url);
    AudioPlayer.logEnabled = true;
    audioPlayer = AudioPlayer();

    int result = await audioPlayer.play(url);

    if (result == 1) {
      // success
    }
  }





  void _loadEmergencyNumber() async {

    http.get(baseUrl+"getEmergencyNumber").then((http.Response response){

      var parsedJson = json.decode(response.body);
      emergencyNumber =  parsedJson["number"] ;
      _textEditingController.text = emergencyNumber;
      setState(() {

      });

    });

  }

  void _updateEmergencyNumber() async {
    
    http.post(baseUrl+"setEmergencyNumber" , headers: {
      "number" : _textEditingController.text.toString()
    }).then((http.Response response){
      if(response.statusCode==200){
        Toast.show("Successful", context) ;
      }
    });
  }
}


