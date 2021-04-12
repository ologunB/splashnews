import 'dart:async';

import 'package:dio/dio.dart';
import 'package:foxfund_alpha/core/model/all_articles.dart';
import 'package:foxfund_alpha/core/model/error_model.dart';
import 'package:foxfund_alpha/utils/auth_exception.dart';
import 'package:foxfund_alpha/utils/constants/messages.dart';
import 'package:foxfund_alpha/utils/error_util.dart';
import 'package:logger/logger.dart';

import 'base_api.dart';

class NewsApi extends BaseAPI {
  Logger log = Logger();
  String country = 'ng';
  String apiKey = '3f45181d850e46438fb91f17c0c0c466';

  //get news by category
  Future<List<Article>> getByCategory(String category, int categoryPage) async {
    final String url =
        '$baseUrl/everything?apiKey=$apiKey&q=$category&page=$categoryPage';
    try {
      final Response<Map<String, dynamic>> res =
          await dio.get<Map<String, dynamic>>(url, options: options);

      switch (res.statusCode) {
        case SERVER_OKAY:
          try {
            return AllArticles.fromJson(res.data).articles;
          } catch (e) {
            throw PARSING_ERROR;
          }
          break;
        default:
          throw ErrorModel.fromJson(res.data).error.message;
      }
    } catch (e) {
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  //get all news
  Future<List<Article>> getAll() async {
    final String url = '$baseUrl/top-headlines?country=$country&apiKey=$apiKey';
    try {
      final Response<Map<String, dynamic>> res =
          await dio.get<Map<String, dynamic>>(url, options: options);

      switch (res.statusCode) {
        case SERVER_OKAY:
          try {
            return AllArticles.fromJson(res.data).articles;
          } catch (e) {
            throw PARSING_ERROR;
          }
          break;
        default:
          throw ErrorModel.fromJson(res.data).error.message;
      }
    } catch (e) {
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  //search all news
  Future<List<Article>> searchAll(String q) async {
    final String url = '$baseUrl/everything?apiKey=$apiKey&q=$q';
    try {
      final Response<Map<String, dynamic>> res =
          await dio.get<Map<String, dynamic>>(url, options: options);

      switch (res.statusCode) {
        case SERVER_OKAY:
          try {
            return AllArticles.fromJson(res.data).articles;
          } catch (e) {
            throw PARSING_ERROR;
          }
          break;
        default:
          throw ErrorModel.fromJson(res.data).error.message;
      }
    } catch (e) {
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }
}
