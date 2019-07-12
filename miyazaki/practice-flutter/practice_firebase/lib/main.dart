import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_database/firebase_database.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _Home createState() => new _Home();
}

class _Home extends State<Home> {

    PageController _pageController;
    int currentIndex = 0;
    int _page        = 0;
    String tab1      = 'HOME';
    String tab2      = 'Search';
    String tab3      = 'Recruitment';
    String tab4      = 'Account';
    String tab5      = 'Chat';


    @override
    void initState() {
        super.initState();
        _pageController = new PageController();
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
        setState((){
            this._page = page;
        });
    }

    // 画面全体のビルド
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('雀士マッチングアプリ'),
                backgroundColor: Colors.green,
            ),
            body: PageView(
                controller: _pageController,
                onPageChanged: onPageChanged,
                children: [
                    TabItem(tab1),
                    TabItem(tab2),
                    TabItem(tab3),
                    AccountPage(),
                    TabItem(tab5),
                ],
            ),
            bottomNavigationBar: BottomNavigationBar(
                onTap: onTabTapped,
                currentIndex: currentIndex,
                items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        title: Text(tab1),
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.search),
                        title: Text(tab2),
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.chat),
                        title: Text(tab3),
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings),
                        title: Text(tab4),
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.chat),
                        title: Text(tab5),
                    ),
                ],
                type: BottomNavigationBarType.fixed, // 4つ以上BottomNavigationBarを使うときには必要らしい
            ),
        );
    }
}

class TabItem extends StatelessWidget {
    final title;

    const TabItem(this.title): super();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Container(
                padding: const EdgeInsets.all(16.0),
                child: TabItemChild(),
            ),
        );
    }
}

class TabItemChild extends StatefulWidget {
    @override
    _TabItemChild createState() => new _TabItemChild();
}

class _TabItemChild extends State<TabItemChild> {
    final _mainReference = FirebaseDatabase.instance.reference().child("message");
    String message;
    List entries = new List();

    @override
    initState() {
        super.initState();
        _mainReference.onChildAdded.listen(_onEntryAdded);
    }

    _onEntryAdded(Event e) {
        setState(() {
            entries.add(e.snapshot.value["text"]);
        });
    }

    @override
    Widget build(BuildContext context){
        //_mainReference.onChildAdded.listen(_onEntryAdded);
        return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
                return _buildRow(index);
            },
            itemCount: entries.length,
        );
    }

    Widget _buildRow(int index) {
        return Card(
            child: ListTile(
                title: Text(entries[index]),
            ),
        );
    }

}

class ChatEntry { //チャットのときに使おうとしているクラス

    String key;
    DateTime dateTime;
    String message;

    ChatEntry(this.dateTime, this.message);

    ChatEntry.fromSnapShot(DataSnapshot snapshot):
        key = snapshot.key,
        dateTime = new DateTime.fromMillisecondsSinceEpoch(snapshot.value["date"]),
        message = snapshot.value["message"];

    toJson() {
        return {
            "date": dateTime.millisecondsSinceEpoch,
            "message": message,
        };
    }
}

class AccountPage extends StatefulWidget {
    @override
    _AccountPage createState() => new _AccountPage();
}

class _AccountPage extends State<AccountPage> {

    final title = 'Account';

    String _type = '';
    String _sex  = '0';
    int count    = 0;

    final userNameInputController   = TextEditingController();
    final userAgeInputController    = TextEditingController();
    final userLineIdInputController = TextEditingController();
    final userGmailInputController  = TextEditingController();

    void _handleRadio(String e) => setState(()
            //ラジオボタンを操作するときに使う
            {
                _type = e;
                _sex  = e;
            });

    void submit() {
        var user_name   = userNameInputController.text;
        var user_age    = userAgeInputController.text;
        var user_lineid = userLineIdInputController.text;
        var user_gmail  = userGmailInputController.text.replaceAll(RegExp(r'@[A-Za-z]+.[A-Za-z]+'), ''); // .をfirst keyに使えないから@以下を消している

        FirebaseDatabase.instance.reference().child("gmail").set(
                {
                    user_gmail: user_name
                }
        );

        FirebaseDatabase.instance.reference().child(user_gmail).set(
                {
                    "age": user_age,
                    "sex": user_age,
                    "evaluation": "4",
                    "lineid": user_lineid,
                    "messages" : {
                        "foo" : {
                            "3419-3419-01" : "hello",
                            "213-32139-01" : "goodbye"
                        }
                    }
                }
        );

        //userNameInputController.clear(); // 送信した後テキストフォームの文字をクリア
        print('finish register.');
    }

    @override
    Widget build(BuildContext context) {
        return Container(
            child: Column(
                children: [
                    TextFormField(
                        controller: userGmailInputController,
                        decoration: InputDecoration(
                            labelText: 'Enter your gmail address',
                        ),
                    ),
                    TextFormField(
                        controller: userNameInputController,
                        decoration: InputDecoration(
                            labelText: 'Enter your username',
                        ),
                    ),
                    TextFormField(
                        controller: userAgeInputController,
                        decoration: InputDecoration(
                            labelText: 'Enter your age',
                        ),
                    ),
                    Row (
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                            Expanded(
                                child: RadioListTile(
                                    activeColor: Colors.blue,
                                    controlAffinity: ListTileControlAffinity.trailing,
                                    title: Text('male'),
                                    value: '1',
                                    groupValue: _type,
                                    onChanged: _handleRadio,
                                ),
                            ),
                            Expanded(
                                child: RadioListTile(
                                    activeColor: Colors.blue,
                                    controlAffinity: ListTileControlAffinity.trailing,
                                    title: Text('female'),
                                    value: '2',
                                    groupValue: _type,
                                    onChanged: _handleRadio,
                                ),
                            ),
                        ],
                    ),
                    TextFormField(
                        controller: userLineIdInputController,
                        decoration: InputDecoration(
                            labelText: 'Enter line ID',
                        ),
                    ),
                    IconButton(
                        icon: Icon(Icons.send),
                        onPressed:(){
                            submit();
                        },
                    )
                ],
            ),
        );
    }
}

