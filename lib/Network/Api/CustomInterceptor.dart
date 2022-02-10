
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:knet/utils/ToastUtils.dart';

class CustomInterceptor extends Interceptor {
  final BuildContext context;

  CustomInterceptor(this.context);

  // CustomInterceptor({ Key key, @required this.ctx });


  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    print("onRequest");
    // EasyLoading.show();
    return super.onRequest(options, handler);
  }

  @override
   void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(response.statusCode);
    print("onResponse");
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    print("onError: ${err.response.statusMessage}");
    // EasyLoading.dismiss();
    // EasyLoading.showToast(err.response.statusMessage);
    // ToastUtils.show(err.response.statusMessage);

    // Text('Error');
    ScaffoldMessenger.of(context)
        .showSnackBar((SnackBar(content: Text(err.response.statusMessage,style: TextStyle(color: Colors.yellow),))));
    return handler.next(err);  // <--- THE TIP IS HERE
  }
}