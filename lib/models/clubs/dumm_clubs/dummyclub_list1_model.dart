class DummyDataResponse {
  List<Data>? data;
  bool? status;
  String? message;

  DummyDataResponse({this.data, this.status, this.message});

  DummyDataResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  Identity? identity;
  List<String>? labels;
  Properties? properties;
  String? elementId;

  Data({this.identity, this.labels, this.properties, this.elementId});

  Data.fromJson(Map<String, dynamic> json) {
    identity = json['identity'] != null
        ? new Identity.fromJson(json['identity'])
        : null;
    labels = json['labels'].cast<String>();
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;
    elementId = json['elementId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.identity != null) {
      data['identity'] = this.identity!.toJson();
    }
    data['labels'] = this.labels;
    if (this.properties != null) {
      data['properties'] = this.properties!.toJson();
    }
    data['elementId'] = this.elementId;
    return data;
  }
}

class Identity {
  int? low;
  int? high;

  Identity({this.low, this.high});

  Identity.fromJson(Map<String, dynamic> json) {
    low = json['low'];
    high = json['high'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['low'] = this.low;
    data['high'] = this.high;
    return data;
  }
}

class Properties {
  Identity? founderId;
  Identity? categoryId;
  UpdatedAt? updatedAt;
  UpdatedAt? createdAt;
  String? clubName;
  Identity? locationId;

  Properties(
      {this.founderId,
        this.categoryId,
        this.updatedAt,
        this.createdAt,
        this.clubName,
        this.locationId});

  Properties.fromJson(Map<String, dynamic> json) {
    founderId = json['founder_id'] != null
        ? new Identity.fromJson(json['founder_id'])
        : null;
    categoryId = json['category_id'] != null
        ? new Identity.fromJson(json['category_id'])
        : null;
    updatedAt = json['updated_at'] != null
        ? new UpdatedAt.fromJson(json['updated_at'])
        : null;
    createdAt = json['created_at'] != null
        ? new UpdatedAt.fromJson(json['created_at'])
        : null;
    clubName = json['club_name'];
    locationId = json['location_id'] != null
        ? new Identity.fromJson(json['location_id'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.founderId != null) {
      data['founder_id'] = this.founderId!.toJson();
    }
    if (this.categoryId != null) {
      data['category_id'] = this.categoryId!.toJson();
    }
    if (this.updatedAt != null) {
      data['updated_at'] = this.updatedAt!.toJson();
    }
    if (this.createdAt != null) {
      data['created_at'] = this.createdAt!.toJson();
    }
    data['club_name'] = this.clubName;
    if (this.locationId != null) {
      data['location_id'] = this.locationId!.toJson();
    }
    return data;
  }
}

class UpdatedAt {
  Identity? year;
  Identity? month;
  Identity? day;
  Identity? hour;
  Identity? minute;
  Identity? second;
  Identity? nanosecond;
  Identity? timeZoneOffsetSeconds;

  UpdatedAt(
      {this.year,
        this.month,
        this.day,
        this.hour,
        this.minute,
        this.second,
        this.nanosecond,
        this.timeZoneOffsetSeconds});

  UpdatedAt.fromJson(Map<String, dynamic> json) {
    year = json['year'] != null ? new Identity.fromJson(json['year']) : null;
    month = json['month'] != null ? new Identity.fromJson(json['month']) : null;
    day = json['day'] != null ? new Identity.fromJson(json['day']) : null;
    hour = json['hour'] != null ? new Identity.fromJson(json['hour']) : null;
    minute =
    json['minute'] != null ? new Identity.fromJson(json['minute']) : null;
    second =
    json['second'] != null ? new Identity.fromJson(json['second']) : null;
    nanosecond = json['nanosecond'] != null
        ? new Identity.fromJson(json['nanosecond'])
        : null;
    timeZoneOffsetSeconds = json['timeZoneOffsetSeconds'] != null
        ? new Identity.fromJson(json['timeZoneOffsetSeconds'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.year != null) {
      data['year'] = this.year!.toJson();
    }
    if (this.month != null) {
      data['month'] = this.month!.toJson();
    }
    if (this.day != null) {
      data['day'] = this.day!.toJson();
    }
    if (this.hour != null) {
      data['hour'] = this.hour!.toJson();
    }
    if (this.minute != null) {
      data['minute'] = this.minute!.toJson();
    }
    if (this.second != null) {
      data['second'] = this.second!.toJson();
    }
    if (this.nanosecond != null) {
      data['nanosecond'] = this.nanosecond!.toJson();
    }
    if (this.timeZoneOffsetSeconds != null) {
      data['timeZoneOffsetSeconds'] = this.timeZoneOffsetSeconds!.toJson();
    }
    return data;
  }
}
