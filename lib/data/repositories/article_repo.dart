import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/constant.dart';
import '../../utils/utils.dart';
import '../models/api_model.dart';

abstract class ArticleRepository {
  Future<List<Articles>> getArticles();
}

class ArticleRepositoryImpl implements ArticleRepository {
  @override
  Future<List<Articles>> getArticles() async {
    var response = await http.get(Uri.parse(Strings.url));

    switch (response.statusCode) {
      case 200:
        var data = json.decode(response.body);
        List<Articles> articles = ApiResultModel.fromJson(data).articles;
        PrefsUtils.setString(PrefKeys.articles, response.body);
        return articles;
      default:
        throw FetchDataException(
            '${response.statusCode}: ' + Strings.error_general);
    }
  }
}

class AppException implements Exception {
  final _prefix;
  final _message;

  AppException([this._prefix, this._message]);

  String toString() {
    return "$_prefix $_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([message]) : super('', message);
}

class InternetException extends AppException {
  InternetException([String message = Strings.error_network])
      : super('', message);
}
