import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'EventSearch.dart';
import 'Recritment.dart';

//ホーム画面のrun
void main() =>
    runApp(new MaterialApp(
      title: "Home",
      home: new Home(),
    ));

/*----------------------------------------------

ホーム(BottomNavigationBar)クラス

----------------------------------------------*/
class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}
class HomeState extends State<Home> {
  int currentIndex = 0;
  final List<Widget> tabs = [
    Main(),
    //EventManage(key: PageStorageKey('EventManage'),),
    EventManage(),
    RecruitmentPage(),
    SampleTabItem("Settings", Colors.red),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  //final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Matching App"),
        backgroundColor: Colors.pink[300],
      ),
//      body:PageStorage(
//        child: tabs[currentIndex],
//        bucket: bucket,
//      ),
      body:tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.pink[300],
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            backgroundColor: Colors.pink[300],
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(const IconData(59574, fontFamily: 'MaterialIcons')),
            backgroundColor: Colors.pink[300],
            title: new Text('Search'),
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.person),
              backgroundColor: Colors.pink[300],
              title: new Text('Recruitment')
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.settings),
              backgroundColor: Colors.pink[300],
              title: new Text("Settings")
          ),
        ],
      ),
    );
  }
}


/*----------------------------------------------

ホーム(メインページ)クラス

----------------------------------------------*/
class Main extends StatefulWidget {
  const Main() : super();

  // アロー関数を用いて、Stateを呼ぶ
  @override
  MainState createState() => new MainState();
}

class MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('メイン',
                  style: new TextStyle(
                      color: Colors.white,
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
