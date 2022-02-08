import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_flutter/layout/news_layout/news_cubit.dart';
import 'package:news_flutter/layout/news_layout/news_states.dart';
import 'package:news_flutter/shared/components/constants.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewsCubit newsCubit = NewsCubit.get(context);
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          color: HexColor('081429'),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0),
              ),
              const SizedBox(
                height: 30.0,
              ),
              MaterialButton(
                height: 40.0,
                minWidth: 180.0,
                elevation: 0.0,
                color: Colors.white,
                textColor: Colors.black,
                onPressed: () {
                  newsCubit.getLatestNews(generalCategory);
                  newsCubit.changeDrawerState();
                },
                child: const Text('All'),
              ),
              const SizedBox(
                height: 15.0,
              ),
              MaterialButton(
                height: 40.0,
                minWidth: 180.0,
                elevation: 0.0,
                color: Colors.white,
                textColor: Colors.black,
                onPressed: () {
                  newsCubit.getLatestNews(businessCategory);
                  newsCubit.changeDrawerState();
                },
                child: const Text('Business'),
              ),
              const SizedBox(
                height: 15.0,
              ),
              MaterialButton(
                height: 40.0,
                minWidth: 180.0,
                elevation: 0.0,
                color: Colors.white,
                textColor: Colors.black,
                onPressed: () {
                  newsCubit.getLatestNews(technologyCategory);
                  newsCubit.changeDrawerState();
                },
                child: const Text('Technology'),
              ),
              const SizedBox(
                height: 15.0,
              ),
              MaterialButton(
                height: 40.0,
                minWidth: 180.0,
                elevation: 0.0,
                color: Colors.white,
                textColor: Colors.black,
                onPressed: () {
                  newsCubit.getLatestNews(sportsCategory);
                  newsCubit.changeDrawerState();
                },
                child: const Text('Sports'),
              ),
              const SizedBox(
                height: 15.0,
              ),
              MaterialButton(
                height: 40.0,
                minWidth: 180.0,
                elevation: 0.0,
                color: Colors.white,
                textColor: Colors.black,
                onPressed: () {
                  newsCubit.getLatestNews(scienceCategory);
                  newsCubit.changeDrawerState();
                },
                child: const Text('Science'),
              ),
              const SizedBox(
                height: 15.0,
              ),
              MaterialButton(
                height: 40.0,
                minWidth: 180.0,
                elevation: 0.0,
                color: Colors.white,
                textColor: Colors.black,
                onPressed: () {
                  newsCubit.getLatestNews(healthCategory);
                  newsCubit.changeDrawerState();
                },
                child: const Text('Health'),
              ),
              const SizedBox(
                height: 15.0,
              ),
              MaterialButton(
                height: 40.0,
                minWidth: 180.0,
                elevation: 0.0,
                color: Colors.white,
                textColor: Colors.black,
                onPressed: () {
                  newsCubit.getLatestNews(entertainmentCategory);
                  newsCubit.changeDrawerState();
                },
                child: const Text('Entertainment'),
              ),
              const SizedBox(
                height: 15.0,
              ),
            ],
          ),
        );
      },
    );
  }
}
