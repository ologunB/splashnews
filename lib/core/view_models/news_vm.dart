import 'package:foxfund_alpha/core/api/news_api.dart';
import 'package:foxfund_alpha/core/model/all_articles.dart';
import 'package:foxfund_alpha/utils/auth_exception.dart';

import '../../locator.dart';
import 'base_vm.dart';

class NewsViewModel extends BaseModel {
  final NewsApi _newsApi = locator<NewsApi>();
  String error1;
  String error2;
  String error3;
  List<Article> categoriesArticles;
  List<Article> trendingArticles;
  List<Article> searchedArticles =<Article>[];

  int categoryPage = 0;

  //get news by category
  Future<bool> getByCategory(String category) async {
    setBusy(true);
    categoryPage++;

    try {
      categoriesArticles = await _newsApi.getByCategory(category, categoryPage);

      setBusy(false);
      notifyListeners();
      return true;
    } on CustomException catch (e) {
      error1 = e.message;
      setBusy(false);
      notifyListeners();
      return false;
    }
  }

  //get all news
  Future<bool> getAll() async {
    setBusy(true);
    try {
      trendingArticles = await _newsApi.getAll();
      setBusy(false);
      notifyListeners();
      return true;
    } on CustomException catch (e) {
      error2 = e.message;
      setBusy(false);
      notifyListeners();
      return false;
    }
  }


  //search for news
  Future<bool> search(String a) async {
    setBusy(true);
    try {
      searchedArticles = await _newsApi.searchAll(a);
      setBusy(false);
      notifyListeners();
      return true;
    } on CustomException catch (e) {
      error3 = e.message;
      setBusy(false);
      notifyListeners();
      return false;
    }
  }
}
