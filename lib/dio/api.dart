
import 'dart:convert';
import 'dart:io';

import 'package:admin_app/dio/dio_handler.dart';
import 'package:dio/dio.dart';

class Api{
  static const baseUrl = 'https://project-628h.onrender.com';

  static const getCategoryApi = "$baseUrl/getCategory/";

  static const addCategoryApi = "$baseUrl/addCategory/";
}


class FetchApi{
  Future<Map> addCategory(
    context,
    Map<String, dynamic> data,

  )async{
    String url = Api.addCategoryApi;
    Map? result;
    await ApiHandler.postDataDio(url, data).then((response){
      if(response != null){
        result = response;
      }
    });

    return Future.value(result);
  }

  Future<Map> fetchCategory()async{
    String url = Api.getCategoryApi;
    return Future.value(await ApiHandler.getDataDio(url));
  }
}
