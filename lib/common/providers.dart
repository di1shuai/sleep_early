import 'package:flutter/material.dart';
import 'package:sleep_early/models/account.dart';

class AccountProvider with ChangeNotifier {
  Account _account;

  Account get account => this._account;

  set account(Account account) {
    this._account = account;
    notifyListeners();
  }
}
