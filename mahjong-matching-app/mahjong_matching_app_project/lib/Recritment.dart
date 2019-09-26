import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'EventSearch.dart';
import 'Entity.dart';
import 'package:flutter_cupertino_data_picker/flutter_cupertino_data_picker.dart';

/*----------------------------------------------

イベント作成フォームページクラス

----------------------------------------------*/
class RecruitmentPage extends StatefulWidget {
  // アロー関数を用いて、Stateを呼ぶ
  @override
  RecruitmentPageState createState() => new RecruitmentPageState();
}
class RecruitmentPageState extends State<RecruitmentPage> {

  //送信用変数
  String _selectPref = null;
  String _selectLine = null;
  String _selectStation = null;
  String _selectRecruitMember = null;
  DateTime _start;
  DateTime _end;
  String _remarks;

  List lineData = [""];
  List stationData = [""];

  int changePref = 0;
  int changeLine = 0;
  int changeStation = 0;

  Map lineMap;
  Map stationMap;

  TextEditingController _startingController = new TextEditingController(text: '');
  TextEditingController _endingController = new TextEditingController(text: '');
  TextEditingController _memberController = new TextEditingController(text: '');
  TextEditingController _prefController = new TextEditingController(text: '');
  TextEditingController _lineController = new TextEditingController(text: '');
  TextEditingController _stationController = new TextEditingController(text: '');

