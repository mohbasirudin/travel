import 'package:meta/meta.dart';
import 'dart:convert';

class ModelHotels {
  final String type;
  final List<Feature> features;

  ModelHotels({
    required this.type,
    required this.features,
  });

  factory ModelHotels.fromRawJson(String str) =>
      ModelHotels.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelHotels.fromJson(Map<String, dynamic> json) => ModelHotels(
        type: json["type"],
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
      };
}

class Feature {
  final FeatureType type;
  final Properties properties;
  final Geometry geometry;

  Feature({
    required this.type,
    required this.properties,
    required this.geometry,
  });

  factory Feature.fromRawJson(String str) => Feature.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        type: featureTypeValues.map[json["type"]]!,
        properties: Properties.fromJson(json["properties"]),
        geometry: Geometry.fromJson(json["geometry"]),
      );

  Map<String, dynamic> toJson() => {
        "type": featureTypeValues.reverse[type],
        "properties": properties.toJson(),
        "geometry": geometry.toJson(),
      };
}

class Geometry {
  final GeometryType type;
  final List<double> coordinates;

  Geometry({
    required this.type,
    required this.coordinates,
  });

  factory Geometry.fromRawJson(String str) =>
      Geometry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: geometryTypeValues.map[json["type"]]!,
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": geometryTypeValues.reverse[type],
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

enum GeometryType { POINT }

final geometryTypeValues = EnumValues({"Point": GeometryType.POINT});

class Properties {
  final String name;
  final Country country;
  final CountryCode countryCode;
  final Region region;
  final State state;
  final City city;
  final String village;
  final String postcode;
  final String street;
  final double lon;
  final double lat;
  final String formatted;
  final String addressLine1;
  final String addressLine2;
  final List<Category> categories;
  final List<String> details;
  final Datasource datasource;
  final int distance;
  final String placeId;
  final String housenumber;
  final NameInternational nameInternational;
  final Contact contact;
  final String website;
  final Facilities facilities;

  Properties({
    required this.name,
    required this.country,
    required this.countryCode,
    required this.region,
    required this.state,
    required this.city,
    required this.village,
    required this.postcode,
    required this.street,
    required this.lon,
    required this.lat,
    required this.formatted,
    required this.addressLine1,
    required this.addressLine2,
    required this.categories,
    required this.details,
    required this.datasource,
    required this.distance,
    required this.placeId,
    required this.housenumber,
    required this.nameInternational,
    required this.contact,
    required this.website,
    required this.facilities,
  });

  factory Properties.fromRawJson(String str) =>
      Properties.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        name: json["name"],
        country: countryValues.map[json["country"]]!,
        countryCode: countryCodeValues.map[json["country_code"]]!,
        region: regionValues.map[json["region"]]!,
        state: stateValues.map[json["state"]]!,
        city: cityValues.map[json["city"]]!,
        village: json["village"],
        postcode: json["postcode"],
        street: json["street"],
        lon: json["lon"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
        formatted: json["formatted"],
        addressLine1: json["address_line1"],
        addressLine2: json["address_line2"],
        categories: List<Category>.from(
            json["categories"].map((x) => categoryValues.map[x]!)),
        details: List<String>.from(json["details"].map((x) => x)),
        datasource: Datasource.fromJson(json["datasource"]),
        distance: json["distance"],
        placeId: json["place_id"],
        housenumber: json["housenumber"],
        nameInternational:
            NameInternational.fromJson(json["name_international"]),
        contact: Contact.fromJson(json["contact"]),
        website: json["website"],
        facilities: Facilities.fromJson(json["facilities"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "country": countryValues.reverse[country],
        "country_code": countryCodeValues.reverse[countryCode],
        "region": regionValues.reverse[region],
        "state": stateValues.reverse[state],
        "city": cityValues.reverse[city],
        "village": village,
        "postcode": postcode,
        "street": street,
        "lon": lon,
        "lat": lat,
        "formatted": formatted,
        "address_line1": addressLine1,
        "address_line2": addressLine2,
        "categories": List<dynamic>.from(
            categories.map((x) => categoryValues.reverse[x])),
        "details": List<dynamic>.from(details.map((x) => x)),
        "datasource": datasource.toJson(),
        "distance": distance,
        "place_id": placeId,
        "housenumber": housenumber,
        "name_international": nameInternational.toJson(),
        "contact": contact.toJson(),
        "website": website,
        "facilities": facilities.toJson(),
      };
}

enum Category {
  ACCOMMODATION,
  ACCOMMODATION_HOTEL,
  BUILDING,
  BUILDING_ACCOMMODATION,
  WHEELCHAIR,
  WHEELCHAIR_LIMITED
}

final categoryValues = EnumValues({
  "accommodation": Category.ACCOMMODATION,
  "accommodation.hotel": Category.ACCOMMODATION_HOTEL,
  "building": Category.BUILDING,
  "building.accommodation": Category.BUILDING_ACCOMMODATION,
  "wheelchair": Category.WHEELCHAIR,
  "wheelchair.limited": Category.WHEELCHAIR_LIMITED
});

enum City { JEMBER }

final cityValues = EnumValues({"Jember": City.JEMBER});

class Contact {
  final String phone;

  Contact({
    required this.phone,
  });

  factory Contact.fromRawJson(String str) => Contact.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
      };
}

enum Country { INDONESIA }

final countryValues = EnumValues({"Indonesia": Country.INDONESIA});

enum CountryCode { ID }

final countryCodeValues = EnumValues({"id": CountryCode.ID});

class Datasource {
  final Sourcename sourcename;
  final Attribution attribution;
  final License license;
  final String url;
  final Raw raw;

