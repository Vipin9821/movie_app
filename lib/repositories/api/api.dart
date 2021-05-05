import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/model.dart';

class Api {
  static const apiKey = '<your api key>';
  Future<List<MovieModel>> getApiData() async {
    const String uri =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey&language=en-US&page=1';

    var url = Uri.parse(uri);
    List<MovieModel> dataList = [];
    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);

      for (int i = 0; i < 15; i++) {
        dataList.add(MovieModel.fromJson(json['results'][i]));
        // print('index' +
        //     dataList
        //         .indexWhere((element) =>
        //             element.backdropPath == '/w2uGvCpMtvRqZg6waC1hvLyZoJa.jpg')
        //         .toString());
        // print(dataList[5]);
      }
    } catch (e) {
      throw e;
    }
    // print(dataList[0].originalTitle);
    return dataList;
  }

  Future<MovieModel> getSpecificMovieDetails(String id) async {
    var uri =
        'https://api.themoviedb.org/3/movie/$id?api_key=$apiKey&language=en-US';

    var url = Uri.parse(uri);
    MovieModel dataList;
    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      print(response.body);
      dataList = MovieModel.fromJson(json);
      print(dataList);
    } catch (e) {
      throw e;
    }
    return dataList;
  }

  Future<String> getVideoLink(String id) async {
    var uri =
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=$apiKey&language=en-US';
    var url = Uri.parse(uri);
    String data;
    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      print(response.body);
      data = json['results'][0]['key'];
      print(data);
    } catch (e) {
      throw e;
    }
    return data;
  }
}
