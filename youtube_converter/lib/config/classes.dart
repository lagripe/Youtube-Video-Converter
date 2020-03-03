import 'package:flutter/cupertino.dart';

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
  String image,title,id;
  List<Quality> audio,video,mp3;
  Info({@required this.image,@required this.title,@required this.audio,@required this.video,@required this.mp3,@required this.id});
}
class Quality{
  String quality,size,dataFtype,dataFquality;
  Quality({this.quality,this.size,this.dataFquality,this.dataFtype});
}