  Datasource({
    required this.sourcename,
    required this.attribution,
    required this.license,
    required this.url,
    required this.raw,
  });

  factory Datasource.fromRawJson(String str) =>
      Datasource.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datasource.fromJson(Map<String, dynamic> json) => Datasource(
        sourcename: sourcenameValues.map[json["sourcename"]]!,
        attribution: attributionValues.map[json["attribution"]]!,
        license: licenseValues.map[json["license"]]!,
        url: json["url"],
        raw: Raw.fromJson(json["raw"]),
      );

  Map<String, dynamic> toJson() => {
        "sourcename": sourcenameValues.reverse[sourcename],
        "attribution": attributionValues.reverse[attribution],
        "license": licenseValues.reverse[license],
        "url": url,
        "raw": raw.toJson(),
      };
}

enum Attribution { OPEN_STREET_MAP_CONTRIBUTORS }

final attributionValues = EnumValues(
    {"© OpenStreetMap contributors": Attribution.OPEN_STREET_MAP_CONTRIBUTORS});

enum License { OPEN_DATABASE_LICENSE }

final licenseValues =
    EnumValues({"Open Database License": License.OPEN_DATABASE_LICENSE});

class Raw {
  final String name;
  final int osmId;
  final Tourism tourism;
  final OsmType osmType;
  final String phone;
  final String nameEn;
  final String addrStreet;
  final int addrPostcode;
  final int addrHousenumber;
  final String addrCity;
  final String building;
  final String smoking;
  final String website;
  final String wheelchair;

  Raw({
    required this.name,
    required this.osmId,
    required this.tourism,
    required this.osmType,
    required this.phone,
    required this.nameEn,
    required this.addrStreet,
    required this.addrPostcode,
    required this.addrHousenumber,
    required this.addrCity,
    required this.building,
    required this.smoking,
    required this.website,
    required this.wheelchair,
  });

  factory Raw.fromRawJson(String str) => Raw.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Raw.fromJson(Map<String, dynamic> json) => Raw(
        name: json["name"],
        osmId: json["osm_id"],
        tourism: tourismValues.map[json["tourism"]]!,
        osmType: osmTypeValues.map[json["osm_type"]]!,
        phone: json["phone"],
        nameEn: json["name:en"],
        addrStreet: json["addr:street"],
        addrPostcode: json["addr:postcode"],
        addrHousenumber: json["addr:housenumber"],
        addrCity: json["addr:city"],
        building: json["building"],
        smoking: json["smoking"],
        website: json["website"],
        wheelchair: json["wheelchair"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "osm_id": osmId,
        "tourism": tourismValues.reverse[tourism],
        "osm_type": osmTypeValues.reverse[osmType],
        "phone": phone,
        "name:en": nameEn,
        "addr:street": addrStreet,
        "addr:postcode": addrPostcode,
        "addr:housenumber": addrHousenumber,
        "addr:city": addrCity,
        "building": building,
        "smoking": smoking,
        "website": website,
        "wheelchair": wheelchair,
      };
}

enum OsmType { N, W }

final osmTypeValues = EnumValues({"n": OsmType.N, "w": OsmType.W});

enum Tourism { HOTEL }

final tourismValues = EnumValues({"hotel": Tourism.HOTEL});

enum Sourcename { OPENSTREETMAP }

final sourcenameValues =
    EnumValues({"openstreetmap": Sourcename.OPENSTREETMAP});

class Facilities {
  final bool smoking;
  final bool wheelchair;
  final WheelchairDetails wheelchairDetails;

  Facilities({
    required this.smoking,
    required this.wheelchair,
    required this.wheelchairDetails,
  });

  factory Facilities.fromRawJson(String str) =>
      Facilities.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Facilities.fromJson(Map<String, dynamic> json) => Facilities(
        smoking: json["smoking"],
        wheelchair: json["wheelchair"],
        wheelchairDetails:
            WheelchairDetails.fromJson(json["wheelchair_details"]),
      );

  Map<String, dynamic> toJson() => {
        "smoking": smoking,
        "wheelchair": wheelchair,
        "wheelchair_details": wheelchairDetails.toJson(),
      };
}

class WheelchairDetails {
  final String condition;

  WheelchairDetails({
    required this.condition,
  });

  factory WheelchairDetails.fromRawJson(String str) =>
      WheelchairDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WheelchairDetails.fromJson(Map<String, dynamic> json) =>
      WheelchairDetails(
        condition: json["condition"],
      );

  Map<String, dynamic> toJson() => {
        "condition": condition,
      };
}

class NameInternational {
  final String en;

  NameInternational({
    required this.en,
  });

  factory NameInternational.fromRawJson(String str) =>
      NameInternational.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NameInternational.fromJson(Map<String, dynamic> json) =>
      NameInternational(
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
      };
}

enum Region { JAVA }

final regionValues = EnumValues({"Java": Region.JAVA});

enum State { EAST_JAVA }

final stateValues = EnumValues({"East Java": State.EAST_JAVA});

enum FeatureType { FEATURE }

final featureTypeValues = EnumValues({"Feature": FeatureType.FEATURE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
