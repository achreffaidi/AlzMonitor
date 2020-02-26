import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:monitor/Constant/colors.dart';

import 'Map/MapUI.dart';
import 'Tasks/tasksUI.dart';
import 'Dashboard/Dashboard.dart';

class SubMain extends KFDrawerContent {
  @override
  _SubMainState createState() => _SubMainState();
}

class _SubMainState extends State<SubMain> {
  int _currentIndex = 1;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);


  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/homebackground.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[

            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.menu,color: Colors.white,),
                onPressed: widget.onMenuPressed,),
            )
            ,
            Container(
              height: MediaQuery.of(context).size.height-150,
              child: SizedBox.expand(

                child: PageView(

                  controller: _pageController,

                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  children: <Widget>[
                    TasksUI(),
                    Dashboard(),
                  MapUI(),


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(

        showElevation: true,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[


          BottomNavyBarItem(
              activeColor: c1,
              inactiveColor: Colors.blue,
              title: Text('Task Manager'),
              icon: Icon(Icons.playlist_add_check)
          ),
          BottomNavyBarItem(
              activeColor: c1,
              inactiveColor: Colors.blue,
              title: Text('Dashboard'),
              icon: Icon(Icons.dashboard)
          ),
          BottomNavyBarItem(
              activeColor: c1,
              inactiveColor: Colors.blue,
              title: Text('Map'),
              icon: Icon(Icons.map)
          ),
        ],
      ),
    );
  }
}