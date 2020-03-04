import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

class DownloadedFilesPage extends StatefulWidget {
  @override
  _DownloadedFilesPageState createState() => _DownloadedFilesPageState();
}

class _DownloadedFilesPageState extends State<DownloadedFilesPage> {
  Future _listofFiles() async {
    var directory = (await getExternalStorageDirectory()).path;
    return io.Directory("$directory/").listSync();
    //io.Directory("$directory/").listSync()[0].;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Downloads"),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: _listofFiles(),
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                  return Card(
                    child: Text(snapshot.data[index].toString()),
                  );
                });
            }));
  }
}
