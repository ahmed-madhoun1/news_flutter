import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/layout/news_layout/news_cubit.dart';
import 'package:news_flutter/layout/news_layout/news_states.dart';
import 'package:news_flutter/shared/components/components.dart';

class LatestNewsScreen extends StatelessWidget {
  const LatestNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List<dynamic> latestNews = NewsCubit.get(context).latestNews;
          return articlesBuilder(context: context, list: latestNews,newsCubit: NewsCubit.get(context), showSaveButton: true);
        });
  }
}
