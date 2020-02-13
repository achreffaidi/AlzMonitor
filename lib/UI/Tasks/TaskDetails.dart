import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:monitor/Api/tasks.dart';
import 'package:monitor/Api/tasksByDay.dart' as tsk;
import 'package:monitor/Constant/Strings.dart';
import 'package:monitor/Constant/colors.dart';
import 'package:http/http.dart' as http;



class TaskDetails extends StatefulWidget {
  
  List<ListByDay> list ;
  @override
  _TaskDetailsState createState() => _TaskDetailsState(list);

  TaskDetails(this.list);
}

class _TaskDetailsState extends State<TaskDetails> {
  
  List<ListByDay> list ;
  List<ListByDay> done ;
  List<ListByDay> undone ;

  _TaskDetailsState(this.list);

  @override
  Widget build(BuildContext context) {

    done = new List();
    undone = new List();
    for(ListByDay e in list) if(e.done){
      done.add(e) ;
    }else undone.add(e) ;

    return Scaffold(
      body: Container(
        
        color: c1,
        child:  Column(
          children: <Widget>[
            _getHeader(),
            _getBody() ,
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
          height: MediaQuery.of(context).size.height-200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(
                margin: EdgeInsets.only(left: 20 ,top: 60 , bottom: 10),
                child:  Text("Undone Tasks : "+undone.length.toString()+(done.isEmpty?"":" tasks"),style: TextStyle(fontSize: 30),),
              ),
              getList(),
              getFooter()



            ],)
      ),
    );
  }

  Widget getFooter(){
    return  Container(height: 100, child: Center(child  : Text("Long Click to Delete" , style: TextStyle(color : Colors.grey),))) ;
  }
  Widget _getHeader(){
    return Container(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(child: Text("Task Manager",style: TextStyle(fontSize: 30 , color: Colors.white , fontWeight: FontWeight.bold), )),
          Container(child : RaisedButton.icon(icon : Icon(Icons.add) , label: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Add Task" , style: TextStyle(fontSize: 20),),
          ), onPressed: (){
            showPopUpAddTask(list.isNotEmpty?list[0].day:0) ;
          },) )
        ],
      ),
    );
  }




  Widget getList(){
    return Container(
        height:MediaQuery.of(context).size.height-420 ,
        child : new ListView.builder
          (
            itemCount: list.length,

            itemBuilder: (BuildContext ctxt, int index) {
              return  GestureDetector(
                onLongPress: (){
                  showDeletDialog(int.parse(list[index].id), list[index].day) ;
                },
                onTap: (){
                  list[index].done = !list[index].done ;
                  setState(() {
                    list.sort((ListByDay item1,ListByDay item2){
                      if(item1.done==item2.done)return 0 ;
                      if(item1.done&!item2.done)return 1 ;
                      return -1 ;
                    });
                  });
                },
                child: getItem(list[index].title , list[index].done,false),
              );
            }

        )
    ) ;
  }



  TextEditingController _nameTask = new TextEditingController() ;
  TextEditingController _timeTask = new TextEditingController() ;
  Widget getItem(String name,bool done , isElevated){
    return Container(
      height: 120,
      margin: EdgeInsets.symmetric(horizontal:isElevated? 20 : 30),
      child:
      Card(
        elevation: isElevated?10:2,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                color: c2,
                width: 3,
                height: 100,
              ) ,

              Text(name,style: TextStyle(fontSize: 25 ,decoration: done? TextDecoration.lineThrough : TextDecoration.none , color: done? Colors.grey: Colors.black ),),
              Checkbox(value: done,onChanged: (value){

              },) ,
            ],),
        ),
      )
      ,);

  }






  void showDeletDialog(int id , int day) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Delete Task"),
          content: new Text("Do you really want to delete this task ? "),
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
                deleteTask(id, day) ;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void showPopUpAddTask(int day) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          DateTime _dateTime = new DateTime.now() ;
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 420,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20,),
                      Text(
                        "Add Task",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: _nameTask,
                        decoration: InputDecoration(hintText: 'Task'),
                      ),
                    new TimePickerSpinner(
                is24HourMode: false,
                normalTextStyle: TextStyle(
                fontSize: 24,
                color: Colors.grey
                ),
                highlightedTextStyle: TextStyle(
                    fontSize: 24,
                    color: c1
                ),
                spacing: 50,
                itemHeight: 80,
                isForce2Digits: true,
                onTimeChange: (time) {
                  setState(() {
                    _dateTime = time;
                  });
                },
              ),
                      SizedBox(
                        width: 320.0,
                        child: RaisedButton(
                          onPressed: () {
                            addTask( _nameTask.text,_dateTime,day );
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Add Task",
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

       loadTask(day);


      }
    });



  }
  void deleteTask(int id , int day )async{

    print(baseUrl+'delete/'+id.toString()) ;

     await http.post(baseUrl+'delete/'+id.toString()).then((http.Response response){
      print("Delete Task : "+response.statusCode.toString());
      if(response.statusCode==200){

       loadTask(day);


      }
    });



  }

  void loadTask(int day) async {
    print(baseUrl+"getbyday/"+day.toString());
    http.get(baseUrl+"getbyday/"+day.toString()).then((http.Response response){

      List<tsk.ListByDay> tasks = tsk.TasksByDay.fromJson(response.body).listByDay;
      print(response.body) ;
      tasks.sort((tsk.ListByDay item1,tsk.ListByDay item2){
        if(item1.done==item2.done)return 0 ;
        if(item1.done&!item2.done)return 1 ;
        return -1 ;
      });

      list = new List() ;
      //TODO Fix This
      //for(tsk.ListByDay e in tasks) list.add(e.getElement()) ;
      setState(() {

      });
    });

  }

  void setDone(String id) async {
    http.get(baseUrl+"setdone/"+id).then((http.Response response){
   //   loadTask();
      print(response.statusCode);
    });


  }
  void setUnDone(String id) async {
    http.get(baseUrl+"setundone/"+id).then((http.Response response){
   //   loadTask();
      print(response.statusCode);
    });


  }





}
