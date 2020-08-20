class SubmitUserReviewRequest {
  String _mailId;
  String _stars;
  String _comment;

  String get mailId => _mailId;

  set mailId(String value) {
    _mailId = value;
  }

  String get stars => _stars;

  String get comment => _comment;

  set comment(String value) {
    _comment = value;
  }

  set stars(String value) {
    _stars = value;
  }
}
