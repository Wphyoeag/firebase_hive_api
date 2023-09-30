
import 'package:dio/dio.dart';

import '../model/user_model.dart';

class ApiService {
  static String url = "https://jsonplaceholder.typicode.com/";
  static Dio dio = Dio()..options.baseUrl = url;
  static Future postData(String title, String body) async {
    try {
      var res = await dio.post(
        'posts',
        data: {'title': title, 'body': body},
      );
      return UserModel.fromJson(res.data);
    } 
    on DioException  catch (ex) {
      if(ex.type == DioExceptionType.connectionError){
        throw Exception("Connection Timeout Exception");
      }
      throw Exception(ex.message);
    }
  }

  static Future<List<UserModel>> getAllData() async {
    try {
      var res = await dio.get('posts');
      if (res.statusCode == 200) {
        final userList = res.data as List;
        return userList.map((e) => UserModel.fromJson(e)).toList();
      } else {
        throw Exception();
      }
    } on DioException  catch (e) {
      throw Exception(e.message);
    }
  }

  static Future<List<UserModel>> getUserIdData(int num) async {
    try {
      var res = await dio.get('posts?userId=$num');
      if (res.statusCode == 200) {
        final userList = res.data as List;
        return userList.map((e) => UserModel.fromJson(e)).toList();
      } else {
        throw Exception();
      }
    } on DioException  catch (e) {
      if(e.type == DioExceptionType.connectionError){
        throw Exception("Connection Error Exception");
      } else if(
        e.type==DioExceptionType.connectionTimeout
      ){
        throw Exception("Connection Error Exception");
      } else{

      }
      throw Exception(e.message);
    }
  }
}
