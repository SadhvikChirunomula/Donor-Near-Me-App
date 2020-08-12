class GetPincodeRequest{
  String _country;
  String _state;

  String get country => _country;

  set country(String value) {
    _country = value;
  }

  String _district;
  String _city;
  String _town;

  String get state => _state;

  set state(String value) {
    _state = value;
  }

  String get district => _district;

  set district(String value) {
    _district = value;
  }

  String get city => _city;

  set city(String value) {
    _city = value;
  }

  String get town => _town;

  set town(String value) {
    _town = value;
  }
}