import 'dart:io';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:monitor/tools/CameraController.dart';
import 'package:monitor/tools/Images.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_map_location_picker/generated/i18n.dart' as location_picker;
import 'Constant/colors.dart';
import 'UI/ExtandBrain/ExtandBrain.dart';
import 'UI/HomeScreen.dart';
import 'UI/Profile/ProfileUI.dart';
import 'UI/Settings/Settings.dart';
import 'UI/SubMain.dart';
import 'UI/User/User.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: const [
        location_picker.S.delegate,

      ],
      supportedLocales: const <Locale>[
        Locale('en', ''),
        Locale('ar', ''),
      ],
      home: MyHomePage(),

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}




class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;


  KFDrawerController _drawerController;

  @override
  void initState() {

    TextStyle textStyle = new TextStyle(color: Colors.white ,fontWeight: FontWeight.w300  , fontSize: 30) ;
    _drawerController = KFDrawerController(
      initialPage: SubMain(),

      items: [
        KFDrawerItem.initWithPage(
          text: Text('Home', style: textStyle),
          icon: Icon(Icons.home, color: Colors.white),
          page: SubMain(),
        ),
        KFDrawerItem.initWithPage(
          text: Text('Profile', style: textStyle),
          icon: Icon(Icons.supervised_user_circle, color: Colors.white),
          page: ProfileUI(),
        ),


        KFDrawerItem.initWithPage(
          text: Text(
            'Face Recognition',
            style: textStyle,
          ),
          icon: Icon(Icons.cloud_upload, color: Colors.white),
          page: ExtandBrain(),
        ),

        KFDrawerItem(
          text: Center(
            child: Container(
                margin: EdgeInsets.only(top : 0),
                height: 100,
                width: 220,
                child: FlareActor("assets/heartbeat.flr", alignment:Alignment.center, fit:BoxFit.fill, animation:"Untitled")),
          )
        ),

        KFDrawerItem.initWithPage(
          text: Text(
            'SETTINGS',
            style: textStyle,
          ),
          icon: Icon(Icons.settings, color: Colors.white),
          page: Settings(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'GET HELP',
            style: textStyle,
          ),
          icon: Icon(Icons.help, color: Colors.white),
          page: Settings(),
        ),
        KFDrawerItem.initWithPage(
          text: Container(height: 300,),
          icon: Container(),
          page: HomeScreen(),
        ),
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: KFDrawer(
        controller: _drawerController,

        header: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            width: MediaQuery.of(context).size.width * 0.6,
            child: Container(
              padding: EdgeInsets.only(top: 40 , bottom: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(height: 70 ,width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: Image.network("https://s.marketwatch.com/public/resources/images/MW-GG584_elonmu_ZH_20180401183848.jpg").image ,fit: BoxFit.cover)
                  ),) ,
                  Container( padding: EdgeInsets.only(left: 60), child: Text("Elon Musk" ,style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w300 , fontSize: 30),),)
                ],
              ),
            ),
          ),
        ),
        footer: KFDrawerItem(

          text: Text(
            'Logout',
            style: TextStyle(color: Colors.white , fontWeight: FontWeight.w300 , fontSize: 20 ),
          ),
          icon: Icon(
            Icons.input,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) {
                return HomeScreen();
              },
            ));
          },
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromRGBO(166, 114, 255, 1.0), Color.fromRGBO(109, 91, 254, 1.0)],
            tileMode: TileMode.clamp,
          ),
        ),
      ),
    );
  }


}
