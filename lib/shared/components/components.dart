import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:news_flutter/layout/news_layout/news_cubit.dart';
import 'package:news_flutter/layout/news_layout/news_states.dart';
import 'package:news_flutter/modules/article_details/article_details_screen.dart';

/// Clean Code Save and delete TO NEWS CUBIT
/// Fix Loading When List Empty
Widget buildNewsItem(
        {required BuildContext context,
        required int index,
        required Map article,
        required NewsCubit newsCubit,
        required bool showSaveButton}) =>
    Card(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      color: Theme.of(context).cardColor,
      elevation: 0.0,
      shadowColor: HexColor('000000'),
      child: InkWell(
        onTap: () {
          // newsCubit.showInterstitialAd();
          navigateTo(context, ArticleDetailsScreen(articleUrl: article['url']));
        },
        child: Row(
          children: [
            CachedNetworkImage(
              width: 120.0,
              errorWidget: (context, url, error) {
                return Center(child: Text('No image for this article', style: Theme.of(context).textTheme.bodyText1,textAlign: TextAlign.center,),);
              },
              height: 130.0,
              imageUrl: article['urlToImage'].toString(),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => Container(
                color: Colors.grey[200],
              ),
              useOldImageOnUrlChange: false,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    article['title'],
                    
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        article['publishedAt'].toString().substring(0, 10),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      showSaveButton
                          ? IconButton(
                              onPressed: () {
                                /// Save The Article To Local Database
                                newsCubit.saveArticle(
                                    context: context, article: article);
                              },
                              icon: Icon(
                                Icons.archive_outlined,
                                color: HexColor('7f8c8d'),
                              ))
                          : IconButton(
                              onPressed: () {
                                /// Delete The Article From Local Database
                                newsCubit.deleteSavedArticle(
                                    context: context, index: index);
                              },
                              icon: Icon(
                                Icons.restore_from_trash,
                                color: HexColor('7f8c8d'),
                              )),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 5.0,
            ),
          ],
        ),
      ),
    );

Widget articlesBuilder({
  required BuildContext context,
  required List list,
  required NewsCubit newsCubit,
  required bool showSaveButton,
}) =>
    list.isNotEmpty
        ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) => buildNewsItem(
                context: context,
                index: index,
                article: list[index],
                newsCubit: newsCubit,
                showSaveButton: showSaveButton),
            itemCount: list.length)
        : Center(
            child: Text(
              'Nothing to show',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          );

/// Custom Field
TextFormField defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  bool isPassword = false,
  required String? Function(String?) validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixPressed,
  Function()? onTap,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      validator: validate,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(suffix),
              )
            : null,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
      ),
      onTap: onTap,
    );

void navigateTo(BuildContext context, Widget widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

Widget splashScreen() => Container(
    color: Colors.white,
    width: double.infinity,
    height: double.infinity,
    child: Image.asset("assets/images/app_icon.png"));

SnackBar internetSnackBar = const SnackBar(
  behavior: SnackBarBehavior.floating,
  margin: EdgeInsets.only(bottom: 70.0, left: 20.0, right: 20.0),
  dismissDirection: DismissDirection.none,
  content: Text("No Internet Connection"),
  duration: Duration(days: 365),
);
