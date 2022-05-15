class Session {
  String? token;
  String? refreshToken;
  String? tokenType;
  int? expiryDuration;

  Session(
      {this.token,
      this.refreshToken,
      this.tokenType,
      this.expiryDuration});

  factory Session.fromJson(Map<String,dynamic> parsedJson){
    return Session(
      token: parsedJson['token'],
      refreshToken: parsedJson['refreshToken'],
      tokenType: parsedJson['tokenType'],
      expiryDuration: parsedJson['expiryDuration'],
    );
  }

  Map<String, dynamic> toJson() => {
    'token' : token,
    'refreshToken' : refreshToken,
    'tokenType' : tokenType,
    'expiryDuration' : expiryDuration
  };
}
