import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youtube_converter/config/classes.dart';
import 'dart:io';
class Manager {
  static Future<String> fetchInfo(String link) async {
    Map<String, String> headers = {
      "accept": "*/*",
      "accept-encoding": "utf-8",
      //"accept-language:": "en-US,en;q=0.9",
      "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
      "origin": "https://www.y2mate.com",
      "referer": "https://www.y2mate.com/en6",
      "sec-fetch-dest": "empty",
      "sec-fetch-mode": "cors",
      "sec-fetch-site": "same-site",
      "user-agent":
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.122 Safari/537.36",
    };
    Map<String, String> payload = {"url": link, "ajax": "1"};
    var response =
        await http.post("https://mate07.y2mate.com/en6/analyze/ajax",headers: headers,body: payload);
        print(response.body);
    var _data = AjaxResponse.fromJson(json.decode(response.body));
    RegExp r = RegExp(r"https://i.ytimg.com/vi/.*?\.jpg");
      
    return r.firstMatch(_data.result).group(0);
    //return _data;
  }
}
