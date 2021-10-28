import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/app_cubit.dart';
import 'package:news_flutter/layout/news_layout/news_cubit.dart';
import 'package:news_flutter/layout/news_layout/news_states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getLatestNews(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsCubit cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.bnbItems[cubit.bnbCurrentIndex].label.toString()),
              actions: [
                IconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  icon: const Icon(Icons.search),
                  onPressed: () {

                  },
                ),
                IconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  icon: const Icon(Icons.brightness_4),
                  onPressed: () {
                    AppCubit.get(context).changeAppMode();
                  },
                ),
              ],
            ),
            body: cubit.screens[cubit.bnbCurrentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bnbItems,
              currentIndex: cubit.bnbCurrentIndex,
              onTap: (index) {
                cubit.changeBnbItem(index);
              },
            ),
          );
        },
      ),
    );
  }
}
