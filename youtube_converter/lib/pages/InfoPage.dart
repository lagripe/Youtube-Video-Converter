import 'package:flutter/material.dart';
import 'package:youtube_converter/config/manager.dart';

class InfoPage extends StatefulWidget {
  String link;
  InfoPage({@required this.link});
  @override
  _InfoPageState createState() => _InfoPageState(link: link);
}

class _InfoPageState extends State<InfoPage> {
  String link;
  _InfoPageState({@required this.link});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        FutureBuilder(
          future: Manager.fetchInfo(link),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SliverAppBar(
                elevation: 8,
                title: Image(image: NetworkImage(snapshot.data)),
                floating: true,
              );
            }else{
              return SliverAppBar();
            }
          },
        )
      ],
    );
  }
}
