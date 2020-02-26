import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monitor/Constant/Strings.dart';
import 'package:monitor/Constant/colors.dart';
import 'package:http/http.dart' as http;
import 'package:monitor/tools/Images.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CreateTask extends StatefulWidget {

  int day ;

  CreateTask(this.day);

  @override
  _CreateTaskState createState() => _CreateTaskState(day);
}

class _CreateTaskState extends State<CreateTask> {

  int day ;
  Categories categories = new Categories() ;
  Priorities priorities = new Priorities() ;
  _CreateTaskState(this.day);
  TimeOfDay _picked = TimeOfDay.now() ;
  TimeOfDay _time = TimeOfDay.now() ;

  double headerSize = 100 ;



  @override
  void initState() {
    pr =new ProgressDialog(context,type: ProgressDialogType.Normal);
    pr.update(message:"Creating Task ... ");
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(


      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/addtaskbackground.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.transparent,
                title: Text("", style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back,color: Colors.white,),
                  onPressed: (){
                  Navigator.of(context).pop();
                  },),

              )

              ,
              _getBody()


            ],
          ) /* add child content here */,
        ),
      ),
    );
  }


  Widget _getBody() {

    DateTime _dateTime = new DateTime.now() ;
    Future<Null> selectTime(BuildContext context) async {
      _picked = await showTimePicker(
        context: context ,
        initialTime: _time ,
      ).then((value){
        return value ;
      });
      setState(() {
        if(_picked!=null) _time = _picked ;
      });
    }
    var _titleStyle = new TextStyle(fontSize: 22 , fontWeight: FontWeight.w500 ,color: Colors.black54);
    return Container(
      height: MediaQuery.of(context).size.height-92,

      child: Container(
        child: Container(
            width: MediaQuery.of(context).size.width,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(left : 50.0),
                  child: Text("Create" , style: TextStyle(fontSize: 55 , color: Colors.white , fontWeight: FontWeight.w700),),
                ) ,
                Padding(
                  padding: const EdgeInsets.only(left : 50.0),
                  child: Text("New Task" , style: TextStyle(fontSize: 55 , color: Colors.white , fontWeight: FontWeight.w700),),
                ),

                SizedBox(height: 60,) ,

                Container(
                  height: 780,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [


                          Container(
                            height: 60,
                            padding: EdgeInsets.symmetric(horizontal:20,vertical: 5 ),
                            decoration: new BoxDecoration(
                              color: Color.lerp(Colors.grey, Colors.white, 0.8),
                              borderRadius: new BorderRadius.all(
                                Radius.circular(20.0),
                              ),



                            ),
                            child:
                            Center(
                              child: TextField(
                                controller: _nameTask,
                                style: TextStyle(fontSize: 23),

                                decoration: InputDecoration.collapsed(hintText: 'Task Title',
                                  hintStyle: TextStyle(fontSize: 23)

                                ),
                              ),
                            ),
                          ) ,


                          Padding(
                            padding: const EdgeInsets.only(top : 10.0),
                            child: Row(
                              children: <Widget>[

                                GestureDetector(
                                  onTap: (){
                                    selectTime(context);
                                  },
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: new BoxDecoration(
                                      gradient: new LinearGradient(
                                          colors: [Colors.white, Colors.white],
                                          begin: Alignment.centerRight,
                                          end: new Alignment(-1.0, -1.0)
                                      ),
                                      borderRadius: new BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Color.lerp(Colors.grey, Colors.white, 0.6),
                                          offset: new Offset(0.0, 0.0),
                                          blurRadius: 10.0,
                                        )
                                      ],


                                    ),
                                    child:
                                    Center(child: Container(child: Icon(Icons.access_time , color: Colors.pink , size: 35,),)),
                                  ),
                                ) ,
                                Container(child : Padding(
                                  padding: const EdgeInsets.only(left : 20.0),
                                  child: Text(_time.format(context) , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.w500 , color: Colors.blueGrey), ),
                                ))


                              ],


                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top : 8.0),
                            child: Row(
                              children: <Widget>[
                                Text("Category" , style: _titleStyle ),
                              ],
                            ),
                          ) ,
                          Padding(
                            padding: const EdgeInsets.only(top : 10.0),
                            child: Container(
                              child: Container(
                                height: 150,
                                margin: EdgeInsets.all(8.0),
                                child: GridView.builder(
                                  padding: EdgeInsets.all(8.0),
                                    itemCount: categories.names.length,
                                    gridDelegate:
                                    new SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 2.3,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15,
                                        crossAxisCount: 3),
                                    itemBuilder: (BuildContext context, int index) {

                                      return  GestureDetector(
                                        child:
                                        categories.getCategoryItem(index),
                                        onTap: (){
                                          categories.selected = index ;
                                          setState(() {

                                          });
                                        },
                                      );

                                    }),
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text("Priorities" , style: _titleStyle ),
                            ],
                          ) ,

                          Container(
                            child: Container(
                              height: 80,
                              margin: EdgeInsets.all(8.0),
                              child: GridView.builder(
                                padding: EdgeInsets.all(8.0),
                                  itemCount: priorities.names.length,
                                  gridDelegate:
                                  new SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 2.3,
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 15,
                                      crossAxisCount: 3),
                                  itemBuilder: (BuildContext context, int index) {

                                    return  GestureDetector(
                                      child:
                                      priorities.getCategoryItem(index),
                                      onTap: (){
                                        priorities.selected = index ;
                                        setState(() {

                                        });
                                      },
                                    );

                                  }),
                            ),
                          ),
                          Container(
                            height: 60,
                            padding: EdgeInsets.symmetric(horizontal:20,vertical: 5 ),
                            decoration: new BoxDecoration(
                              color: Color.lerp(Colors.grey, Colors.white, 0.8),
                              borderRadius: new BorderRadius.all(
                                Radius.circular(20.0),
                              ),



                            ),
                            child:
                            Center(
                              child: TextField(
                                controller: _description,
                                style: TextStyle(fontSize: 23),

                                decoration: InputDecoration.collapsed(hintText: 'Description',
                                    hintStyle: TextStyle(fontSize: 23)

                                ),
                              ),
                            ),
                          ) ,
                          Padding(
                            padding: const EdgeInsets.only(top : 15.0),
                            child: Row(
                              children: <Widget>[
                                Text("Upload Image " , style: _titleStyle,) ,
                                getImage(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top : 15.0),
                            child: Container(
                              height: 60,
                              width: 1e3,
                              decoration: new BoxDecoration(
                                gradient: new LinearGradient(
                                    colors: [c1, Color.lerp(c1, Colors.white, 0.2)],
                                    begin: Alignment.topRight,
                                    end: new Alignment(-1.0, -1.0)
                                ),
                                borderRadius: new BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                boxShadow: [
                                  new BoxShadow(
                                    color: Color.lerp(c1, Colors.white, 0.2),
                                    offset: new Offset(0.0, 0.0),
                                    blurRadius: 10.0,
                                  )
                                ],


                              ),
                              child:
                              GestureDetector(
                                onTap: (){
                                  uploadImage() ;
                                },
                                child: Center(child: Container(child: Text("Create Task" , style: TextStyle(
                                    fontSize: 25 , fontWeight: FontWeight.w600 ,color: Colors.white

                                ),),)),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ) ,


            ],)
        ),
      ),
    );
  }

  TextEditingController _nameTask = new TextEditingController() ;
  TextEditingController _description = new TextEditingController() ;
  File _image;
  String preview_path = "";
  ProgressDialog pr  ;


  void addTask(String title , DateTime time , int day )async{




    String sTime = time.hour.toString()+":"+time.minute.toString() ;
    print(baseUrl+'addTask') ;
    Map data = {
      'time': sTime,
      'day':day ,
      'done':false,
      'title':title
    } ;
    print(json.encode(data));
    await http.post(baseUrl+"addTask",body: ' {"task": '+jsonEncode(data)+'}' , headers: {
      "Content-Type": "application/json"
    }).then((http.Response response){
      print("Saving Task : "+response.statusCode.toString());
      if(response.statusCode==200){

        Navigator.pop(context);

      }
    });



  }
  Widget getImage() {
    if (_image != null) preview_path = _image.path;
    return Center(
      child:
        GestureDetector(
          onTap: (){
            getImageFromGallery().then((onValue) {
              setState(() {});
            });
          },
          child: Container(
      child :
            Card(
              child: (preview_path.isEmpty)
                  ? Container(
                height: 40,
                width: 40,
                child  : Center(
                  child: Icon(Icons.image ,color: c1,),
                )
              ):
               new Container(
                  width: 200.0,
                  height: 100.0,
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: (preview_path.isEmpty)
                              ? Image.asset(
                            "assets/userImage.jpg",
                          ).image
                              : Image.file(File(preview_path)).image))),
            ),
          ),
        ),

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


  String convertTime(var time){

    var m =time.minute.toString();
    var h=time.hour.toString();
    if(time.minute<10) m="0"+time.minute.toString() ;
    if(time.hour<10) m="0"+time.hour.toString() ;
    return h+':'+m ;


  }
  void uploadImage() async {
    pr.show();
    Map<String,String> headers = {
      "title":_nameTask.text.toString() ,
      "description" : _description.text.toString() ,
      "day" : day.toString(),
      "priority": priorities.selected.toString(),
      "category" : categories.names[categories.selected],
      "withImage" : (_image != null).toString(),
      "time" : convertTime(_time)
    };
    if(_image==null){
      http.post(baseUrl+"addTask",headers: headers).then((http.Response response){
        pr.hide();
        print("photo uploaded successfully");
        Navigator.pop(context);
      });
    }else
    await Images(_image).CompressAndGetFileWithoutRotation().then((file) async {


      print("uploading");

      await Images(file).uploadImageWithHeaders(
          baseUrl+"addTask",headers ).then((onValue) {
        pr.hide();
        print("photo uploaded successfully");
        Navigator.pop(context);
      });
    });


  }





}

