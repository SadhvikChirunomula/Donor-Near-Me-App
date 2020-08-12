class UpdateFcmTokenRequest{
  String _mailid;
  String _fcmToken;

  String get mailid => _mailid;

  set mailid(String value) {
    _mailid = value;
  }

  String get fcmToken => _fcmToken;

  set fcmToken(String value) {
    _fcmToken = value;
  }
}