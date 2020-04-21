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

  String message;

  String detail;
  
  Error({
    this.message,
    this.detail,
  });


  Error copyWith({
    String message,
    String detail,
  }) {
    return Error(
      message: message ?? this.message,
      detail: detail ?? this.detail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'detail': detail,
    };
  }

  static Error fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Error(
      message: map['message'],
      detail: map['detail'],
    );
  }

  String toJson() => json.encode(toMap());

  static Error fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Error(message: $message, detail: $detail)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Error &&
      o.message == message &&
      o.detail == detail;
  }

  @override
  int get hashCode => message.hashCode ^ detail.hashCode;
}
