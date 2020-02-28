import 'package:flutter/material.dart';
import 'package:monitor/Api/memories.dart';
import 'package:http/http.dart' as http;
import 'package:monitor/Constant/Strings.dart';
import 'package:monitor/Constant/colors.dart';

import 'addMemories.dart';

class MemoriesSettings extends StatefulWidget {
  @override
  _MemoriesSettingsState createState() => _MemoriesSettingsState();
}

class _MemoriesSettingsState extends State<MemoriesSettings> {

  List<Picture> list = new List();
  Memories memories ;
  List<bool> expanded;


  @override
  void initState() {
    loadPicture();
    super.initState();
  }

  void loadPicture() async {

    print("loading pictures ") ;
    await http.get(baseUrl+"memories").then((http.Response response){
      print(response.statusCode) ;
      memories = Memories.fromJson(response.body);
      list =memories.pictures ;
      expanded= new List(list.length);
      for(int i = 0 ; i < list.length ; i++) expanded[i]= false  ;
      setState(() {

      });
    });
  }





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



  Widget getList() {
    if (list == null || list.isEmpty) return Container();
    return Container(
        height: MediaQuery.of(context).size.height - 300,
        child: new ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return getItem(list[index], index);
            }));
  }

  Widget getItem(Picture item, index) {
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
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                          child: Text(
                                            item.title ,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 23),
                                          )),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10),
                                        child: GestureDetector(
                                            onTap: () {
                                              showDeletDialog(item.pictureId);
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
          title: new Text("Delete Memory"),
          content: new Text("Do you really want to delete this Memory ? "),
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
                deletePicture(id);
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
      MaterialPageRoute(builder: (context) => AddMemories()),
    ).then((value){
loadPicture() ;    });
  }



  void deletePicture(String id) async {
    print(baseUrl + 'memories/delete/' + id.toString());
    await http
        .post(baseUrl + 'memories/delete/' + id)
        .then((http.Response response) {
      print("Delete Task : " + response.statusCode.toString());
      if (response.statusCode == 200) {
        loadPicture() ;
      }
    });
  }




  _getItemBody(Picture item) {
    var _titleStyle = new TextStyle(
        fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black54);

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

        item.pictureUrl == null
            ? Container()
            : Container(
          height: 200,
          width: 300,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: new BoxDecoration(
            image: DecorationImage(image: Image.network(
              item.pictureUrl,
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

}
