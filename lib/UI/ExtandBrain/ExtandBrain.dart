import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:monitor/Api/PersonAdd.dart';
import 'package:monitor/Constant/Strings.dart';
import 'package:monitor/Constant/colors.dart';
import 'package:http/http.dart' as http;
import 'package:monitor/UI/Layout/MainLayout.dart';
import 'package:monitor/tools/Images.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ExtandBrain extends KFDrawerContent {
  @override
  _ExtandBrainState createState() => _ExtandBrainState();
}

class _ExtandBrainState extends State<ExtandBrain> {
  Map<String, String> headers ;
  TextEditingController _name = new TextEditingController() ;
  TextEditingController _data = new TextEditingController() ;
  Person _currentCity;
  double headerSize = 100;
  File _image;
  String preview_path = "";
  ProgressDialog pr  ;

  @override
  Widget build(BuildContext context) {
    if (_image != null) preview_path = _image.path;
    return getMainLayout("Train Face Recognition" , _getBody() , context ) ;
  }

  Widget _getBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _getSelect(),
        getImage() ,
        Center(
          child: Container( margin : EdgeInsets.only(top: 40),child: RaisedButton.icon(color: c1 , icon: Icon(Icons.add, color : Colors.white,size: 30,), onPressed: (){
            uploadImage() ;                } , label: Container(width:200,padding: EdgeInsets.all(8),child: Text("Add Image",style: TextStyle( color:Colors.white , fontSize: 30),textAlign: TextAlign.center,)),),),
        )
      ],
    ) ;
  }


  Widget _getSelect() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              "Select a Person",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: new DropdownButton(
              value: _currentCity,
              items: _dropDownMenuItems,
              onChanged: changedDropDownItem,
            ),
          ),
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: showPopUp,
          )
        ],
      ),
    );
  }

  List<DropdownMenuItem<Person>> _dropDownMenuItems;
  List<DropdownMenuItem<Person>> getDropDownMenuItems() {
    List<DropdownMenuItem<Person>> items = new List();
    if (persons != null && persons.isNotEmpty)
      for (Person person in persons) {
        // here we are creating the drop down menu items, you can customize the item right here
        // but I'll just use a simple text for this
        items.add(new DropdownMenuItem(
            value: person,
            child: Container(width: 150, child: new Text(person.name))));
      }
    return items;
  }

  @override
  void initState() {
    pr =new ProgressDialog(context,type: ProgressDialogType.Normal);
    pr.update(message:"Uploading Image ... ");
    loadNames();
  }

  void changedDropDownItem(Person selectedCity) {
    print("Selected city $selectedCity, we are going to refresh the UI");
    setState(() {
      _currentCity = selectedCity;
    });
  }

  List<Person> persons;
  void loadNames() {
    print(baseUrl+"persons");
    http.get(baseUrl + "persons").then((http.Response response) {
      persons = AddPerson.fromJson(response.body).persons;
      setState(() {
        _dropDownMenuItems = getDropDownMenuItems();
        _currentCity = _dropDownMenuItems[0].value;
      });
    });
  }

  void showPopUp() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Add Person",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: _name,
                        decoration: InputDecoration(hintText: 'Name'),
                      ),
                      TextField(
                        controller: _data,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        decoration: InputDecoration(
                            hintText: 'Information About him ...'),
                      ),
                      SizedBox(
                        width: 320.0,
                        child: RaisedButton(

                          onPressed: () {
                            addPersonName(_name.text,_data.text);
                            Navigator.pop(context) ;
                          },
                          child: Text(
                            "Add Person",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: c2,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
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
                          : Image.file(File(preview_path)).image,))),
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
              child: Icon(Icons.camera_alt,size: 80,color: c2),
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

    });//TODO update the link



  }


  Future getImageFromGallery() async {
    print('i am here ');
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    await Images(image).CompressAndGetFile().then((file) async {
      _image = file;

    });

  }


  void uploadImage() async {

      pr.show();
      print("uploading");
      await Images(_image).uploadImage(
          baseUrl+"uploadImage/"+_currentCity.id ).then((onValue) {
        pr.hide();
        print("photo uploaded successfully");
      });

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
