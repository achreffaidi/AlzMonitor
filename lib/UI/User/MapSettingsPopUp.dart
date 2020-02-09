import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:monitor/Constant/Strings.dart';
import 'package:monitor/Constant/colors.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

import 'LocationPicker.dart';

class MapSettingsPopUp extends StatefulWidget {
  @override
  _MapSettingsPopUpState createState() => _MapSettingsPopUpState();
}

class _MapSettingsPopUpState extends State<MapSettingsPopUp> {

  var _value = 20.0 ;
  var  _position ;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: Container(
        height: 400,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "GeoLocalitsation Settings",
                  style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold,

                  ),
                  textAlign: TextAlign.center,
                ),

                Container(
                  width: 1e10,
                  height: 50,
                  child: RaisedButton.icon(
                    color: c2,
                    icon: Icon(Icons.add_location , color: Colors.white, ),
                    label: Text("Select Safe Zone : " , style: TextStyle(color: Colors.white , fontSize: 25),),
                    onPressed: (){
                      getLocationPicker(context).then((LocationResult result){
                        _position = result.latLng ;
                        Toast.show(result.latLng.toString(), context) ;
                      });
                    },
                  ),
                )
                ,

                Text("Safe Distance :" , style: TextStyle(fontSize: 23 , color : c1),) ,
                FluidSlider(
                  valueTextStyle: TextStyle(fontSize: 13 , fontWeight: FontWeight.bold),
                  mapValueToString: (v) => v.floor().toString()+" m",
                  value: _value,
                  sliderColor: c2,
                  onChanged: (double newValue) {
                    setState(() {
                      _value = newValue;
                    });
                  },
                  min: 20,
                  max: 1000.0,
                ),

                Container(
                    width: 1e10,
                    child: RaisedButton.icon(color: c1  ,onPressed: _saveMapSettings, icon: Icon(Icons.save , color: Colors.white,), label: Text("Save" , style: TextStyle(color: Colors.white),)))


              ],
            ),
          ),
        ),
      ),
    );
  }





  _saveMapSettings() async {
    if(_position!=null)
    http.get(baseUrl+"setSafeZone" , headers: {
      "lat":_position.latitude.toString() ,
      "lang":_position.longitude.toString() ,
      "safedistance":_value.toString() ,

    }).then((http.Response response){

      if(response.statusCode==200)  Navigator.pop(context);

    });


  }
}
