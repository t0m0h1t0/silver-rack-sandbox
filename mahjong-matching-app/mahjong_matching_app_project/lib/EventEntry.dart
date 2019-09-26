import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventEntry{
  String key;
  int eventId;
  String recruitMember;
  String station;
  DateTime startingTime;
  DateTime endingTime;
  String remarks;
  static String userId ="xxxlancerk@gmail.com";
  EventEntry(this.eventId,this.recruitMember,this.station, this.startingTime, this.endingTime,this.remarks);

//  EventEntry.fromSnapShot(DataSnapshot snapshot):
//        key = userId,
//        recruitMember = snapshot.value["recruitMember"],
//        eventId = snapshot.value["eventId"],
//        station = snapshot.value["station"],
//        startingTime = new DateTime.fromMillisecondsSinceEpoch(snapshot.value["startingTime"]),
//        endingTime = new DateTime.fromMillisecondsSinceEpoch(snapshot.value["endingTime"]),
//        remarks = snapshot.value["remarks"];

  EventEntry.fromMap(Map map):
      key = userId,
      eventId = map["eventId"],
      recruitMember = map["recruitMember"],
      station = map["station"],
      startingTime = new DateTime.fromMillisecondsSinceEpoch(map["startingTime"]),
      endingTime = new DateTime.fromMillisecondsSinceEpoch(map["endingTime"]),
      remarks = map["remarks"];

  toJson() {
    print(
    "\n-----------send Data-----------\n"
    "eventId:$eventId\n"
    "member:$recruitMember\n"
    "station:$station\n"
    "start:$startingTime\n"
    "end:$endingTime\n"
    "remarks:$remarks\n"
    "-------------------------------\n"
    );
    return {
        "eventId":eventId,
        "userId":userId,
        "recruitMember":recruitMember,
        "station":station,
        "startingTime":startingTime.millisecondsSinceEpoch,
        "endingTime":endingTime.millisecondsSinceEpoch,
        "remarks": remarks,
    };
  }
}

class EventDetailPage extends StatelessWidget {
  EventEntry event;

  EventDetailPage(this.event);
  var formatter = new DateFormat(
      'yyyy年 M月d日(E) HH時mm分');

  Widget build(BuildContext context) {
    return Container(
      child:Center(
        child: Column(children: <Widget>[
          Material(
              child: Text("イベントID:" + event.eventId.toString() + "\n"
                  "最寄駅:"+event.station+"\n"
                  "募集人数:" + event.recruitMember + "\n"
                  "開始時刻:" + formatter.format(event.startingTime) + "\n"
                  "終了時刻:" + formatter.format(event.endingTime) + "\n"
                  "備考:" + event.remarks + "\n",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.black,
                    fontSize: 20,
                  )
              )
          ),
          Text("eventId:"+event.eventId.toString()+"\n"
              "station:"+event.station+"\n"
              "member:"+event.recruitMember+"\n"
              "start:"+formatter.format(event.startingTime)+"\n"
              "end:"+formatter.format(event.endingTime)+"\n"
              "remarks:"+event.remarks+"\n",
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.black,
              fontSize:0,
            ),
          ),
          RaisedButton(
            onPressed:(){
              Navigator.pop(context);
            },
            child: Text('戻る'),
          ),
        ]),
      ),
    );
  }
}
