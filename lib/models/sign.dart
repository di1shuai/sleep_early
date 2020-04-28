import 'dart:convert';

import 'package:sleep_early/models/enums/identity_type.dart';

class Sign {
  String username;
  String password;
  IdentityType identityType;
  String verifiedCode;
  Sign({
    this.username,
    this.password,
    this.identityType,
    this.verifiedCode,
  });

  Sign copyWith({
    String username,
    String password,
    IdentityType identityType,
    String verifiedCode,
  }) {
    return Sign(
      username: username ?? this.username,
      password: password ?? this.password,
      identityType: identityType ?? this.identityType,
      verifiedCode: verifiedCode ?? this.verifiedCode,
    );
  }

  String toJson() => json.encode(toMap());

  static Sign fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Sign(username: $username, password: $password, identityType: $identityType, verifiedCode: $verifiedCode)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Sign &&
      o.username == username &&
      o.password == password &&
      o.identityType == identityType &&
      o.verifiedCode == verifiedCode;
  }

  @override
  int get hashCode {
    return username.hashCode ^
      password.hashCode ^
      identityType.hashCode ^
      verifiedCode.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'identityType': identityType.index,
      'verifiedCode': verifiedCode,
    };
  }

  static Sign fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Sign(
      username: map['username'],
      password: map['password'],
      identityType: IdentityType.values[map['identityType']],
      verifiedCode: map['verifiedCode'],
    );
  }
}
