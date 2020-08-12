class ValidateOtpRequest{
  String _mailid;
  String _otp;

  String get mailid => _mailid;

  set mailid(String value) {
    _mailid = value;
  }

  String get otp => _otp;

  set otp(String value) {
    _otp = value;
  }
}