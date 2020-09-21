import 'package:flutter_world_time/data/models/world_time.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

abstract class WorldTimeApi {
  /// Throws [NetworkException].
  Future<WorldTime> getTime(WorldTime worldTime);
}

class WorldTimeRepository implements WorldTimeApi {
  @override
  Future<WorldTime> getTime(WorldTime worldTime) async {
    try {
      http.Response response = await http
          .get("http://worldtimeapi.org/api/timezone/${worldTime.url}");
      Map data = jsonDecode(response.body);

      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      worldTime.isDayTime = now.hour > 6 && now.hour < 20;
      worldTime.time = DateFormat.jm().format(now);
      // time = now.toString();
      return worldTime;
      // return Future.delayed(Duration(seconds: 2), () => worldTime);
    } catch (e) {
      throw NetworkException();
    }
  }
}

class NetworkException implements Exception {}