  final _formKey = GlobalKey<FormState>();
  final EventCreate em = new EventCreate();
  final List<String> _numberOfRecruit = <String>['1', '2', '3'];
  final formatter = new DateFormat( 'yyyy/MM/dd(E) HH:mm'); // 日時を指定したフォーマットで指定するためのフォーマッター

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(40.0),
        child: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  Text('募集条件を入力してください'),
                  _recruitMemberPicker(), //募集人数プルダウン
                  _prefPicker(), //都道府県Picker
                  _linePicker(), //路線Picker
                  _stationPicker(), //駅名Picker
                  _startTimePicker(), //開始日時プルダウン
                  _endTimePicker(), //終了日時プルダウン
                  _remarksField(),
                  RaisedButton(
                    onPressed: _submission,
                    child: Text('募集する'),
                  )
                ]
            )
        ),
      ),
    );
  }
  void _prefChange(String newValue) {
    setState(() {
      changePref = 1;
      if(changeLine != 0 || changeStation != 0){
        changeLine = 2;
        changeStation = 2;
      }
      int prefNum = int.parse(Pref.pref[newValue]);
      lineMap = new Map<String, int>();
      var url = 'http://www.ekidata.jp/api/p/' + prefNum.toString() + '.json';
      http.get(url).then((response) {
        var body = response.body.substring(50, response.body.length - 58);
        var mapLine = jsonDecode(body);
        mapLine["line"].forEach((i) {
          lineMap[ i["line_name"] ] = i["line_cd"];
        });
        //lineMap.forEach((key,value) => lineData.add(key));
        lineData = lineMap.keys.toList();
      });
    });
  }
  void _lineChange(String newValue) {
    setState(() {
      if(changeLine == 0){
        changeLine = 1;
      }else if(changeLine == 1){
        if(changeStation != 0){
          changeStation = 2;
        }
      }else{
        changeLine = 1;
      }
      _selectLine = newValue;
      int lineNum = lineMap[newValue];
      stationMap = new Map<String, int>();
      var url = 'http://www.ekidata.jp/api/l/' + lineNum.toString() + '.json';
      http.get(url).then((response) {
        var body = response.body.substring(50, response.body.length - 58);
        var mapStation = jsonDecode(body);
        mapStation["station_l"].forEach((i) {
          stationMap[ i["station_name"] ] = i["station_cd"];
        });
        //lineMap.forEach((key,value) => lineData.add(key));
        stationData = stationMap.keys.toList();
      });
    });
  }
  void _stationChange(String newValue) {
    setState(() {
      changeStation = 1;
      _selectStation = newValue;
    });
  }
  //フォーム送信用
  void _submission() {
    if (this._formKey.currentState.validate()) {
      this._formKey.currentState.save();
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Processing Data')));
      EventEntity event = new EventEntity(_selectRecruitMember,_selectStation,_start, _end,_remarks);
      em.addEvent(_selectPref,_selectLine,event);
    }
  }

  Widget _recruitMemberPicker() {
    return new GestureDetector(
      onTap: () {
        DataPicker.showDatePicker(
          context,
          showTitleActions: true,
          locale: 'en',
          datas: _numberOfRecruit,
          title: '募集人数',
          onConfirm: (value) {
            if (value != "") {
              setState(() {
                _memberController.text = value;
                _selectRecruitMember = value;
              });
            }
          },
        );
      },
      child: AbsorbPointer(
        child: new TextFormField(
          enableInteractiveSelection: false,
          controller: _memberController,
          decoration: InputDecoration(
            icon: Icon(Icons.people),
            hintText: 'Choose a number of recruiting member',
            labelText: '*募集人数',
          ),
          validator: (String value) {
            return value.isEmpty ? '必須項目です' : null;
          },
        ),
      ),
    );
  }
  Widget _prefPicker() {
    return new GestureDetector(
      onTap: () {
        DataPicker.showDatePicker(
          context,
          showTitleActions: true,
          locale: 'en',
          datas: Pref.pref.keys.toList(),
          title: '都道府県',
          onConfirm: (value) {
            if (value != "") {
              setState(() {
                _prefController.text = value;
                _selectPref = value;
                _prefChange(value);
              });
            }
          },
        );
      },
      child: AbsorbPointer(
        child: new TextFormField(
          enableInteractiveSelection: false,
          validator: (String value) {
            if(value.isEmpty){
              return '必須項目です';
            }else if(changePref != 1){
              return '再選択してください';
            }else{
              return null;
            }
          },
          controller: _prefController,
          decoration: InputDecoration(
            icon: Icon(Icons.place),
            hintText: 'Choose a prefecture',
            labelText: '*都道府県',
          ),
        ),
      ),
    );
  }
  Widget _linePicker() {
    return new GestureDetector(
      onTap: () {
        DataPicker.showDatePicker(
          context,
          showTitleActions: true,
          locale: 'en',
          datas: lineData,
          title: '路線',
          onConfirm: (value) {
            if (value != "") {
              setState(() {
                _lineController.text = value;
                _lineChange(value);
              });
            }
          },
        );
      },
      child: AbsorbPointer(
        child: new TextFormField(
          enableInteractiveSelection: false,
          controller: _lineController,
          decoration: InputDecoration(
            icon: Icon(Icons.train),
            hintText: 'Choose a line',
            labelText: '*路線',
          ),
          validator: (String value) {
            if (value.isEmpty) {
              return '路線が未選択です';
            }else if (changeLine != 1) {
              return '再選択してください';
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }
  Widget _stationPicker() {
    return new GestureDetector(
      onTap: () {
        DataPicker.showDatePicker(
          context,
          showTitleActions: true,
          locale: 'en',
          datas: stationData,
          title: '駅',
          onConfirm: (value) {
            if (value != "") {
              setState(() {
                _stationController.text = value;
                _stationChange(value);
              });
            }
          },
        );
      },
      child: AbsorbPointer(
        child: new TextFormField(
          enableInteractiveSelection: false,
          controller: _stationController,
          decoration: InputDecoration(
            icon: Icon(Icons.subway),
            hintText: 'Choose a station',
            labelText: '*駅',
          ),
          validator: (String value) {
            if (value.isEmpty) {
              return '駅が未選択です';
            }else if (changeStation != 1) {
              return '再選択してください';
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }

  Widget _startTimePicker() {
    return new GestureDetector(
      onTap: () {
        DatePicker.showDateTimePicker(
            context,
            showTitleActions: true,
            theme: DatePickerTheme(
                backgroundColor: Colors.white,
                itemStyle: TextStyle(
                    color: Colors.black),
                doneStyle:
                TextStyle(color: Colors.black)),
            onChanged: (date) {},
            onConfirm: (date) {
              setState(() {
                _start = date;
                _startingController.text = formatter.format(_start);
              });
            },
            currentTime: DateTime.now(),
            locale: LocaleType.en
        );
      },
      child: AbsorbPointer(
        child: new TextFormField(
          enableInteractiveSelection: false,
          controller: _startingController,
          decoration: InputDecoration(
            icon: Icon(Icons.calendar_today ),
            hintText: 'Choose a starting Time',
            labelText: '*開始日時',
          ),
          validator: (String value) {
            return value.isEmpty ? '開始時間が未選択です' : null;
          },
        ),
      ),
    );
  }

  Widget _endTimePicker() {
    return new GestureDetector(
      onTap: () {
        DatePicker.showDateTimePicker(
            context,
            showTitleActions: true,
            theme: DatePickerTheme(
                backgroundColor: Colors.white,
                itemStyle: TextStyle(
                    color: Colors.black),
                doneStyle:
                TextStyle(color: Colors.black)),
            onChanged: (date) {},
            onConfirm: (date) {
              setState(() {
                _end = date;
                _endingController.text = formatter.format(_end);
              });
            },
            currentTime: DateTime.now(),
            locale: LocaleType.en
        );
      },
      child: AbsorbPointer(
        child: new TextFormField(
          enableInteractiveSelection: false,
          controller: _endingController,
          decoration: InputDecoration(
            icon: Icon(Icons.calendar_today),
            hintText: 'Choose a station',
            labelText: '*終了日時',
          ),
          validator: (String value) {
            if(value.isEmpty) return '終了時間が未選択です';
            if(_start != null && _start.isBefore(_end)){
              return null;
            }else{
              return '設定時間が不正です';
            }
          },
        ),
      ),
    );
  }
  Widget _remarksField(){
    return new Container(
        child: new TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.note),
              hintText: 'add remarks',
              labelText: '備考',
            ),
            onSaved: (String value){
              _remarks = value;
            }
        )
    );
  }
}

class SampleTabItem extends StatelessWidget {
  final String title;
  final Color color;

  const SampleTabItem(this.title, this.color) : super();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: this.color,
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(this.title,
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