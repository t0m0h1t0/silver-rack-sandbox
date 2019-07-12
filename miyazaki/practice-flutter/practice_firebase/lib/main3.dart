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
      home: FirebaseChatPage(),
    );
  }
}

class FirebaseChatPage extends StatefulWidget {
  @override
  _FirebaseChatPageState createState() => new _FirebaseChatPageState();
}

void submit() {
    FirebaseDatabase.instance.reference().child('0').set(
        {
            'age': "25",
            'gmail': "tatsumiya05@gmail.com",
            'lineid': "tsutarou52",
            'name': "Tatsuro Miyazaki",
            'sex': "1",
        }
    );
}

void update() {
    FirebaseDatabase.instance.reference().child('0').update(
        {
            'name': "tatsuro",
        }
    );
}

void delete() {
    FirebaseDatabase.instance.reference().child('recent').remove();
}

void read() {
    FirebaseDatabase.instance.reference().child('0').once().then((DataSnapshot snapshot) {
    print('Data : ${snapshot.value}');
  });
}

class _FirebaseChatPageState extends State<FirebaseChatPage> {

    Widget _buildButtonColumn(IconData icon, String label) {
        final color = Theme.of(context).primaryColor;
        return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                Icon(icon, color: color), // 3.1.1
                Container( // 3.1.2
                    margin: const EdgeInsets.only(top: 8.0),
                    child: Text(
                        label,
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: color
                        ),
                    ),
                ),
            ],
        );
    }

    // 画面全体のビルド
    @override
    Widget build(BuildContext context) {
        //submit();
        //update();
        //delete();
        //read();
        /*
        return Scaffold(
            appBar: AppBar(
                title: new Text("Firebase Chat")
            ),
            body: MyCustomForm(),
            body: Column(
                children: [
                    TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "textbox",
                            hintText: "Input text",
                        ),
                    ),
                    IconButton(
                        icon: Icon(Icons.send),
                        onPressed: (){},
                    ),

                ],
            ),
        );
        */
        return MaterialApp(
            title: 'hoge',
            home: MyCustomForm(),
        );
    }

}

class MyCustomForm extends StatefulWidget {
    @override
    _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
    final myController = TextEditingController();

    @override
    void dispose() {
        myController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('HOGE'),
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                    controller: myController,
                ),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                    return showDialog(
                        context: context,
                        builder: (context) {
                            return AlertDialog(
                                content: Text(myController.text),
                            );
                        },
                    );
                },
                tooltip: 'show me the value!',
                child: Icon(Icons.send),
            ),
        );
    }
}
