import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget buildNewsItem(BuildContext context, Map article) => Card(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      color: Theme.of(context).cardColor,
      elevation: 10.0,
      shadowColor: HexColor('000000'),
      child: Row(
        children: [
          CachedNetworkImage(
            width: 120.0,
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
                      article['publishedAt'],
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    IconButton(
                        onPressed: () {
                          ///Save The Article To Local Database
                        },
                        icon: Icon(
                          Icons.archive_outlined,
                          color: HexColor('7f8c8d'),
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );

Widget articlesBuilder({required List list}) => list.isNotEmpty
    ? ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => buildNewsItem(context, list[index]),
        itemCount: list.length)
    : const Center(child: CircularProgressIndicator());
