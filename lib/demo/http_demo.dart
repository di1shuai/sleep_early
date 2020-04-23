import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sleep_early/api/api.dart';
import 'package:sleep_early/api/api_url.dart';
import 'package:sleep_early/api/api_util.dart';
import 'package:sleep_early/models/account.dart';


Map<String, dynamic> optHeader = {
  'accept-language': 'zh-cn',
  'content-type': 'application/json'
};

var dio = new Dio(BaseOptions(connectTimeout: 30000, headers: optHeader,baseUrl: APIUrl.BASE_URL));


Future<Account> fetchAccount(int id) async {
  String url = APIUrl.BASE_URL + APIUrl.ACCOUNT + '1';
  print(url);
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Account.fromJson(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load account');
  }
}

Future<Account> fetchAccountDio(int id) async {
  String url = APIUrl.BASE_URL+APIUrl.ACCOUNT + id.toString();
  print(url);

  final Response responseFirst = await dio.get(url);

  try {
    print('准备开始');
    Account account = Account.fromMap(responseFirst.data);
    return account;
  } catch (err) {
    throw Exception('Failed to load Account');
  }
}

Future<Account> fetchAccountBaseURL(int id) async {

  
  String url = APIUrl.ACCOUNT + id.toString();
  print(url);

  final Response responseFirst = await dio.get(url);

  try {
    print('准备开始');
    Account account = Account.fromMap(responseFirst.data);
    return account;
  } catch (err) {
    throw Exception('Failed to load Account');
  }
}


Future<Account> fetchAccountAPI(int id) async {
  
  Future<Account> futureAccount =  API.getAccount(id);
  return futureAccount;
}


class HttpApp extends StatefulWidget {
  HttpApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<HttpApp> {
  Future<Account> futureAccount;

  @override
  void initState() {
    super.initState();
    futureAccount = fetchAccountBaseURL(1);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Account>(
            future: futureAccount,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.id.toString());
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
