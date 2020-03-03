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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Manager.fetchInfo(link),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                elevation: 15,
                title:
                    Text(snapshot.data.title, style: TextStyle(fontSize: 18)),
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
              getHorizontalList(title: "VIDEO",icon:Icons.movie,list: snapshot.data.video),
              getHorizontalList(title: "MP3",icon:Icons.audiotrack,list: snapshot.data.mp3),
              getHorizontalList(title: "AUDIO",icon:Icons.audiotrack,list: snapshot.data.audio)
            ],
          );
        } else if (snapshot.hasError) {
          return Scaffold(
              body: Center(
            child: Text("Unknown Error!"),
          ));
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFd8153f)),
              ),
            ),
          );
        }
      },
    );
  }

  Widget getHorizontalList({String title,IconData icon,List<Quality> list}){
    return SliverPadding(
                padding: EdgeInsets.all(10),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                  Row(children: <Widget>[
                    Icon(icon,color: Colors.white,),
                    SizedBox(width:5),
                    Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        decoration: TextDecoration.none),
                  ),
                  ],),
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
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(list[index].quality,
                                        style: TextStyle(
                                            fontFamily: "Open-Sans",
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
                          );
                        }),
                  ),
                ])),
              );
  }
}
