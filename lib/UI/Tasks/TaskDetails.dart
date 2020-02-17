import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:monitor/Api/tasks.dart';
import 'package:monitor/Api/tasksByDay.dart' as tsk;
import 'package:monitor/Api/tasksByDay.dart' as tsk;
import 'package:monitor/Constant/Strings.dart';
import 'package:monitor/Constant/colors.dart';
import 'package:http/http.dart' as http;

import 'CreateTask.dart';

class TaskDetails extends StatefulWidget {

  int day ;
  @override
  _TaskDetailsState createState() => _TaskDetailsState(day);


  TaskDetails(this.day);
}

class _TaskDetailsState extends State<TaskDetails> {


  int day ;
  List<tsk.ListByDay> list;
  List<tsk.ListByDay> done;
  List<tsk.ListByDay> undone;
  List<bool> expanded;


  @override
  void initState() {
    loadTask(day);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    done = new List();
    undone = new List();
    if (list != null)
      for (tsk.ListByDay e in list)
        if (e.done) {
          done.add(e);
        } else
          undone.add(e);

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
                "",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            _getBody()
          ],
        ) /* add child content here */,
      ),
    );
  }

  Widget _getBody() {
    return Container(
      height: MediaQuery.of(context).size.height - 130,
      child: Container(
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                getList(),
                getFooter()
              ],
            )),
      ),
    );
  }

  Widget _getBodyDeprecated() {
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
          height: MediaQuery.of(context).size.height - 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20, top: 60, bottom: 10),
                child: Text(
                  "Undone Tasks : " +
                      undone.length.toString() +
                      (done.isEmpty ? "" : " tasks"),
                  style: TextStyle(fontSize: 30),
                ),
              ),
              getList(),
              getFooter()
            ],
          )),
    );
  }

  Widget getFooter() {
    double circle = 70;
    return GestureDetector(
      onTap: () {
        showPopUpAddTask();
      },
      child: Container(
        width: circle,
        height: circle,
        child: new Container(
          child: Center(
              child: Icon(
            Icons.add,
            color: Colors.white,
            size: 55,
          )),
        ),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [c1, Colors.cyan],
              begin: Alignment.centerRight,
              end: new Alignment(-1.0, -1.0)),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _getHeader() {
    return Container(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
              child: Text(
            "Task Manager",
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          )),
        ],
      ),
    );
  }

  Widget getList() {
    if (list == null || list.isEmpty) return Container();
    return Container(
        height: MediaQuery.of(context).size.height - 300,
        child: new ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return GestureDetector(
                onLongPress: () {
                  showDeletDialog(list[index].id);
                },
                onTap: () {
                  list[index].done = !list[index].done;
                  setState(() {
                    /*  list.sort((ListByDay item1,ListByDay item2){
                      if(item1.done==item2.done)return 0 ;
                      if(item1.done&!item2.done)return 1 ;
                      return -1 ;
                    });*/
                  });
                },
                child: getItem(list[index], index),
              );
            }));
  }

  TextEditingController _nameTask = new TextEditingController();
  TextEditingController _timeTask = new TextEditingController();
  Widget getItem(tsk.ListByDay item, index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Card(
          elevation: 2,
          child: Container(
            child: ExpansionPanelList(
                expansionCallback: (_, val) {
                  setState(() {
                    var  x = ! expanded[index] ;
                    for(int i = 0 ; i< expanded.length ; i++) expanded[i] = false ;
                    expanded[index] = x ;
                  });
                },
                children: <ExpansionPanel>[
                  ExpansionPanel(
                    canTapOnHeader: true,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Container(
                          padding: EdgeInsets.all(5), //Set Padding form here !!
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: new LinearGradient(
                                    colors: [
                                      Color.lerp(c1, Colors.white, 0.3),
                                      c1
                                    ],
                                    begin: Alignment.topRight,
                                    end: new Alignment(-1.0, -1.0)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Container(

                                  padding: EdgeInsets.only(left: 20 ,top: 8 ,bottom: 8),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        item.done
                                            ? Icons.check_box
                                            : Icons.check_box_outline_blank,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                          child: Text(
                                        item.title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 23),
                                      )),
                                      Text(
                                        item.time,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                            fontSize: 23),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10),
                                        child: GestureDetector(
                                            onTap: () {
                                              showDeletDialog(item.id);
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            )),
                                      )
                                      //      getProgressWidget(item.list,  getColor(item.toDoC.subColor)),
                                    ],
                                  ))));
                    },
                    body: Container(
                        padding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 10),
                        child: Container(child: _getItemBody(item))),
                    isExpanded: expanded[index],
                  )
                ]),
          )),
    );
  }

  void showDeletDialog(String id) {
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
                deleteTask(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showPopUpAddTask() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateTask(day)),
    ).then((value){
      loadTask(day);
    });
  }

  void addTask(String title, DateTime time, int day) async {
    String sTime = time.hour.toString() + ":" + time.minute.toString();
    print(baseUrl + 'addTask');
    Map data = {'time': sTime, 'day': day, 'done': false, 'title': title};
    print(json.encode(data));
    await http.post(baseUrl + "addTask",
        body: ' {"task": ' + jsonEncode(data) + '}',
        headers: {
          "Content-Type": "application/json"
        }).then((http.Response response) {
      print("Saving Task : " + response.statusCode.toString());
      if (response.statusCode == 200) {
        loadTask(day);
      }
    });
  }

  void deleteTask(String id) async {
    print(baseUrl + 'delete/' + id.toString());

    await http
        .post(baseUrl + 'delete/' + id)
        .then((http.Response response) {
      print("Delete Task : " + response.statusCode.toString());
      if (response.statusCode == 200) {
        loadTask(day);
      }
    });
  }

  void loadTask(int day) async {
    print(baseUrl + "getbyday/" + day.toString());
    http
        .get(baseUrl + "getbyday/" + day.toString())
        .then((http.Response response) {
      List<tsk.ListByDay> tasks =
          tsk.TasksByDay.fromJson(response.body).listByDay;
      print(response.body);
      tasks.sort((tsk.ListByDay item1, tsk.ListByDay item2) {
        if (item1.done == item2.done) return 0;
        if (item1.done & !item2.done) return 1;
        return -1;
      });

      list = tasks;
      expanded = new List(list.length);
      for (int i = 0; i < expanded.length; i++) expanded[i] = false;

      setState(() {});
    });
  }

  void setDone(String id) async {
    http.get(baseUrl + "setdone/" + id).then((http.Response response) {
      //   loadTask();
      print(response.statusCode);
    });
  }

  void setUnDone(String id) async {
    http.get(baseUrl + "setundone/" + id).then((http.Response response) {
      //   loadTask();
      print(response.statusCode);
    });
  }

  _getItemBody(tsk.ListByDay item) {
    var _titleStyle = new TextStyle(
        fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black54);
    String pri;
    if (item.priority == 0) {
      pri = "Normal";
    } else if (item.priority == 1) {
      pri = "Important";
    } else
      pri = "So Important";
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Description : ",
              style: _titleStyle,
            ),
            Container(
              width: 250,
              child: Text(
                item.description,
                style: TextStyle(fontSize: 22),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              "Priority : ",
              style: _titleStyle,
            ),
            Text(
              pri,
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
        item.imageUrl == null
            ? Container()
            : Container(
                height: 200,
                width: 300,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: new BoxDecoration(
                  image: DecorationImage(image: Image.network(
                    item.imageUrl,
                    height: 200,
                    width: 300,
                    fit: BoxFit.cover,
                  ).image , fit: BoxFit.cover) ,
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(
                       Radius.circular(20.0)),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      spreadRadius: 0.2,
                      offset: new Offset(-3, -2.0),
                    )
                  ],

                ),

                )
      ],
    );
  }

  _TaskDetailsState(this.day);
}
