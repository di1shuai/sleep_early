import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleep_early/common/api_url.dart';
import 'package:sleep_early/common/providers.dart';
import 'package:sleep_early/models/account.dart';
import 'package:sleep_early/models/sign.dart';

import 'api_util.dart';

class SignAPI {
  static bool isSignin(BuildContext context) {
    AccountProvider proAccount = Provider.of<AccountProvider>(context);
    return proAccount.isSignin;
  }

  // signin
  static Future<Account> signin(Sign sign) async {
    Map data = await APIUtil.post(APIUrl.SIGNIN, sign.toMap());
    try {
      Account account = Account.fromMap(data);
      return account;
    } catch (err) {
      throw Exception('Failed to login');
    }
  }

  // signup
  static Future<Account> signup(Sign sign) async {
    Map data = await APIUtil.post(APIUrl.SIGNUP, sign.toMap());
    try {
      Account account = Account.fromMap(data);
      return account;
    } catch (err) {
      throw Exception('Failed to login');
    }
  }

  // verified
  static Future<bool> verified(Sign sign) async {
    var data = await APIUtil.post(APIUrl.VERIFIED, sign.toMap());
    try {
      if (data == null) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      throw Exception('Failed to login');
    }
  }
}
