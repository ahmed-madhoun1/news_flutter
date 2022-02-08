import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/app_cubit.dart';
import 'package:news_flutter/layout/news_layout/news_cubit.dart';
import 'package:news_flutter/layout/news_layout/news_states.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final String articleUrl;

  const ArticleDetailsScreen({Key? key, required this.articleUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: state is InternetNotConnected ? SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off,
                color: AppCubit.get(context).isDark ? Colors.white : Colors.black,
                size: 100.0,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text('Need Internet Connection', style: Theme.of(context).textTheme.bodyText1,)
            ],
          ),
        ) : WebView(initialUrl: articleUrl, javascriptMode: JavascriptMode.unrestricted,),
        );
      },
    );
  }

}
