import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../bloc/article_bloc/article_bloc_exporter.dart';
import '../constants/constant.dart';
import '../data/models/api_model.dart';
import '../utils/utils.dart';
import 'view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ArticleBloc articleBloc;

  @override
  void initState() {
    super.initState();
    articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.add(FetchArticleEvent());
  }

  @override
  Widget build(BuildContext context) {
    _onRefresh() {
      return Future.delayed(Duration(milliseconds: 100), () {
        articleBloc.add(FetchArticleEvent());
      });
    }

    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.blackColor,
          title: const Center(
            child: Text(
              Strings.headlines,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: ColorConstant.whiteColor,
                fontSize: 29,
                letterSpacing: 5,
              ),
              textScaleFactor: 1,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: BlocListener<ArticleBloc, ArticleState>(
            listener: (context, state) {},
            child: BlocBuilder<ArticleBloc, ArticleState>(
              builder: (context, state) {
                if (state is ArticleLoadedState) {
                  return buildArticleList(state.articles);
                } else if (state is ArticleErrorState) {
                  return buildErrorUi(state.message);
                } else {
                  return buildLoading();
                }
              },
            ),
          ),
        ),
      );
    });
  }

  Widget buildLoading() {
    return const Center(
      child: SpinKitDoubleBounce(
        color: Colors.redAccent,
        size: 100,
      ),
    );
  }

  Widget buildErrorUi(String message) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                  textScaleFactor: 1,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildArticleList(List<Articles> articles) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: articles.length,
      itemBuilder: (ctx, index) {
        return InkWell(
          onTap: () {
            navigateToDetailPage(context, articles[index]);
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 20,
            clipBehavior: Clip.hardEdge,
            color: ColorConstant.bgColor,
            margin: EdgeInsets.zero,
            child: SizedBox(
              height: 250,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Hero(
                    tag: articles[index].urlToImage,
                    child: CachedNetworkImage(
                      imageUrl: articles[index].urlToImage,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error, size: 50),
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
                    )),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            articles[index].title,
                            style: const TextStyle(
                              fontSize: 20,
                              color: ColorConstant.textMainColor,
                            ),
                            textScaleFactor: 1,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Text(
                                articles[index].source.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: ColorConstant.textSecondaryColor,
                                ),
                                textScaleFactor: 1,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                formatDate(
                                    articles[index].publishedAt,
                                    DateFormats.yyyyMMddTHHmmssZ,
                                    DateFormats.yyyyMMdd),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: ColorConstant.textSecondaryColor,
                                ),
                                textScaleFactor: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 24,
      ),
    );
  }

  void navigateToDetailPage(BuildContext context, Articles article) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DetailPage(article: article);
    }));
  }
}
