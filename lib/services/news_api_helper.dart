import 'dart:convert';

import 'package:bhoomi/services/request_helper.dart';

import 'package:http/http.dart' as http;

class NewsApiHelper {
  String _apiKey = "79efc2fea4bf429089c73248216cfd35";
  String query = "agriculture";

  getNewsArticle() async {
    String url = "https://newsapi.org/v2/everything?q=$query&apiKey=$_apiKey";
    http.Response res = await RequestHelper.getRequest(url);
    return (json.decode(res.body));
  }
  //X-Api-Key: 79efc2fea4bf429089c73248216cfd35
  //Authorization: 79efc2fea4bf429089c73248216cfd35
}
