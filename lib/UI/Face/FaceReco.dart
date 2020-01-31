import 'dart:io';


import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monitor/Constant/colors.dart';
import 'package:progress_dialog/progress_dialog.dart';

class FaceReco extends StatefulWidget {
  @override
  _FaceRecoState createState() => _FaceRecoState();
}

class _FaceRecoState extends State<FaceReco> {

  String name ="User Name" ;
  String data ="This is your Son " ;
  double headerSize = 100 ;
  ProgressDialog pr  ;


  @override
  void initState() {
    pr =new ProgressDialog(context,type: ProgressDialogType.Normal);
    pr.update(message:"Getting Infos ... ");
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

      width: MediaQuery.of(context).size.width,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
             Container(height: 100,),
              _getChild() ,
              Container(margin: EdgeInsets.only(top: 60),
              child: Text("Name: " +name,style: TextStyle(fontSize: 40 ,fontWeight: FontWeight.bold),)
                ,),
             Container(margin: EdgeInsets.only(top: 40,left: 30,right: 30),
               child: Text(data,style: TextStyle(fontSize: 30,),textAlign: TextAlign.center,)
               ,)


            ],)
      ),
    );
  }

  Widget _getHeader(){
    return Container(
      height: headerSize,
      child: Center(child: Text("Face Recognition",style: TextStyle(fontSize: 30 , color: Colors.white , fontWeight: FontWeight.bold), )),
    );
  }


  Widget _getChild(){
    return Container(
         height: 150,
        width: 150,
        child : GestureDetector(
          child: Image.asset("assets/camera_icon.png",fit: BoxFit.cover,),
          onTap: (){
             onCameraButtonClick() ;
          },
        )
    ) ;

  }

  File _image;
  String preview_path = "";

  void onCameraButtonClick() async {
// Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

// Get a specific camera from the list of available cameras.
    final CameraDescription firstCamera = cameras.first;

    getImageFromCamera().then((onValue){
      uploadImage();
    });
  }


  Future getImageFromCamera() async {
    print('i am here ');
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    _image = image;
  }


  Future getImageFromGallery() async {
    print('i am here ');
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _image = image;
  }

  void uploadImage() async {


  }




}
