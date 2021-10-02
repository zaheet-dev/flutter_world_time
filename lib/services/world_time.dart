import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location from ui
  String time; //time in location
  String flag; //flag url
  String url;
  bool isDaytime; //image flag

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {

    try{
      var apiurl = Uri.parse('https://worldtimeapi.org/api/timezone/$url');
      http.Response response = await http.get(apiurl);
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      //create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      print(now.hour);
      print(now.hour > 5 && now.hour < 20 ? true : false);
      isDaytime = now.hour > 5 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e) {
      print('error caught: $e');
      time = 'couldnt get the data';
    }
  }
}

