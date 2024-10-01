import 'package:flutter/cupertino.dart';
import 'package:news/repo/headlines_repo.dart';

import '../data_class/top_headlines.dart';

class HeadlinesViewModel
{
  final repo = TopHeadlinesrepo();

  Future <TopHeadlines> fetchheadlines(BuildContext context) async
  {
    final answer= await repo.fetchheadlines(context);
    return answer;
  }
}