class Categories{
  List<String> names = ["Basic","Food","Health","Activity"];
  int selected = 0 ;

  Widget getCategoryItem(int i){

    if(selected==i)
      return Container(
        height: 60,
        width: 150,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [Colors.indigoAccent, Colors.cyanAccent],
              begin: Alignment.centerRight,
              end: new Alignment(-1.0, -1.0)
          ),
          borderRadius: new BorderRadius.all(
            Radius.circular(20.0),
          ),



        ),
        child:
        Center(child: Container(child: Text(names[i],style: TextStyle(
          fontSize: 25 , fontWeight: FontWeight.w400 ,color: Colors.white

        ),),)),
      )  ;
      return Container(
      height: 60,
      width: 150,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.centerRight,
            end: new Alignment(-1.0, -1.0)
        ),
        borderRadius: new BorderRadius.all(
          Radius.circular(20.0),
        ),
        boxShadow: [
          new BoxShadow(
            color: Color.lerp(Colors.grey, Colors.white, 0.6),
            offset: new Offset(0.0, 0.0),
            blurRadius: 10.0,
          )
        ],


      ),
      child:
      Center(child: Container(child: Text(names[i] , style: TextStyle(
          fontSize: 25 , fontWeight: FontWeight.w400 ,color: Colors.blueGrey

      ),),)),
    )  ;


  }


}

