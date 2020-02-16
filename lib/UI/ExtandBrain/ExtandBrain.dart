import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_flip_view/flutter_flip_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intervalprogressbar/intervalprogressbar.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:monitor/Api/PersonAdd.dart';
import 'package:monitor/Constant/Strings.dart';
import 'package:monitor/Constant/colors.dart';
import 'package:http/http.dart' as http;
import 'package:monitor/UI/Layout/MainLayout.dart';
import 'package:monitor/tools/Images.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ExtandBrain extends KFDrawerContent {
  @override
  _ExtandBrainState createState() => _ExtandBrainState();
}

class _ExtandBrainState extends State<ExtandBrain>
    with SingleTickerProviderStateMixin {
  Map<String, String> headers;
  TextEditingController _name = new TextEditingController();
  TextEditingController _data = new TextEditingController();
  Person _currentCity;
  double headerSize = 100;
  File _image;
  String preview_path = "";
  ProgressDialog pr;

  AnimationController _animationController;
  Animation<double> _curvedAnimation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/taskmanagerbackground.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                "Face Recognition",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: widget.onMenuPressed,
              ),
            ),
            _getBody()
          ],
        ) /* add child content here */,
      ),
    );
  }

  Widget _getBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
          SizedBox(height: 150,) ,
          getFlip(),
          getCard(persons==null?Container(child: Center(child: CircularProgressIndicator()),) : getNamesBoard(), 400)
    //    _getSelect(),
    //    getImage(),
      /*  Center(
          child: Container(
            margin: EdgeInsets.only(top: 40),
            child: RaisedButton.icon(
              color: c1,
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                uploadImage();
              },
              label: Container(
                  width: 200,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Add Image",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                    textAlign: TextAlign.center,
                  )),
            ),
          ),
        )*/
      ],
    );
  }

  Widget getFlip() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlipView(
        animationController: _curvedAnimation,
        front: getInstructions(),
        back: getSteps(),
      ),
    );
  }

  void _flip(bool reverse) {
    if (_animationController.isAnimating) return;
    if (reverse) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  var aspectRatio  = 1.5 ; 
  Widget getInstructions(){
    return AspectRatio(
      aspectRatio: aspectRatio,
      child:
      Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16) ,
        ) ,
        child: Row(
          children: <Widget>[

            Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                  image: DecorationImage(image: Image.asset("assets/facereco.png").image,fit: BoxFit.cover),
                  borderRadius: new BorderRadius.all(
                    Radius.circular(20.0),


                  )
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: 200,
                        child: Text("Some instructions goes here ",style: TextStyle(fontSize: 23 ,fontWeight: FontWeight.w300),textAlign: TextAlign.center,)),
                  ) ,

                  RaisedButton.icon(onPressed: (){
                    _step = 1 ;
                    setState(() {

                    });
                    _flip(true);
                  },
                      icon :Icon(Icons.add,color: Colors.white,size: 30,),
                      label: Text("Add Person",style: TextStyle(color: Colors.white , fontSize: 23),) ,
                    color: c1,
                  )
                ],
              ),
            ),
          ],
        ),
      )
      ,);
  }

  var _step = 1 ;
  Widget getSteps(){
    return AspectRatio(
      aspectRatio: aspectRatio,
      child:
      Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16) ,
        ) ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IntervalProgressBar(
                  direction: IntervalProgressDirection.horizontal,
                  max: 5,
                  progress: _step,
                  intervalSize: 3,
                  size: Size(300, 10),
                  highlightColor: c1,
                  defaultColor: Colors.grey,
                  intervalColor: Colors.transparent,
                  intervalHighlightColor: Colors.transparent,
                  reverse: false,
                  radius: 10),
            ) ,
            getStep(),
          ],
        ),
      )
      ,);
  }

  Widget getStep(){
    switch(_step){
      case 1 : return getStep_1();
      case 2 : return getStep_2("(1/3)");
      case 3 : return getStep_2("(2/3)");
      case 4 : return getStep_2("(3/3)");
      case 5 : return getStep_3();
      default : return Container() ;
    }
  }

  Container getStep_1() {
    return Container(
            height: 220,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: Image.asset("assets/form.png").image,fit: BoxFit.cover),
                      borderRadius: new BorderRadius.all(
                        Radius.circular(20.0),


                      )
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 230,
                        child: TextField(
                          style: TextStyle(fontSize: 22),
                          controller: _name,
                          decoration: InputDecoration(hintText: 'Name' ,),
                        ),
                      ),
                      Container(
                        width: 230,
                        child: TextField(
                          controller: _data,
                          style: TextStyle(fontSize: 22),
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          decoration: InputDecoration(
                              hintText: 'Information About him ...'),
                        ),
                      ),

                      Container(
                        width: 230,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            RaisedButton.icon(onPressed: (){
                              _step = 1 ;
                              _flip(false);
                            },
                              icon :Icon(Icons.cancel,color: Colors.white,size: 20,),
                              label: Text("Cancel",style: TextStyle(color: Colors.white , fontSize: 20),) ,
                              color: Colors.redAccent,
                            ),
                            RaisedButton.icon(onPressed: (){
                              _step++ ;
                              setState(() {

                              });
                            },
                              icon :Icon(Icons.navigate_next,color: Colors.white,size: 20,),
                              label: Text("Next",style: TextStyle(color: Colors.white , fontSize: 20),) ,
                              color: c1,
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }
  Container getStep_2(String number) {
    return Container(
            height: 220,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Column(
                  children: <Widget>[
                    getImage(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          child: Icon(
                            Icons.image,
                            size: 40,
                            color: c2,
                          ),
                          onPressed: () {
                            getImageFromGallery().then((onValue) {
                              setState(() {});
                            });
                          },
                        ),
                        FlatButton(
                          child: Icon(Icons.camera_alt, size: 40, color: c2),
                          onPressed: () {
                            getImageFromCamera().then((value) {
                              setState(() {});
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Upload a Picture of this Person "+number , style: TextStyle(fontWeight: FontWeight.w300 , fontSize: 22),),
                        ),
                      ) ,
                      Container(
                        width: 230,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            RaisedButton.icon(onPressed: (){
                              _step = 1 ;
                              _flip(false);
                            },
                              icon :Icon(Icons.cancel,color: Colors.white,size: 20,),
                              label: Text("Cancel",style: TextStyle(color: Colors.white , fontSize: 20),) ,
                              color: Colors.redAccent,
                            ),
                            RaisedButton.icon(onPressed: (){
                              _step++ ;
                              setState(() {

                              });
                            },
                              icon :Icon(Icons.navigate_next,color: Colors.white,size: 20,),
                              label: Text("Next",style: TextStyle(color: Colors.white , fontSize: 20),) ,
                              color: c1,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }
  Container getStep_3() {
    return Container(
      height: 220,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Icon(Icons.check_circle_outline , color: c1 , size: 180,),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 240,
                 child :  Text("you have successfully added a new Person" ,style: TextStyle(fontWeight: FontWeight.w300 ,fontSize: 25), )
                ),

                RaisedButton.icon(onPressed: (){
                  _step = 1 ;
                  _flip(false);
                },
                  icon :Icon(Icons.done,color: Colors.white,size: 30,),
                  label: Text("Finish",style: TextStyle(color: Colors.white , fontSize: 30),) ,
                  color: c1,
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.update(message: "Uploading Image ... ");
    loadNames();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
  }

  void changedDropDownItem(Person selectedCity) {
    print("Selected city $selectedCity, we are going to refresh the UI");
    setState(() {
      _currentCity = selectedCity;
    });
  }

  List<Person> persons;
  void loadNames() {
    print(baseUrl + "persons");
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
                            addPersonName(_name.text, _data.text);
                            Navigator.pop(context);
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
              width: 160.0,
              height: 160.0,
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(
                  Radius.circular(20.0),
                ) ,
                  image: new DecorationImage(
                fit: BoxFit.cover,
                image: (preview_path.isEmpty)
                    ? Image.asset(
                        "assets/userImage.jpg",
                      ).image
                    : Image.file(File(preview_path)).image,
              ))),
        ),

      ]),
    );
  }

  Future getImageFromCamera() async {
    print('i am here ');
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    await Images(image).CompressAndGetFile().then((file) async {
      _image = file;
      if (_image != null) preview_path = _image.path;
      setState(() {

      });
    });
  }

  Future getImageFromGallery() async {
    print('i am here ');
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    await Images(image).CompressAndGetFile().then((file) async {
      _image = file;
      if(_image!=null) preview_path = _image.path ;
      setState(() {

      });
    });
  }

  void uploadImage() async {
    pr.show();
    print("uploading");
    await Images(_image)
        .uploadImage(baseUrl + "uploadImage/" + _currentCity.id)
        .then((onValue) {
      pr.hide();
      print("photo uploaded successfully");
    });
  }

  void addPersonName(String name, String data) async {
    headers = {'name': name, 'userData': data};
    http
        .post(baseUrl + "persons", headers: headers)
        .then((http.Response response) {
      print(response.statusCode);
    });
  }

  Widget getCard(Widget body , double height){
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15 , vertical: 15),
      elevation: 3,
      child:
      Container(
        width: 1e10,

        height: height,
        padding: EdgeInsets.all(20),
        child: body
        ,
      )
      ,) ;


  }
  
  Widget getNamesBoard(){
    var titleStyle = TextStyle(fontSize: 20 , fontWeight: FontWeight.bold , color: c1);

    double size = (MediaQuery.of(context).size.width-120)/2 ;

    return Container(
        child :
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Text("List of saved Faces " , style : titleStyle),
      Container(
        height: 300,
        child: ListView.builder(
          itemCount: persons.length??0,
          itemBuilder: (context, index) {
            return getItem(persons[index]);
          },
        ),
      )
          ],
        )
    );


  }

  Widget getItem(Person person) {
    return Card(
      color: Colors.indigoAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(person.name , style: TextStyle(fontSize: 22 , fontWeight: FontWeight.w300 , color: Colors.white),) ,
              GestureDetector(
                  onTap: (){
                    showDeletDialog(person) ;
                  },
                  child: Icon(Icons.delete_forever , color:Colors.white,))
            ],
          )
        ),
      ),
    ) ;
  }

  void showDeletDialog(Person person) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Delete Person"),
          content: new Text("Do you really want to delete ${person.name} ?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Delete"),
              onPressed: () {

                http.delete(baseUrl+"personDelete", headers: {
                  "personid":person.id
                }).then((http.Response response){
                  loadNames();
                });
                persons = null ;
                setState(() {

                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  
  
}
