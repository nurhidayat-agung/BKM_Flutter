class UserDetailResp {
  String? userId;
  String? driverId;
  String? fullName;
  String? mobileNumber;
  String? dOB;
  String? address;
  String? bloodType;
  String? profilImg;
  String? activeWorkingDate;
  String? dedication;
  String? numberOfTrip;
  List<Announcement>? announcement;
  Vehicle? vehicle;

  UserDetailResp(
      {this.userId,
        this.driverId,
        this.fullName,
        this.mobileNumber,
        this.dOB,
        this.address,
        this.bloodType,
        this.profilImg,
        this.activeWorkingDate,
        this.dedication,
        this.numberOfTrip,
        this.announcement,
        this.vehicle});

  UserDetailResp.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    driverId = json['driver_id'];
    fullName = json['full_name'];
    mobileNumber = json['mobile_number'];
    dOB = json['DOB'];
    address = json['address'];
    bloodType = json['blood_type'];
    profilImg = json['profil_img'];
    activeWorkingDate = json['active_working_date'];
    dedication = json['dedication'];
    numberOfTrip = json['number_of_trip'];
    if (json['announcement'] != null) {
      announcement = <Announcement>[];
      json['announcement'].forEach((v) {
        announcement!.add(new Announcement.fromJson(v));
      });
    }
    vehicle =
    json['vehicle'] != null ? new Vehicle.fromJson(json['vehicle']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['driver_id'] = this.driverId;
    data['full_name'] = this.fullName;
    data['mobile_number'] = this.mobileNumber;
    data['DOB'] = this.dOB;
    data['address'] = this.address;
    data['blood_type'] = this.bloodType;
    data['profil_img'] = this.profilImg;
    data['active_working_date'] = this.activeWorkingDate;
    data['dedication'] = this.dedication;
    data['number_of_trip'] = this.numberOfTrip;
    if (this.announcement != null) {
      data['announcement'] = this.announcement!.map((v) => v.toJson()).toList();
    }
    if (this.vehicle != null) {
      data['vehicle'] = this.vehicle!.toJson();
    }
    return data;
  }
}

class Announcement {
  String? id;
  String? userId;
  String? startDate;
  String? endDate;
  String? announcement;
  String? fontSize;
  String? fontColor;
  String? backgroundImg;
  String? backgroundColor;
  String? isImg;

  Announcement(
      {this.id,
        this.userId,
        this.startDate,
        this.endDate,
        this.announcement,
        this.fontSize,
        this.fontColor,
        this.backgroundImg,
        this.backgroundColor,
        this.isImg});

  Announcement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    announcement = json['announcement'];
    fontSize = json['font_size'];
    fontColor = json['font_color'];
    backgroundImg = json['background_img'];
    backgroundColor = json['background_color'];
    isImg = json['is_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['announcement'] = this.announcement;
    data['font_size'] = this.fontSize;
    data['font_color'] = this.fontColor;
    data['background_img'] = this.backgroundImg;
    data['background_color'] = this.backgroundColor;
    data['is_img'] = this.isImg;
    return data;
  }
}

class Vehicle {
  String? id;
  String? vehicleNumber;
  String? isAvailable;
  String? repairStatus;
  String? capacity;

  Vehicle(
      {this.id,
        this.vehicleNumber,
        this.isAvailable,
        this.repairStatus,
        this.capacity});

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleNumber = json['vehicle_number'];
    isAvailable = json['is_available'];
    repairStatus = json['repair_status'];
    capacity = json['capacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vehicle_number'] = this.vehicleNumber;
    data['is_available'] = this.isAvailable;
    data['repair_status'] = this.repairStatus;
    data['capacity'] = this.capacity;
    return data;
  }
}