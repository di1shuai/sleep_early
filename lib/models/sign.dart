import 'dart:convert';

import 'package:sleep_early/models/enums/identity_type.dart';

class Sign {
  String username;
  String password;
  IdentityType identityType;

  Sign({
    this.username,
    this.password,
    this.identityType,
  });

  Sign copyWith({
    String username,
    String password,
    IdentityType identityType,
  }) {
    return Sign(
      username: username ?? this.username,
      password: password ?? this.password,
      identityType: identityType ?? this.identityType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'identityType': identityType.index,
    };
  }

  static Sign fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Sign(
      username: map['username'],
      password: map['password'],
      identityType: IdentityType.values[map['identityType']],
    );
  }

  String toJson() => json.encode(toMap());

  static Sign fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Sign(username: $username, password: $password, identityType: $identityType)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Sign &&
      o.username == username &&
      o.password == password &&
      o.identityType == identityType;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode ^ identityType.hashCode;
}
