import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/constant.dart';
import '../data/models/api_model.dart';
import '../utils/utils.dart';

class DetailPage extends StatelessWidget {
  late final Articles article;

  DetailPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.bgColor,
      body: Stack(
        children: [
          Hero(
            tag: article.urlToImage,
            child: CachedNetworkImage(
              imageUrl: article.urlToImage,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child:
                    CircularProgressIndicator(value: downloadProgress.progress),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error, size: 50),
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  ColorConstant.blackColor,
                  ColorConstant.transparentColor,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      color: ColorConstant.textMainColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 29,
                    ),
                    textScaleFactor: 1.0,
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 64),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          article.source.name,
                          style: const TextStyle(
                            color: ColorConstant.textMainColor,
                            fontSize: 20,
                          ),
                          textScaleFactor: 1.0,
                        ),
                      ),
                      Text(
                        formatDate(article.publishedAt,
                            DateFormats.yyyyMMddTHHmmssZ, DateFormats.yyyyMMdd),
                        style: const TextStyle(
                          color: ColorConstant.textMainColor,
                          fontSize: 20,
                        ),
                        textScaleFactor: 1.0,
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    article.content,
                    style: const TextStyle(
                      color: ColorConstant.textSecondaryColor,
                      fontSize: 14,
                    ),
                    textScaleFactor: 1.0,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 10.0, top: 10 + MediaQuery.of(context).padding.top),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Container(
                width: 42,
                height: 42,
                color: ColorConstant.blackGradientColor,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: ColorConstant.whiteColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
