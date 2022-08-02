class SuggestionModel {
  String? label;
  String? language;
  String? countryCode;
  String? locationId;
  Address? address;
  String? matchLevel;

  SuggestionModel(
      {this.label,
      this.language,
      this.countryCode,
      this.locationId,
      this.address,
      this.matchLevel});

  SuggestionModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    language = json['language'];
    countryCode = json['countryCode'];
    locationId = json['locationId'];
    address = Address.fromJson(json['address']);
    matchLevel = json['matchLevel'];
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'language': language,
      'countryCode': countryCode,
      'locationId': locationId,
      'address': address!.toJson(),
      'matchLevel': matchLevel,
    };
  }
}

class Address {
  String? country;
  String? county;
  String? city;
  String? postalCode;

  Address({this.country, this.county, this.city, this.postalCode});

  Address.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    county = json['county'];
    city = json['city'];
    postalCode = json['postalCode'];
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'county': county,
      'city': city,
      'postalCode': postalCode,
    };
  }
}
