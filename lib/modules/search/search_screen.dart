import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/layout/news_layout/news_cubit.dart';
import 'package:news_flutter/layout/news_layout/news_states.dart';
import 'package:news_flutter/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit newsCubit = NewsCubit.get(context);
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: defaultFormField(
                controller: searchController,
                type: TextInputType.text,
                onChange: (String value) {
                  newsCubit.getSearchedNews(searchValue: value);
                },
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'Search must not be empty';
                  }
                  return null;
                },
                label: 'Search',
                prefix: Icons.search,
              ),
            ),
            Expanded(child: articlesBuilder(context: context, list: newsCubit.searchedNews, newsCubit: newsCubit, showSaveButton: true)),
          ],
        );
      },
    );
  }
}
