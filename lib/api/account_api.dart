import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleep_early/common/api_url.dart';
import 'package:sleep_early/common/providers.dart';
import 'package:sleep_early/models/account.dart';

import 'api_util.dart';

class AccountAPI {

   // Account

  static Future<Account> getAccount(int id) async {
    Map data = await APIUtil.get(APIUrl.ACCOUNT + id.toString());
    try {
      Account account = Account.fromMap(data);

      return account;
    } catch (err) {
      throw Exception('Failed to load Account');
    }
  }

  static Account currentAccount(BuildContext context) {
    AccountProvider accountPrd = Provider.of<AccountProvider>(context,listen: false);
    return accountPrd.account;
  }
}