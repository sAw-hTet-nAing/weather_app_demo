// ignore_for_file: prefer_collection_literals

class DB {
  int? id;
  String? city;
  String? country;
  dynamic lat;
  dynamic long;

  dynamic time;

  DB({
    this.id,
    required this.city,
    required this.country,
    required this.lat,
    required this.long,
    required this.time,
  });

  DB.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    country = json['country'];
    lat = json['lat'];
    long = json['long'];

    time = json["time_created"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['city'] = city;
    data['country'] = country;
    data['lat'] = lat;
    data['long'] = long;

    data["time_created"] = time;

    return data;
  }
}
