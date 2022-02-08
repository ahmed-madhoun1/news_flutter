import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/main/app_cubit.dart';
import 'package:news_flutter/layout/news_layout/news_cubit.dart';
import 'package:news_flutter/layout/news_layout/news_states.dart';
import 'package:news_flutter/shared/components/components.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        if (NewsCubit.get(context).isInternetConnected) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(internetSnackBar);
        }
      },
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return GestureDetector(
          onHorizontalDragStart: (context) => cubit.changeDrawerState(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: cubit.changeScreenScale(),
            child: ClipRRect(
              borderRadius: cubit.changeScreenBorderRadius(),
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    icon: const Icon(Icons.list_rounded),
                    onPressed: () {
                      cubit.changeDrawerState();
                    },
                  ),
                  title: Text(
                      cubit.bnbItems[cubit.bnbCurrentIndex].label.toString()),
                  actions: [
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
              ),
            ),
          ),
        );
      },
    );
  }
}
