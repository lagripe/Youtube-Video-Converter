import 'package:flutter/material.dart';
import 'dart:core';

import 'package:youtube_converter/pages/InfoPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller;
  String errorText = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        excludeFromSemantics: true,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          _controller.text = "";
          errorText = "";
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: Image(
                        image: AssetImage("assets/img/Logo.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: SizedBox(
                        height: 70,
                        width: MediaQuery.of(context).size.width -
                            (MediaQuery.of(context).size.width * 0.3),
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              gapPadding: 20.0,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              gapPadding: 20.0,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.search,
                              size: 30,
                              color: Colors.black,
                            ),
                            hintText:
                                "https://www.youtube.com/watch?v=HhjHYkPQ8F0",
                            hintStyle: TextStyle(color: Colors.grey),
                            focusColor: Colors.black,
                            errorText: errorText,
                            errorStyle: TextStyle(color: Color(0xFFd8153f)),
                          ),
                          cursorColor: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: SizedBox(
            width: 100,
            height: 100,
            child: FloatingActionButton(
              onPressed: () {
                _controller.text = "https://www.youtube.com/watch?v=VKbNq8t297A";
                RegExp regex = RegExp(
                    r"^https://www.youtube.com/watch\?v=[a-zA-Z0-9][a-zA-Z0-9\-_]+[a-zA-Z0-9]$",
                    caseSensitive: true,
                    multiLine: false);
                if (!regex.hasMatch(_controller.value.text)) {
                  setState(() => errorText = "Enter a valid video link");
                  _controller.text = "";
                } else {
                  setState(() => errorText = "");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => InfoPage(link: _controller.text,)));
                }
              },
              elevation: 8,
              child: Icon(
                Icons.arrow_forward_ios,
                size: 50,
              ),
              hoverElevation: 13,
            ),
          ),
        ));
  }

  
}
