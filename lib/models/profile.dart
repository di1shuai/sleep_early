import 'dart:convert';

import 'account.dart';

class Profile {
  Account account;
  String token;
  int theme;
  int lastSigninId;
  String locale;
  Profile({
    this.account,
    this.token,
    this.theme,
    this.lastSigninId,
    this.locale,
  });

  Profile copyWith({
    Account account,
    String token,
    int theme,
    int lastSigninId,
    String locale,
  }) {
    return Profile(
      account: account ?? this.account,
      token: token ?? this.token,
      theme: theme ?? this.theme,
      lastSigninId: lastSigninId ?? this.lastSigninId,
      locale: locale ?? this.locale,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'account': account?.toMap(),
      'token': token,
      'theme': theme,
      'lastSigninId': lastSigninId,
      'locale': locale,
    };
  }

  static Profile fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Profile(
      account: Account.fromMap(map['account']),
      token: map['token'],
      theme: map['theme'],
      lastSigninId: map['lastSigninId'],
      locale: map['locale'],
    );
  }

  String toJson() => json.encode(toMap());

  static Profile fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Profile(account: $account, token: $token, theme: $theme, lastSigninId: $lastSigninId, locale: $locale)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Profile &&
      o.account == account &&
      o.token == token &&
      o.theme == theme &&
      o.lastSigninId == lastSigninId &&
      o.locale == locale;
  }

  @override
  int get hashCode {
    return account.hashCode ^
      token.hashCode ^
      theme.hashCode ^
      lastSigninId.hashCode ^
      locale.hashCode;
  }
}
