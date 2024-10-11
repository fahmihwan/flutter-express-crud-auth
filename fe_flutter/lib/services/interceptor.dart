import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ApiService {
  Dio api = Dio();

  ApiService() {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    api.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Modifikasi permintaan sebelum dikirim
        if (!options.path.contains('http')) {
          options.path = 'http://192.168.1.8:3000/api' + options.path;
        }

        // Ambil access token dari SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? accessToken = prefs.getString('auth_token');

        // Tambahkan Bearer token ke header
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken paksa salah';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        navigatorKey.currentState?.pushNamed('/');
        // if (response.statusCode == 401) {
        //   // Navigator.current.pushReplacementNamed('/login');
        //   navigatorKey.currentState?.pushNamed('/');
        // }
        // Modifikasi respons sebelum dikembalikan
        // print("Response: ${response.data}");
        return handler.next(response);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) {
        navigatorKey.currentState?.pushNamed('/');
        if (error.response?.statusCode == 401) {
          // Navigator.current.pushReplacementNamed('/login');
          // navigatorKey.currentState?.pushNamed('/');
        }
        return handler.next(error);
      },
    ));
  }
}
