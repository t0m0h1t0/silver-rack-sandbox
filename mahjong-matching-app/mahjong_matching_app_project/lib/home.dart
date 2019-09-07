part of 'main.dart';

class Home extends StatelessWidget {
    final title;
    final user_gmail_address;

    const Home(this.title, this.user_gmail_address): super();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Container(
                padding: const EdgeInsets.all(16.0),
                child: HomeChild(this.user_gmail_address),
            ),
        );
    }
}

class HomeChild extends StatefulWidget {
    final user_gmail_address;

    const HomeChild(this.user_gmail_address): super();
    @override
    _HomeChild createState() => new _HomeChild();
}

class _HomeChild extends State<HomeChild> {
    String message;
    List entries = new List();
    int cnt = 0;

    @override
    initState() {
        var _mainReference = FirebaseDatabase.instance.reference().child("gmail").child(widget.user_gmail_address);
        super.initState();
        _mainReference.onChildAdded.listen(_onEntryAdded);
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

    @override
    Widget build(BuildContext context){
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

class AccountPage extends StatefulWidget {
    final user_gmail_address;
    const AccountPage(this.user_gmail_address):super();
    @override
    _AccountPage createState() => new _AccountPage();
}

class _AccountPage extends State<AccountPage> {

    List entries = new List();
    final title = 'Account';

    String _type = '1';
    String _sex  = '0';
    int count    = 0;

    TextEditingController userNameInputController;
    TextEditingController userAgeInputController;
    TextEditingController userLineIdInputController;
    TextEditingController userGmailInputController;
    final _formKey = GlobalKey<FormState>();

    @override
    initState() {
        var _mainReference = FirebaseDatabase.instance.reference().child("gmail").child(widget.user_gmail_address);
        super.initState();
        _mainReference.onChildAdded.listen(_onEntryAdded);
    }

    setDefaultValue() { // TextFormFieldの初期値をfirebaseから取得して代入
        userNameInputController = new TextEditingController(text: entries[3].split(':')[1]);
        userAgeInputController = new TextEditingController(text: entries[0].split(':')[1]);
        userLineIdInputController = new TextEditingController(text: entries[1].split(':')[1]);
        userGmailInputController = new TextEditingController(text: 'gmail');
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

    void _handleRadio(String e) => setState(()
            //ラジオボタンを操作するときに使う
            {
                _type = e;
                _sex  = e;
            });

    void submit(user_gmail_address) {
        var user_name   = userNameInputController.text;
        var user_age    = userAgeInputController.text;
        var user_lineid = userLineIdInputController.text;

        FirebaseDatabase.instance.reference().child("gmail").child(user_gmail_address).set(
                {
                    'user_name' : user_name,
                    'age': user_age,
                    'sex': _sex,
                    'line_id': user_lineid,
                }
        );

        //userNameInputController.clear(); // 送信した後テキストフォームの文字をクリア
        print('finish register.');
    }

    @override
    Widget build(BuildContext context) {
        setDefultValue();
        return Scaffold(
            appBar: AppBar(
                title: Text('Account'),
                backgroundColor: Colors.green,
            ),
            body: Form (
                key: _formKey,
                child: Container(
                    child: Column(
                        children: [
                            TextFormField(
                                controller: userNameInputController,
                                decoration: InputDecoration(
                                    labelText: 'Enter your username',
                                ),
                                validator: (value) {
                                    return value.isEmpty ? 'You must enter your gmail address.': null;
                                },
                            ),
                            TextFormField(
                                controller: userAgeInputController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: 'Enter your age',
                                ),
                                validator: (value) {
                                    if (value.isEmpty) {
                                        return 'Please enter your username';
                                    }
                                    return null;
                                },
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
                                    Expanded(
                                        child: RadioListTile(
                                            activeColor: Colors.blue,
                                            controlAffinity: ListTileControlAffinity.trailing,
                                            title: Text('else'),
                                            value: '3',
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
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                    Expanded(
                                        child: IconButton(
                                            icon: Icon(Icons.keyboard_return),
                                            onPressed:() {
                                                Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) => Main(widget.user_gmail_address),
                                                    ),
                                                );
                                            }
                                        ),
                                    ),
                                    Expanded(
                                        child: IconButton(
                                            icon: Icon(Icons.send),
                                            onPressed:(){
                                                if(_formKey.currentState.validate()) {
                                                    this._formKey.currentState.save();
                                                    submit(widget.user_gmail_address);
                                                    Navigator.of(context).pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (context) => Main(widget.user_gmail_address),
                                                        ),
                                                    );
                                                }
                                            },
                                        ),
                                    ),
                                ],
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}

