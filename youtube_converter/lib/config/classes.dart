import 'package:flutter/cupertino.dart';
import 'package:youtube_converter/pages/InfoPage.dart';

class AjaxResponse {
  String status, result;
  AjaxResponse({@required this.status, @required this.result});

  factory AjaxResponse.fromJson(Map<String, dynamic> json) {
    return AjaxResponse(
      status: json['status'],
      result: json['result']
    );
  }
}
class Info{
  String image,title;
  List<Quality> audio,video,mp3;
  Info({@required this.image,@required this.title,@required this.audio,@required this.video,@required this.mp3});
}
class Quality{
  String quality,size;
  Quality({this.quality,this.size});
}