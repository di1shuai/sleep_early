import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';
import 'package:sleep_early/api/api_url.dart';
import 'package:sleep_early/api/api_util.dart';
import 'package:sleep_early/common/global.dart';
import 'package:sleep_early/common/providers.dart';
import 'package:sleep_early/models/account.dart';
import 'package:sleep_early/models/device.dart';

class API {
  // Login

  static Future<Account> login(String username, String password) async {
    Map data = await APIUtil.post(APIUrl.LOGIN, {"id": username});
    try {
      Account account = Account.fromMap(data);
      return account;
    } catch (err) {
      throw Exception('Failed to login');
    }
  }

  static bool isLogin(BuildContext context) {
    AccountProvider proAccount = Provider.of<AccountProvider>(context);
    return proAccount.isLogin;
  }
  
}
