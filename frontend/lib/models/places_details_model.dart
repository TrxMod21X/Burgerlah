class PlacesDetailsModel {
  ResponseBody? response;

  PlacesDetailsModel({this.response});

  PlacesDetailsModel.fromJson(Map<String, dynamic> json) {
    response = json['Response'] != null
        ? ResponseBody.fromJson(json['Response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['Response'] = this.response!.toJson();
    }
    return data;
  }
}

class ResponseBody {
  MetaInfo? metaInfo;
  List<View>? view;

  ResponseBody({this.metaInfo, this.view});

  ResponseBody.fromJson(Map<String, dynamic> json) {
    metaInfo = json['MetaInfo'] != null
        ? new MetaInfo.fromJson(json['MetaInfo'])
        : null;
    if (json['View'] != null) {
      view = <View>[];
      json['View'].forEach((v) {
        view!.add(new View.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.metaInfo != null) {
      data['MetaInfo'] = this.metaInfo!.toJson();
    }
    if (this.view != null) {
      data['View'] = this.view!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MetaInfo {
  String? timestamp;

  MetaInfo({this.timestamp});

  MetaInfo.fromJson(Map<String, dynamic> json) {
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Timestamp'] = this.timestamp;
    return data;
  }
}

class View {
  String? sType;
  int? viewId;
  List<Result>? result;

  View({this.sType, this.viewId, this.result});

  View.fromJson(Map<String, dynamic> json) {
    sType = json['_type'];
    viewId = json['ViewId'];
    if (json['Result'] != null) {
      result = <Result>[];
      json['Result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_type'] = this.sType;
    data['ViewId'] = this.viewId;
    if (this.result != null) {
      data['Result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? relevance;
  String? matchLevel;
  Location? location;

  Result({this.relevance, this.matchLevel, this.location});

  Result.fromJson(Map<String, dynamic> json) {
    relevance = json['Relevance'];
    matchLevel = json['MatchLevel'];
    location = json['Location'] != null
        ? new Location.fromJson(json['Location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Relevance'] = this.relevance;
    data['MatchLevel'] = this.matchLevel;
    if (this.location != null) {
      data['Location'] = this.location!.toJson();
    }
    return data;
  }
}

class Location {
  String? locationId;
  String? locationType;
  DisplayPosition? displayPosition;
  MapView? mapView;
  Address? address;

  Location(
      {this.locationId,
      this.locationType,
      this.displayPosition,
      this.mapView,
      this.address});

  Location.fromJson(Map<String, dynamic> json) {
    locationId = json['LocationId'];
    locationType = json['LocationType'];
    displayPosition = json['DisplayPosition'] != null
        ? new DisplayPosition.fromJson(json['DisplayPosition'])
        : null;
    mapView =
        json['MapView'] != null ? new MapView.fromJson(json['MapView']) : null;
    address =
        json['Address'] != null ? new Address.fromJson(json['Address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LocationId'] = this.locationId;
    data['LocationType'] = this.locationType;
    if (this.displayPosition != null) {
      data['DisplayPosition'] = this.displayPosition!.toJson();
    }
    if (this.mapView != null) {
      data['MapView'] = this.mapView!.toJson();
    }
    if (this.address != null) {
      data['Address'] = this.address!.toJson();
    }
    return data;
  }
}

class DisplayPosition {
  double? latitude;
  double? longitude;

  DisplayPosition({this.latitude, this.longitude});

  DisplayPosition.fromJson(Map<String, dynamic> json) {
    latitude = json['Latitude'];
    longitude = json['Longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    return data;
  }
}

class MapView {
  DisplayPosition? topLeft;
  DisplayPosition? bottomRight;

  MapView({this.topLeft, this.bottomRight});

  MapView.fromJson(Map<String, dynamic> json) {
    topLeft = json['TopLeft'] != null
        ? new DisplayPosition.fromJson(json['TopLeft'])
        : null;
    bottomRight = json['BottomRight'] != null
        ? new DisplayPosition.fromJson(json['BottomRight'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topLeft != null) {
      data['TopLeft'] = this.topLeft!.toJson();
    }
    if (this.bottomRight != null) {
      data['BottomRight'] = this.bottomRight!.toJson();
    }
    return data;
  }
}

class Address {
  String? label;
  String? country;
  String? county;
  String? city;
  String? postalCode;
  List<AdditionalData>? additionalData;

  Address(
      {this.label,
      this.country,
      this.county,
      this.city,
      this.postalCode,
      this.additionalData});

  Address.fromJson(Map<String, dynamic> json) {
    label = json['Label'];
    country = json['Country'];
    county = json['County'];
    city = json['City'];
    postalCode = json['PostalCode'];
    if (json['AdditionalData'] != null) {
      additionalData = <AdditionalData>[];
      json['AdditionalData'].forEach((v) {
        additionalData!.add(new AdditionalData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Label'] = this.label;
    data['Country'] = this.country;
    data['County'] = this.county;
    data['City'] = this.city;
    data['PostalCode'] = this.postalCode;
    if (this.additionalData != null) {
      data['AdditionalData'] =
          this.additionalData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdditionalData {
  String? value;
  String? key;

  AdditionalData({this.value, this.key});

  AdditionalData.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['key'] = this.key;
    return data;
  }
}