import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/article_bloc/article_bloc_exporter.dart';
import 'constants/constant.dart';
import 'data/repositories/article_repo.dart';
import 'views/view.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorConstant.bgColor,
        primarySwatch:
            ColorConstant.createMaterialColor(ColorConstant.blackColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto_Slab',
      ),
      home: BlocProvider(
        create: (BuildContext context) =>
            ArticleBloc(repository: ArticleRepositoryImpl()),
        child: HomePage(),
      ),
    );
  }
}
