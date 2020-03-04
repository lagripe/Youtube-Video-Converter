import 'package:flutter/material.dart';
import 'package:youtube_converter/config/classes.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Manager.fetchInfo(link),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFd8153f)),
                ),
              );
            default:
              if (snapshot.hasError) {
                return Container(
                  color: Color(0xFF141414),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.error, color: Colors.white),
                      Text(
                        snapshot.error.toString(),
                        style: TextStyle(
                            fontFamily: "Roboto", color: Colors.white),
                      ),
                    ],
                  )),
                );
              } else {
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      elevation: 15,
                      title: Text(snapshot.data.title,
                          style: TextStyle(fontSize: 18)),
                      expandedHeight: MediaQuery.of(context).size.height / 3,
                      flexibleSpace: FlexibleSpaceBar(
                        titlePadding: EdgeInsets.all(0),
                        background: Stack(
                          children: <Widget>[
                            Image(
                              image: NetworkImage(snapshot.data.image),
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                            Opacity(
                                opacity: 0.3,
                                child: Container(
                                  color: Colors.black,
                                ))
                          ],
                        ),
                      ),
                      pinned: true,
                    ),
                    getHorizontalList(
                        id: snapshot.data.id,
                        v_id: link.split('v=')[1],
                        context: context,
                        title: "VIDEO",
                        icon: Icons.movie,
                        list: snapshot.data.video),
                    getHorizontalList(
                        id: snapshot.data.id,
                        v_id: link.split('v=')[1],
                        context: context,
                        title: "MP3",
                        icon: Icons.audiotrack,
                        list: snapshot.data.mp3),
                    getHorizontalList(
                        id: snapshot.data.id,
                        v_id: link.split('v=')[1],
                        context: context,
                        title: "AUDIO",
                        icon: Icons.audiotrack,
                        list: snapshot.data.audio)
                  ],
                );
              }
          }
        },
      ),
    );
  }

  Widget getHorizontalList(
      {BuildContext context,
      String title,
      IconData icon,
      List<Quality> list,
      String id,
      String v_id}) {
    var snack = SnackBar(
      content: Text("Download started..."),
      backgroundColor: Color(0xFFd8153f),
      duration: Duration(seconds: 1),
      elevation: 10,
    );
    return SliverPadding(
      padding: EdgeInsets.all(10),
      sliver: SliverList(
          delegate: SliverChildListDelegate([
        Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  decoration: TextDecoration.none),
            ),
          ],
        ),
        Container(
          height: 100,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0, top: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 150,
                      color: Colors.white,
                      padding: EdgeInsets.all(8),
                      child: InkWell(
                        hoverColor: Colors.green,
                        onTap: () {
                          Scaffold.of(context).showSnackBar(snack);
                          Manager.downloadVideo(
                                  id: id,
                                  quality: list[index].dataFquality,
                                  type: list[index].dataFtype,
                                  v_id: v_id)
                              .catchError((onError) => print("Error Download"))
                              .then((_) => print("OK"));
                              
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(list[index].quality,
                                style: TextStyle(
                                    fontFamily: "MyriadPro",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18,
                                    decoration: TextDecoration.none)),
                            Text(list[index].size,
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.grey,
                                    fontSize: 14,
                                    decoration: TextDecoration.none)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ])),
    );
  }
}
