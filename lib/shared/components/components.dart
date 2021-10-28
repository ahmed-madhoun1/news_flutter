import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildNewsItem(Map article) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Row(
        children: [
          CachedNetworkImage(
            width: 120.0,
            height: 120.0,
            imageUrl: article['urlToImage'].toString(),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Container(color: Colors.grey[200],),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article['title'],
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16.0),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      article['publishedAt'],
                      style:
                          const TextStyle(color: Colors.grey, fontSize: 12.0),
                    ),
                    IconButton(
                        onPressed: () {
                          ///Save The Article To Local Database
                        },
                        icon: const Icon(
                          Icons.archive_outlined,
                          color: Colors.grey,
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
        itemBuilder: (context, index) => buildNewsItem(list[index]),
        itemCount: list.length)
    : const Center(child: CircularProgressIndicator());
