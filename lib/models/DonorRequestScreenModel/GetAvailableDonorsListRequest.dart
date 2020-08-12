class GetAvailableDonorsListRequest{
  String _country;
  String _state;
  String _district;
  String _city;
  String _town;
  String _bloodGroup;

  String get country => _country;

  set country(String value) {
    _country = value;
  }

  String get state => _state;

  String get bloodGroup => _bloodGroup;

  set bloodGroup(String value) {
    _bloodGroup = value;
  }

  String get town => _town;

  set town(String value) {
    _town = value;
  }

  String get city => _city;

  set city(String value) {
    _city = value;
  }

  String get district => _district;

  set district(String value) {
    _district = value;
  }

  set state(String value) {
    _state = value;
  }
}