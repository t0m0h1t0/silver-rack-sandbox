import 'dart:convert';
import 'package:http/http.dart' as http;

class Pref{
  int prefCode;
  String prefName;
  static Map<String, String> pref = {
    "北海道": "1",
    "青森県": "2",
    "岩手県": "3",
    "宮城県": "4",
    "秋田県": "5",
    "山形県": "6",
    "福島県": "7",
    "茨城県": "8",
    "栃木県": "9",
     "群馬県":"10",
     "埼玉県":"11",
     "千葉県":"12",
     "東京都":"13",
     "神奈川県":"14",
     "新潟県":"15",
     "富山県":"16",
     "石川県":"17",
     "福井県":"18",
     "山梨県":"19",
     "長野県":"20",
     "岐阜県":"21",
     "静岡県":"22",
     "愛知県":"23",
     "三重県":"24",
     "滋賀県":"25",
     "京都府":"26",
     "大阪府":"27",
     "兵庫県":"28",
     "奈良県":"29",
     "和歌山県":"30",
     "鳥取県":"31",
     "島根県":"32",
     "岡山県":"33",
     "広島県":"34",
     "山口県":"35",
     "徳島県":"36",
     "香川県":"37",
     "愛媛県":"38",
     "高知県":"39",
     "福岡県":"40",
     "佐賀県":"41",
     "長崎県":"42",
     "熊本県":"43",
     "大分県":"44",
     "宮崎県":"45",
     "鹿児島県":"46",
     "沖縄県":"47"
  };
  Map<String,int> lineMap = new Map();
  Pref(this.prefCode, this.prefName);
  void requestLineData(int index) async {
    var url = 'http://www.ekidata.jp/api/p/' + index.toString() + '.json';
    http.get(url).then((response) {
      var body = response.body.substring(50, response.body.length - 58);
      var mapLine = jsonDecode(body);
        mapLine["line"].forEach((i) {
          lineMap[ i["line_name"] ] = i["line_cd"];
        });
      });
      print(lineMap.length);
  }
}

class Line{
  int lineCode;
  String lineName;
  Station station;
  static Map<String,int> stationMap;
  Line();
//  Line(this.lineCode, this.lineName);
//
//  factory Line.fromJson(Map<String, dynamic> json){
//    return Line(
//      lineCode: json['line_cd'] as int,
//      lineName: json['line_name'] as String
//    );
//  }
  Map<String, dynamic> toJson() =>
      {
        'line_name':lineName,
        'line_cd': lineCode
      };

  Map<String,int> requestStationData(int index) {
    var url = 'http://www.ekidata.jp/api/l/' + index.toString() + '.json';
    http.get(url).then((response) {
      var body = response.body.substring(50, response.body.length - 58);
      var mapLine = jsonDecode(body);
      //map.map((i) => lineList.add(Line.fromJson(i)));
      mapLine["station"].forEach((i) {
        stationMap[i["station_name"]] = i["station_cd"];
      });
    });
    return stationMap;
  }
}
class Station {
  int stationCode;
  String stationName;
  Station({this.stationCode, this.stationName});

  factory Station.fromJson(Map<String, dynamic> json){
    return Station(
      stationCode: json['station_cd'] as int,
      stationName: json['station_name'] as String
    );
  }
  Map<String, dynamic> toJson() =>
      {
        'station_name': stationName,
        'station_cd': stationCode
      };
}

