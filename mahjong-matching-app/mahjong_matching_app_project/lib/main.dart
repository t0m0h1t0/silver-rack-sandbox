import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_database/firebase_database.dart';
part 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Majong Matching App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Main("tatsumiya05"),
    );
  }
}


class Main extends StatefulWidget {
    final user_gmail_address;
    const Main(this.user_gmail_address): super();
  @override
  _Main createState() => new _Main();
}

class _Main extends State<Main> {

    PageController _pageController;
    int currentIndex       = 0;
    int _page              = 0;
    String tab_home        = 'HOME';
    String tab_search      = 'Search';
    String tab_recruitment = 'Recruitment';
    List entries = new List();

    @override
    void initState() {
        super.initState();
        _pageController = new PageController();
        var _mainReference = FirebaseDatabase.instance.reference().child("gmail").child(widget.user_gmail_address);
        _mainReference.onChildAdded.listen(_onEntryAdded);
    }

    @override
    void dispose() {
        super.dispose();
        _pageController.dispose();
    }

    void onTabTapped(int index) {
        currentIndex = index;
        _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 1),
            curve: Curves.ease
        );
    }

    void onPageChanged(int page) {
        if(this.mounted){
            setState((){
                this._page = page;
            });
        }
    }

    @override
    _onEntryAdded(Event e) {
        if(this.mounted){
            setState(() {
                if(e.snapshot.key == 'gmail_address') {
                    entries.add(e.snapshot.key + ' : ' + e.snapshot.value + "@gmail.com");
                } else if(e.snapshot.key == 'sex') {
                    if(e.snapshot.value == '1') {
                        entries.add(e.snapshot.key + ' : ' + 'man');
                    } else if(e.snapshot.value == '2'){
                        entries.add(e.snapshot.key + ' : ' + 'woman');
                    } else {
                        entries.add(e.snapshot.key + ' : ' + 'else');
                    }
                } else {
                    entries.add(e.snapshot.key + ' : ' + e.snapshot.value);
                }
            });
        }
    }

    // 画面全体のビルド
    @override
    Widget build(BuildContext context) {
        debugPrint("$entries");
        return Scaffold(
            appBar: AppBar(
                title: Text('雀士マッチングアプリ'),
                actions: [
                    IconButton(
                        icon: Icon(Icons.account_circle),
                        onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => AccountPage(widget.user_gmail_address, entries),
                                ),
                            );
                        },
                    ),
                ],
                backgroundColor: Colors.green,
            ),

            body: PageView(
                controller: _pageController,
                onPageChanged: onPageChanged,
                children: [
                    // 各々が作った画面をここに書く
                    Home(tab_home, widget.user_gmail_address),
                    Home(tab_search, widget.user_gmail_address),
                    Home(tab_recruitment, widget.user_gmail_address),
                ],
            ),
            bottomNavigationBar: BottomNavigationBar(
                onTap: onTabTapped,
                currentIndex: currentIndex,
                items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        title: Text(tab_home),
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.search),
                        title: Text(tab_search),
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.chat),
                        title: Text(tab_recruitment),
                    ),
                ],
                type: BottomNavigationBarType.fixed, // 4つ以上BottomNavigationBarを使うときには必要らしい
            ),
        );
    }
}

