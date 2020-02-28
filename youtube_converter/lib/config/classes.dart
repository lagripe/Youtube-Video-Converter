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