class Priorities{
  List<String> names = ["Normal","Importand","So important"];
  List<Color> colors = [Colors.green, Colors.deepOrangeAccent, Colors.redAccent] ;
  int selected = 0 ;

  Widget getCategoryItem(int i){

    if(selected==i)
      return Container(
        height: 60,
        width: 150,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [colors[i], colors[i]],
              begin: Alignment.centerRight,
              end: new Alignment(-1.0, -1.0)
          ),
          borderRadius: new BorderRadius.all(
            Radius.circular(20.0),
          ),



        ),
        child:
        Center(child: Container(child: Text(names[i],style: TextStyle(
          fontSize: 18 , fontWeight: FontWeight.w400 ,color: Colors.white

        ),),)),
      )  ;
      return Container(
      height: 60,
      width: 150,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.centerRight,
            end: new Alignment(-1.0, -1.0)
        ),
        borderRadius: new BorderRadius.all(
          Radius.circular(20.0),
        ),
        boxShadow: [
          new BoxShadow(
            color: Color.lerp(Colors.grey, Colors.white, 0.6),
            offset: new Offset(0.0, 0.0),
            blurRadius: 10.0,
          )
        ],


      ),
      child:
      Center(child: Container(child: Text(names[i] , style: TextStyle(
          fontSize: 18 , fontWeight: FontWeight.w400 ,color: Colors.blueGrey

      ),),)),
    )  ;


  }



}
