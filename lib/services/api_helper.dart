
import 'dart:convert';


import 'package:firebase_auth_log_in/services/dio_instance.dart';

import '../model/post_model.dart';
import '../model/product_model.dart';

class ApiHelper{
  static String logInRoute='/auth/login';
  static String productRoute='/products';
  static String queryRoute='/products/search';
  static Future<PostModel>logIn(String username,String password) async {
    var res=await DioInstance.post(logInRoute,data: {
      'username' : username,
      'password' : password
    },
    );
    
      return postModelFromJson(jsonEncode(res.data));
    

  }
  static Future<ProductsModel>getProductsList () async {
    var res= await DioInstance.get(productRoute,);
    return productsModelFromJson(jsonEncode(res.data));
  }
  static Future<ProductsModel> queryData(String phone) async {
    var res=await DioInstance.get(queryRoute,queryParameters: {
      'q': phone
    });
    return productsModelFromJson(jsonEncode(res.data));
  }
}