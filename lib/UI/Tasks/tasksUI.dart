import 'package:monitor/Constant/colors.dart';
import 'package:monitor/Model/Task.dart';
import 'package:flutter/material.dart';

class TasksUI extends StatefulWidget {
  @override
  _TasksUIState createState() => _TasksUIState();
}


class _TasksUIState extends State<TasksUI> {


  List<Task> done  = new List() ;
  List<String> undone  = new List() ;


  @override
  void initState() {

    done.add(new Task("Task 1",false));
    done.add(new Task("Task 2",false));
    done.add(new Task("Task 3",false));
    done.add(new Task("Task 4",false));
    done.add(new Task("Task 5",false));
    done.add(new Task("Task 6",false));


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
           margin: EdgeInsets.only(left: 20 ,top: 60),
           child:  Text("Undone Tasks : "+done.length.toString()+(done.isEmpty?"":" tasks"),style: TextStyle(fontSize: 30),),
         ),
          getList(),



        ],)
      ),
    );
  }

  Widget _getHeader(){
    return Container(
      height: 200,
      child: Center(child: Text("Monday, 15 October 2018",style: TextStyle(fontSize: 30 , color: Colors.white , fontWeight: FontWeight.bold), )),
    );
  }




  Widget getList(){
    return Container(
      height:MediaQuery.of(context).size.height-300 ,
        child : new ListView.builder
          (
            itemCount: done.length,

            itemBuilder: (BuildContext ctxt, int index) {
              return  GestureDetector(
                onTap: (){
                  done[index].isDone = !done[index].isDone ;
                  setState(() {
                    done.sort((Task item1,Task item2){
                      if(item1.isDone==item2.isDone)return 0 ;
                      if(item1.isDone&!item2.isDone)return 1 ;
                      return -1 ;
                    });
                  });
                },
                child: getItem(done[index].name , done[index].isDone,index==0),
              );
            }

        )
    ) ;
  }


  Widget getItem(String name,bool isDone , isElevated){
    return Container(
      height: 150,
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

          Text(name,style: TextStyle(fontSize: 25 ,decoration: isDone? TextDecoration.lineThrough : TextDecoration.none , color: isDone? Colors.grey: Colors.black ),),
            Checkbox(value: isDone,onChanged: (value){

            },) ,
          ],),
      ),
    )
      ,);

  }
}
