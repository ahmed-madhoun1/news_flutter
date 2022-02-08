import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_flutter/layout/news_layout/news_cubit.dart';
import 'package:news_flutter/layout/news_layout/news_states.dart';
import 'package:news_flutter/models/article.dart';
import 'package:news_flutter/shared/components/components.dart';

class SavedNewsScreen extends StatelessWidget {
  const SavedNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ValueListenableBuilder<Box<Article>>(
              valueListenable: Article.getArticleBox().listenable(),
              builder: (context, box, _) {
                return articlesBuilder(context: context, list: NewsCubit.get(context).savedNews, newsCubit: NewsCubit.get(context), showSaveButton: false);
              });
        });
  }
}
