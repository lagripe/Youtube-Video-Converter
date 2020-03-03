import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youtube_converter/config/classes.dart';
import 'dart:io';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'package:dio/dio.dart';

class Manager {
  static Future<Info> fetchInfo(String link) async {
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
    try {
      var response = await http.post(
          "https://mate07.y2mate.com/en6/analyze/ajax",
          headers: headers,
          body: payload);
      var _data = AjaxResponse.fromJson(json.decode(response.body));
      Document doc = parser.parse(_data.result);
      RegExp r = RegExp(r"https://i.ytimg.com/vi/.*?\.jpg");
      String title = doc.getElementsByClassName("caption text-left")[0].text;
      String image = r.firstMatch(_data.result).group(0);
      // ---------- token --------------
      r = RegExp(r"_id: '(\w+)'");
      String id = r.firstMatch(_data.result).group(0);
      //---------------------------
      List<Quality> video = List<Quality>();
      List<Quality> mp3 = List<Quality>();
      List<Quality> audio = List<Quality>();
      // ------------ Video --------------
      doc
          .getElementById("mp4")
          .getElementsByTagName("tbody")[0]
          .getElementsByTagName("tr")
          .forEach((tr) {
        if (tr.getElementsByTagName("td").length == 3) {
          video.add(Quality(
            quality: tr
                .getElementsByTagName("td")[0]
                .getElementsByTagName("a")[0]
                .text
                .trim(),
            size: tr.getElementsByTagName("td")[1].text,
            dataFquality: tr
                .getElementsByTagName("td")[2]
                .getElementsByTagName("a")[0]
                .attributes['data-fquality'],
            dataFtype: tr
                .getElementsByTagName("td")[2]
                .getElementsByTagName("a")[0]
                .attributes['data-ftype'],
          ));
        }
      });

      //---------- MP3 -----------------
      doc
          .getElementById("mp3")
          .getElementsByTagName("tbody")[0]
          .getElementsByTagName("tr")
          .forEach((tr) {
        if (tr.getElementsByTagName("td").length == 3) {
          mp3.add(Quality(
            quality: tr
                .getElementsByTagName("td")[0]
                .getElementsByTagName("a")[0]
                .text
                .trim(),
            size: tr.getElementsByTagName("td")[1].text,
            dataFquality: tr
                .getElementsByTagName("td")[2]
                .getElementsByTagName("a")[0]
                .attributes['data-fquality'],
            dataFtype: tr
                .getElementsByTagName("td")[2]
                .getElementsByTagName("a")[0]
                .attributes['data-ftype'],
          ));
        }
      });
      //---------- AUDIO -----------------
      doc
          .getElementById("audio")
          .getElementsByTagName("tbody")[0]
          .getElementsByTagName("tr")
          .forEach((tr) {
        if (tr.getElementsByTagName("td").length == 3)
          audio.add(
            Quality(
              quality: tr
                  .getElementsByTagName("td")[0]
                  .getElementsByTagName("a")[0]
                  .text
                  .trim(),
              size: tr.getElementsByTagName("td")[1].text,
              dataFquality: tr
                  .getElementsByTagName("td")[2]
                  .getElementsByTagName("a")[0]
                  .attributes['data-fquality'],
              dataFtype: tr
                  .getElementsByTagName("td")[2]
                  .getElementsByTagName("a")[0]
                  .attributes['data-ftype'],
            ),
          );
      });
      
      
      return Info(
          image: image, title: title, audio: audio, mp3: mp3, video: video,id: "");
    } on SocketException {
      return Future.error("Can't connect to the server!");
    } catch (Exception) {
      return Future.error("Unknown error!");
    }

    //return _data;
  }

  void downloadVideo(String type, String quality, String id) {
    Map<String, String> headers = {
      "accept": "*/*",
      "accept-encoding": "utf-8",
      //"accept-language:": "en-US,en;q=0.9",
      "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
      "origin": "https://www.y2mate.com",
      "referer": "https://www.y2mate.com/youtube/$id",
      "sec-fetch-dest": "empty",
      "sec-fetch-mode": "cors",
      "sec-fetch-site": "same-site",
      "user-agent":
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.122 Safari/537.36",
    };
    Map<String, String> payload = {
      "type":"youtube",
      "_id":"5e1b3115d684eb2b358b458c",
      "v_id":"",
      "ajax":"1",
      "ftype":"",
      "fquality":"",
    };
  }
}
