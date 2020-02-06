import 'package:flutter/material.dart';
import 'package:monitor/Api/SettingVoice.dart';
import 'package:monitor/UI/Layout/MainLayout.dart';
import 'package:http/http.dart' as http;

import '../../Constant/Strings.dart';



class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  Voices voices ;



  @override
  void initState() {
    _loadListOfVoices() ;
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
              _getSettingBlock("Voices" , _getVoiceSettings() )
          ],
        ),
      ),
    )
    ) ;

  }

  _getSettingBlock(String title, Widget widget) {
    return Container(

        child:
      Card(
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

  void _loadListOfVoices(){

    http.get(baseUrl+"listofvoices").then((http.Response response){

      if(response.statusCode==200){

        voices = Voices.fromJson(response.body);
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


        }
        , icon: Icon(Icons.play_arrow,color: Colors.green,), label:Text("Play") )

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
}


