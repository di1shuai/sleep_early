import 'dart:convert';

class APIResponse {

  int code;

  dynamic data;

  Error error;

  APIResponse({
    this.code,
    this.data,
    this.error,
  });
  
  APIResponse copyWith({
    int code,
    dynamic data,
    Error error,
  }) {
    return APIResponse(
      code: code ?? this.code,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'data': data,
      'error': error.toMap(),
    };
  }

  static APIResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return APIResponse(
      code: map['code'],
      data: map['data'],
      error: Error.fromMap(map['error']),
    );
  }

  String toJson() => json.encode(toMap());

  static APIResponse fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'APIResponse(code: $code, data: $data, error: $error)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is APIResponse &&
      o.code == code &&
      o.data == data &&
      o.error == error;
  }

  @override
  int get hashCode => code.hashCode ^ data.hashCode ^ error.hashCode;
}


class Error {

  int errorCode;

  String errorMsg;
  
  Error({
    this.errorCode,
    this.errorMsg,
  });


  Error copyWith({
    int errorCode,
    String errorMsg,
  }) {
    return Error(
      errorCode: errorCode ?? this.errorCode,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'errorCode': errorCode,
      'errorMsg': errorMsg,
    };
  }

  static Error fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Error(
      errorCode: map['errorCode'],
      errorMsg: map['errorMsg'],
    );
  }

  String toJson() => json.encode(toMap());

  static Error fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Error(errorCode: $errorCode, errorMsg: $errorMsg)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Error &&
      o.errorCode == errorCode &&
      o.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorCode.hashCode ^ errorMsg.hashCode;
}
