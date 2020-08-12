class AuthenticateModel{
  String _mailid;
  String _password;

  String get mailid => _mailid;

  set mailid(String value) {
    _mailid = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }
}