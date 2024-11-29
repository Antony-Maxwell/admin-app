import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

class ApiHandler {
  static Future<Map?> postDataDio(String url, Map<String?, dynamic>? postData,
      {List<File> attachments = const [], String imageKey = "images"}) async {
    try {
      final dio = Dio();
      Map<String, dynamic> finalData = {};

      postData?.forEach((key, value) {
        if (key != null && key != 'image') {
          finalData[key] = value;
        }
      });

      final formData = FormData.fromMap(finalData);

      if (postData?['image'] != null) {
        formData.files.add(MapEntry(
            'image', await MultipartFile.fromFile(postData!['image'])));
      }
      for (var file in attachments) {
        formData.files.add(
          MapEntry(
            "$imageKey[]",
            await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            ),
          ),
        );
      }

      dio.options.validateStatus = (status) => status! < 500;
      final response = await dio.post(url, data: formData);

      Map data =
          response.data is String ? json.decode(response.data) : response.data;
      data['status_code'] = response.statusCode;
      return data;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future<Map?> getDataDio(String? url) async {

    final dio = Dio()..options = BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30)
      );


    try {

      final response = await retry(
        () => dio.get(url!),
        retryIf: (e) => e is DioException &&
            (e.type == DioExceptionType.connectionTimeout ||
             e.type == DioExceptionType.connectionError),
        maxAttempts: 3,
        delayFactor: const Duration(seconds: 1),
      );

      Map data = response.data is String
          ? json.decode(response.data)
          : Map.from(response.data);

      data['status_code'] = response.statusCode;
      return data;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
