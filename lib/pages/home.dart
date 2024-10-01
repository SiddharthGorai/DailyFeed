import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart' as mycorouselslider;
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news/data_class/top_headlines.dart';
import 'package:news/pages/category_news.dart';
import 'package:news/view_models/headlines_view_model.dart';

import '../components/headlines_card.dart';
import '../components/recent_news.dart';
import 'detail_news.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HeadlinesViewModel headlinesvm =HeadlinesViewModel();
  bool a=false;
  bool isConnected = false;
  TopHeadlines? data = null;
  List<Articles> favData = [];
  Map favIds = {};
  final ref = FirebaseDatabase.instance.ref("fav");
  final auth = FirebaseAuth.instance;


  void getData() async {
    data = await headlinesvm.fetchheadlines(context);
    String? userId = auth.currentUser?.uid;
    final snapshot = await ref.child(userId!).get();
    if (snapshot.exists) {
      favIds = snapshot.value as Map;
    }
    if(data!=null){
      // final x = data!.articles![0].source!.id;
      for(var d in data!.articles!){
        final id = d.source!.id;
        if(id==null) continue;
        print(id);
        if(favIds[id.toString()]!=null){
          favData.add(d);
        }
      }
    }

    setState(() {
      isConnected = true;
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    final width= MediaQuery.sizeOf(context).width * 1;
    final height= MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Top News', style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),)),
        actions: <Widget>[
          IconButton(
            icon: Container(
              margin: EdgeInsets.only(right: 30),
              child: Icon(
                Icons.logout
              ),
            ),
            onPressed: () {
              logout();
            },
          )
        ],
        leading: IconButton(
          onPressed: (){
            // Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesNews()));

            setState(() {
              a=(!a);
            });
          },
          //isSelected: a=true,
          icon: a ? Icon(Icons.list) : Icon(Icons.grid_view_rounded) ,
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            //height: height,
            width: width,
            child : isConnected
                ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Favourites",
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //let's build our caroussel
                    favData.length==0
                    ? Center(child: Text("No Favourites yet!"),)
                    : mycorouselslider.CarouselSlider.builder(
                        itemCount: favData.length,
                        itemBuilder: (context, index, id) =>
                            BreakingNewsCard(favData![index]),
                        options: mycorouselslider.CarouselOptions(
                          aspectRatio: 16 / 9,
                          enableInfiniteScroll: false,
                          enlargeCenterPage: true,
                        )),
                    SizedBox(
                      height: 40.0,
                    ),
                    Text(
                      "Recent News",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    //now let's create the cards for the recent news
                    a ?
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                        mainAxisExtent: 310,
                      ),
                      itemCount: data!.articles!.length,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: (){Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(data!.articles![index]),
                              ));},
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                16.0,
                              ),
                              color: Colors.black,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16.0),
                                    topRight: Radius.circular(16.0),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: data!.articles?[index].urlToImage==null ? "https://previews.123rf.com/images/enterline/enterline1610/enterline161000243/63421889-the-word-news-written-in-watercolor-washes-over-a-white-paper-background-concept-and-theme.jpg"
                                        : data!.articles![index].urlToImage.toString(),
                                    height: 155,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${data!.articles![index].title.toString()}",
                                        style: Theme.of(context).textTheme.titleMedium!.merge(
                                          const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                        maxLines: 3,
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        "${data!.articles![index].author}",

                                        style: Theme.of(context).textTheme.titleSmall!.merge(
                                          TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                        maxLines: 1,
                                      ),
                                      // const SizedBox(
                                      //   height: 8.0,
                                      // ),
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.end,
                                      //   children: [
                                      //     IconButton(
                                      //       onPressed: () {},
                                      //       icon: Icon(
                                      //         CupertinoIcons.heart,
                                      //       ),
                                      //     ),
                                      //
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                        : Column(
                      children: data!.articles!
                          .map((e) => NewsListTile(e))
                          .toList(),
                    ) ,
                  ],
                ),
              ),
            )
                : Center(
              child: SpinKitFadingCircle(
                  size: 50,
                  color : Colors.blue
              ) ,
            ),
          )
        ],
      ),
    );
  }

  void logout() {
    auth.signOut();
    displaySnackBar('Logged out successfully!');
    Navigator.pushReplacementNamed(context, '/sign_in');
  }

  void displaySnackBar(String s) {
    var snackdemo = SnackBar(
      content: Text(s),
      backgroundColor: Colors.green,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackdemo);
  }
}