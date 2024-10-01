

import 'package:flutter/material.dart';
import 'package:news/data_class/top_headlines.dart';


import '../pages/detail_news.dart';


class NewsListTile extends StatefulWidget {
  NewsListTile(this.data, {Key? key}) : super(key: key);
  Articles data;
  @override
  State<NewsListTile> createState() => _NewsListTileState();
}

class _NewsListTileState extends State<NewsListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(widget.data),
            ));
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 20.0),
        padding: EdgeInsets.all(12.0),
        height: 130,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(26.0),
        ),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: Hero(
                tag: "${widget.data.title}",
                child: Container(
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(
                          widget.data.urlToImage==null ? "https://previews.123rf.com/images/enterline/enterline1610/enterline161000243/63421889-the-word-news-written-in-watercolor-washes-over-a-white-paper-background-concept-and-theme.jpg"
                              : widget.data.urlToImage.toString()
                      ),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Flexible(
                flex: 5,
                child: Column(
                  children: [
                    Text(
                      widget.data.title.toString(),
                      maxLines: 3,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(widget.data.content.toString(),

                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white54,
                        ))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}