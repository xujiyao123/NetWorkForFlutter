
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

var NET = NetWorkManager.getInstance();

enum RequestMethod {
  get ,
  post
}

class NetWorkManager {

     static NetWorkManager _instance;

     static NetWorkManager getInstance() {
       if (_instance == null) {
         _instance = NetWorkManager();
       }
       return _instance;
     }

     Dio dio;
     Response response;


      NetWorkManager() {
       _init();
      }

      _init() {
        dio = new Dio();
        dio.options.connectTimeout = 5000;
        dio.options.receiveTimeout = 3000;
      }

      Future request({
        @required String url ,
        RequestMethod method = RequestMethod.get,
        Map<String, dynamic> params  ,
        ResponseType responseType = ResponseType.json,
        ContentType contentType,
        Function success ,
        Function error}) async {
        try {
           response = await _baseRequest(
               url: url ,
               method:  method ,
               params:  params ,
               responseType: responseType ,
               contentType: contentType);

        } on DioError catch (dioError) {
          if (error != null) {
            error(dioError);
          }

          return Future.error(dioError);
        }
        if (response != null) {
          if (success != null) {
            success(response);
          }
          return response;
        }
      }



     Future _baseRequest({
        String url,
        Map<String, dynamic> params  ,
        RequestMethod method = RequestMethod.get,
        ContentType contentType  ,
        ResponseType responseType = ResponseType.json}) async {

        if (contentType == null) {
          contentType =  ContentType.parse("application/x-www-form-urlencoded");
        }

        if (method == RequestMethod.get) {
          return await dio.get(
              url,
              queryParameters: params,
              options: Options(responseType:responseType , contentType: contentType)
          );
        } else if (method == RequestMethod.post) {
          return await dio.post(
            url,
            queryParameters: params,
            options: RequestOptions(responseType: responseType , contentType: contentType)
          );
        }
      }

}