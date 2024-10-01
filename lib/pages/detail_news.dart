import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data_class/top_headlines.dart';


class DetailsScreen extends StatefulWidget {
  DetailsScreen(this.data, {Key? key}) : super(key: key);
  Articles data;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  bool isFav = false;
  Map favIds = {};
  final ref = FirebaseDatabase.instance.ref("fav");
  final auth = FirebaseAuth.instance;

  void getData() async {
    String? userId = auth.currentUser?.uid;
    final snapshot = await ref.child(userId!).get();
    if (snapshot.exists) {
      favIds = snapshot.value as Map;
    }
    if(widget.data.source?.id==null){
      return;
    }
    if(favIds[widget.data.source!.id.toString()]!=null){
      setState(() {
        isFav = true;
      });

    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.orange.shade900),
        actions: <Widget>[
          IconButton(
            icon: Container(
              margin: EdgeInsets.only(right: 30),
              child: Icon(
                isFav ? CupertinoIcons.heart_fill
                : CupertinoIcons.heart,
                color: Colors.red,
              ),
            ),
            onPressed: () {
              onLikePressed();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.data.title.toString(),
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              widget.data.author.toString(),
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Hero(
              tag: "${widget.data.title}",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.network(
                    widget.data.urlToImage==null ? "https://previews.123rf.com/images/enterline/enterline1610/enterline161000243/63421889-the-word-news-written-in-watercolor-washes-over-a-white-paper-background-concept-and-theme.jpg"
                        : widget.data.urlToImage.toString()
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(widget.data.content.toString()),
            SizedBox(height: 15,),
            // ElevatedButton(onPressed: (){
            //   _launch();
            // }, child:
            // Text("View Full Article"))
          ],
        ),
      ),
    );
  }

  void onLikePressed() {
    String? userId = auth.currentUser?.uid;
    setState(() {
      isFav = !isFav;
    });
    if(isFav==false){
      //unlike kro
      isFav = false;
      favIds.remove(widget.data.source!.id!);
      ref.set({
        userId : favIds
      });
    } else {
      //like kro
      isFav = true;
      print(favIds);
      favIds[widget.data.source!.id!]="true";
      print(favIds);
      ref.set({
        userId : favIds
      });
    }
  }

  Future<void> _launch() async {
    String? url =widget.data.url;
    if(url==null) return;
    if(await launchUrl(Uri.parse(url))){
      return;
    }
    throw "could not launch!";
  }
}