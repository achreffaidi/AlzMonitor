import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monitor/Api/PersonAdd.dart';
import 'package:monitor/Constant/Strings.dart';
import 'package:monitor/Constant/colors.dart';
import 'package:http/http.dart' as http;
import 'package:monitor/tools/Images.dart';
import 'package:progress_dialog/progress_dialog.dart';


class AddMemories extends StatefulWidget {
  @override
  _AddMemoriesState createState() => _AddMemoriesState();
}

class _AddMemoriesState extends State<AddMemories> {
  Map<String, String> headers ;
  TextEditingController _name = new TextEditingController() ;
  TextEditingController _date = new TextEditingController() ;
  TextEditingController _data = new TextEditingController() ;
  Person _currentCity;
  double headerSize = 100;
  File _image;
  String preview_path = "";
  ProgressDialog pr  ;

  @override
  Widget build(BuildContext context) {
    if (_image != null) preview_path = _image.path;
    return Scaffold(
      body: Container(
        color: c1,
        child: Column(
          children: <Widget>[_getHeader(), _getBody()],
        ),
      ),
    );
  }

  Widget _getBody() {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getInputWidget(),
              getImage() ,
              Center(
                child: Container( margin : EdgeInsets.only(top: 40),child: RaisedButton(color: c1, onPressed: (){
                  uploadImage() ;                } , child: Container( width:200,padding: EdgeInsets.all(8),child: Text("Add memory",style: TextStyle(fontSize: 30 , color: Colors.white),textAlign: TextAlign.center,)),),),
              )
            ],
          )),
    );
  }

  Widget _getHeader() {
    return Container(
      height: headerSize,
      child: Center(
          child: Text(
            "Add Memory",
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
  }



  Widget getInputWidget(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20 , horizontal: 30),
      height: 200,
      child: Column(
        children: <Widget>[
          TextField(
            controller: _name,
            decoration: InputDecoration(hintText: 'Title'),
          ),
          TextField(
            controller: _date,
            decoration: InputDecoration(hintText: 'Date'),
          ),
          TextField(
            controller: _data,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            decoration: InputDecoration(
                hintText: 'More details ...'),
          ),

        ],
      ),
    );

  }


  @override
  void initState() {
    pr =new ProgressDialog(context,type: ProgressDialogType.Normal);
    pr.update(message:"Uploading Pictures ... ");
  }


  Widget getImage() {
    return Center(
      child: Column(children: <Widget>[
        Card(
          child: new Container(
              width: 400.0,
              height: 400.0,
              decoration: new BoxDecoration(

                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: (preview_path.isEmpty)
                          ? Image.asset(
                        "assets/userImage.jpg",
                      ).image
                          : Image.file(File(preview_path)).image))),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Icon(Icons.image,size: 80,color: c2,),
              onPressed: () {
                getImageFromGallery().then((onValue) {
                  setState(() {});
                });
              },
            ),
            FlatButton(
              child: Icon(Icons.camera_alt,size: 80,color: c2,),
              onPressed: () {
                getImageFromCamera().then((value) {
                  setState(() {});
                });
              },
            ),
          ],
        )
      ]),
    );
  }



  Future getImageFromCamera() async {
    print('i am here ');
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    await Images(image).CompressAndGetFile().then((file) async {
      _image = file;
    });
  }


  Future getImageFromGallery() async {
    print('i am here ');
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _image = image;

  }


  void uploadImage() async {
    await Images(_image).CompressAndGetFileWithoutRotation().then((file) async {
      pr.show();
      Map<String,String> headers = {
        "title":_name.text ,
        "description" : _data.text ,
        "date" : _date.text
      };
      print("uploading");
      await Images(file).uploadImageWithHeaders(
          baseUrl+"memories/add/",headers ).then((onValue) {
        pr.hide();
        print("photo uploaded successfully");
        Navigator.pop(context);
      });
    });//TODO update the link


  }

  void addPersonName(String name , String data) async{


    headers= {
      'name': name,
      'userData': data
    };
    http.post(baseUrl+"persons",headers: headers).then((http.Response response){
      print(response.statusCode) ;
    }) ;
  }


}
