// import 'package:newbkmmobile/models/user_detail_local.dart';
// import 'package:newbkmmobile/models/announcement_local.dart';
// import 'package:newbkmmobile/models/vehicle_local.dart';
//
// class UserDetailResp {
//   String? userId;
//   String? driverId;
//   String? fullName;
//   String? mobileNumber;
//   String? dOB;
//   String? address;
//   String? bloodType;
//   String? profilImg;
//   String? activeWorkingDate;
//   String? dedication;
//   String? numberOfTrip;
//   List<AnnouncementLocal>? announcement;
//   VehicleLocal? vehicle;
//
//   UserDetailResp({
//     this.userId,
//     this.driverId,
//     this.fullName,
//     this.mobileNumber,
//     this.dOB,
//     this.address,
//     this.bloodType,
//     this.profilImg,
//     this.activeWorkingDate,
//     this.dedication,
//     this.numberOfTrip,
//     this.announcement,
//     this.vehicle,
//   });
//
//   UserDetailResp.fromJson(Map<String, dynamic> json) {
//     userId = json['user_id']?.toString();
//     driverId = json['driver_id']?.toString();
//     fullName = json['full_name'] ?? '';
//     mobileNumber = json['mobile_number'] ?? '';
//     dOB = json['dob'] ?? '';
//     address = json['address'] ?? '';
//     bloodType = json['blood_type'] ?? '';
//     profilImg = json['profil_img'] ?? '';
//     activeWorkingDate = json['active_working_date'] ?? '';
//     dedication = json['dedication'] ?? '';
//     numberOfTrip = json['number_of_trip']?.toString() ?? '0';
//     announcement = [];
//     vehicle = VehicleLocal.empty(); // nanti kita buat VehicleLocal.empty()
//   }
//
//   Map<String, dynamic> toJson() => {
//     'user_id': userId,
//     'driver_id': driverId,
//     'full_name': fullName,
//     'mobile_number': mobileNumber,
//     'dob': dOB,
//     'address': address,
//     'blood_type': bloodType,
//     'profil_img': profilImg,
//     'active_working_date': activeWorkingDate,
//     'dedication': dedication,
//     'number_of_trip': numberOfTrip,
//   };
//
//   // ✅ untuk simpan lokal
//   UserDetailLocal toLocal() {
//     return UserDetailLocal(
//       userId: userId ?? '',
//       driverId: driverId ?? '',
//       fullName: fullName ?? '',
//       mobileNumber: mobileNumber ?? '',
//       dOB: dOB ?? '',
//       address: address ?? '',
//       bloodType: bloodType ?? '',
//       profilImg: profilImg ?? '',
//       activeWorkingDate: activeWorkingDate ?? '',
//       dedication: dedication ?? '',
//       numberOfTrip: numberOfTrip ?? '0',
//       announcement: announcement ?? [],
//       vehicle: vehicle ?? VehicleLocal.empty(),
//     );
//   }
// }

// import 'package:newbkmmobile/models/announcement_local.dart';
// import 'package:newbkmmobile/models/user_detail_local.dart';
// import 'package:newbkmmobile/models/vehicle_local.dart';
//
// class UserDetailResp {
//   String? userId;
//   String? driverId;
//   String? fullName;
//   String? mobileNumber;
//   String? dOB;
//   String? address;
//   String? bloodType;
//   String? profilImg;
//   String? activeWorkingDate;
//   String? dedication;
//   String? numberOfTrip;
//   List<Announcement>? announcement;
//   Vehicle? vehicle;
//
//   UserDetailResp(
//       {this.userId,
//         this.driverId,
//         this.fullName,
//         this.mobileNumber,
//         this.dOB,
//         this.address,
//         this.bloodType,
//         this.profilImg,
//         this.activeWorkingDate,
//         this.dedication,
//         this.numberOfTrip,
//         this.announcement,
//         this.vehicle});
//
//   UserDetailResp.fromJson(Map<String, dynamic> json) {
//     userId = json['user_id'];
//     driverId = json['driver_id'];
//     fullName = json['full_name'];
//     mobileNumber = json['mobile_number'];
//     dOB = json['DOB'];
//     address = json['address'];
//     bloodType = json['blood_type'];
//     profilImg = json['profil_img'];
//     activeWorkingDate = json['active_working_date'];
//     dedication = json['dedication'];
//     numberOfTrip = json['number_of_trip'];
//     if (json['announcement'] != null) {
//       announcement = <Announcement>[];
//       json['announcement'].forEach((v) {
//         announcement!.add(new Announcement.fromJson(v));
//       });
//     }
//     vehicle =
//     json['vehicle'] != null ? new Vehicle.fromJson(json['vehicle']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['user_id'] = this.userId;
//     data['driver_id'] = this.driverId;
//     data['full_name'] = this.fullName;
//     data['mobile_number'] = this.mobileNumber;
//     data['DOB'] = this.dOB;
//     data['address'] = this.address;
//     data['blood_type'] = this.bloodType;
//     data['profil_img'] = this.profilImg;
//     data['active_working_date'] = this.activeWorkingDate;
//     data['dedication'] = this.dedication;
//     data['number_of_trip'] = this.numberOfTrip;
//     if (this.announcement != null) {
//       data['announcement'] = this.announcement!.map((v) => v.toJson()).toList();
//     }
//     if (this.vehicle != null) {
//       data['vehicle'] = this.vehicle!.toJson();
//     }
//     return data;
//   }
//
//
//
//   UserDetailLocal toLocal() {
//     return UserDetailLocal(
//       userId: userId ?? "",
//       driverId: driverId ?? "",
//       fullName: fullName ?? "",
//       mobileNumber: mobileNumber ?? "",
//       dOB: dOB ?? "",
//       address: address ?? "",
//       bloodType: bloodType ?? "",
//       profilImg: profilImg ?? "",
//       activeWorkingDate: activeWorkingDate ?? "",
//       dedication: dedication ?? "",
//       numberOfTrip: numberOfTrip ?? "",
//       announcement: announcement!.map((data) => data.toLocal()).toList(),
//       vehicle: vehicle!.toLocal(),
//     );
//   }
// }
//
// class Announcement {
//   String? id;
//   String? userId;
//   String? startDate;
//   String? endDate;
//   String? announcement;
//   String? fontSize;
//   String? fontColor;
//   String? backgroundImg;
//   String? backgroundColor;
//   String? isImg;
//
//   Announcement(
//       {this.id,
//         this.userId,
//         this.startDate,
//         this.endDate,
//         this.announcement,
//         this.fontSize,
//         this.fontColor,
//         this.backgroundImg,
//         this.backgroundColor,
//         this.isImg});
//
//   Announcement.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     startDate = json['start_date'];
//     endDate = json['end_date'];
//     announcement = json['announcement'];
//     fontSize = json['font_size'];
//     fontColor = json['font_color'];
//     backgroundImg = json['background_img'];
//     backgroundColor = json['background_color'];
//     isImg = json['is_img'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['start_date'] = this.startDate;
//     data['end_date'] = this.endDate;
//     data['announcement'] = this.announcement;
//     data['font_size'] = this.fontSize;
//     data['font_color'] = this.fontColor;
//     data['background_img'] = this.backgroundImg;
//     data['background_color'] = this.backgroundColor;
//     data['is_img'] = this.isImg;
//     return data;
//   }
//
//   AnnouncementLocal toLocal() {
//     return AnnouncementLocal(
//       id: id ?? "",
//       userId: userId ?? "",
//       startDate: startDate ?? "",
//       endDate: endDate ?? "",
//       announcement: announcement ?? "",
//       fontSize: fontSize ?? "",
//       fontColor: fontColor ?? "",
//       backgroundImg: backgroundImg ?? "",
//       backgroundColor: backgroundColor ?? "",
//       isImg: isImg ?? "",
//     );
//   }
// }
//
// class Vehicle {
//   String? id;
//   String? vehicleNumber;
//   String? isAvailable;
//   String? repairStatus;
//   String? capacity;
//
//   Vehicle(
//       {this.id,
//         this.vehicleNumber,
//         this.isAvailable,
//         this.repairStatus,
//         this.capacity});
//
//   Vehicle.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     vehicleNumber = json['vehicle_number'];
//     isAvailable = json['is_available'];
//     repairStatus = json['repair_status'];
//     capacity = json['capacity'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['vehicle_number'] = this.vehicleNumber;
//     data['is_available'] = this.isAvailable;
//     data['repair_status'] = this.repairStatus;
//     data['capacity'] = this.capacity;
//     return data;
//   }
//
//   VehicleLocal toLocal() {
//     return VehicleLocal(
//       id: id ?? "",
//       vehicleNumber: vehicleNumber ?? "",
//       isAvailable: isAvailable ?? "",
//       repairStatus: repairStatus ?? "",
//       capacity: capacity ?? "",
//     );
//   }
// }

import 'package:newbkmmobile/models/legacy/announcement_local.dart';
import 'package:newbkmmobile/models/legacy/user_detail_local.dart';
import 'package:newbkmmobile/models/legacy/vehicle_local.dart';

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

  UserDetailResp({
    this.userId,
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
    this.vehicle,
  });

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
        announcement!.add(Announcement.fromJson(v));
      });
    }

    vehicle = json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['user_id'] = userId;
    data['driver_id'] = driverId;
    data['full_name'] = fullName;
    data['mobile_number'] = mobileNumber;
    data['DOB'] = dOB;
    data['address'] = address;
    data['blood_type'] = bloodType;
    data['profil_img'] = profilImg;
    data['active_working_date'] = activeWorkingDate;
    data['dedication'] = dedication;
    data['number_of_trip'] = numberOfTrip;

    if (announcement != null) {
      data['announcement'] = announcement!.map((v) => v.toJson()).toList();
    }
    if (vehicle != null) {
      data['vehicle'] = vehicle!.toJson();
    }
    return data;
  }

  /// ✅ Aman dari null dan siap dipakai untuk penyimpanan lokal
  UserDetailLocal toLocal() {
    return UserDetailLocal(
      userId: userId ?? "",
      driverId: driverId ?? "",
      fullName: fullName ?? "User Offline",
      mobileNumber: mobileNumber ?? "-",
      dOB: dOB ?? "",
      address: address ?? "",
      bloodType: bloodType ?? "",
      profilImg: profilImg ?? "",
      activeWorkingDate: activeWorkingDate ?? "",
      dedication: dedication ?? "-",
      numberOfTrip: numberOfTrip ?? "0",
      announcement: (announcement ?? [])
          .map((data) => data.toLocal())
          .toList(),
      vehicle: vehicle?.toLocal() ??
          VehicleLocal(
            id: "",
            vehicleNumber: "",
            isAvailable: "",
            repairStatus: "",
            capacity: "",
          ),
    );
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

  Announcement({
    this.id,
    this.userId,
    this.startDate,
    this.endDate,
    this.announcement,
    this.fontSize,
    this.fontColor,
    this.backgroundImg,
    this.backgroundColor,
    this.isImg,
  });

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
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_id'] = userId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['announcement'] = announcement;
    data['font_size'] = fontSize;
    data['font_color'] = fontColor;
    data['background_img'] = backgroundImg;
    data['background_color'] = backgroundColor;
    data['is_img'] = isImg;
    return data;
  }

  AnnouncementLocal toLocal() {
    return AnnouncementLocal(
      id: id ?? "",
      userId: userId ?? "",
      startDate: startDate ?? "",
      endDate: endDate ?? "",
      announcement: announcement ?? "",
      fontSize: fontSize ?? "",
      fontColor: fontColor ?? "",
      backgroundImg: backgroundImg ?? "",
      backgroundColor: backgroundColor ?? "",
      isImg: isImg ?? "",
    );
  }
}

class Vehicle {
  String? id;
  String? vehicleNumber;
  String? isAvailable;
  String? repairStatus;
  String? capacity;

  Vehicle({
    this.id,
    this.vehicleNumber,
    this.isAvailable,
    this.repairStatus,
    this.capacity,
  });

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleNumber = json['vehicle_number'];
    isAvailable = json['is_available'];
    repairStatus = json['repair_status'];
    capacity = json['capacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['vehicle_number'] = vehicleNumber;
    data['is_available'] = isAvailable;
    data['repair_status'] = repairStatus;
    data['capacity'] = capacity;
    return data;
  }

  VehicleLocal toLocal() {
    return VehicleLocal(
      id: id ?? "",
      vehicleNumber: vehicleNumber ?? "",
      isAvailable: isAvailable ?? "",
      repairStatus: repairStatus ?? "",
      capacity: capacity ?? "",
    );
  }
}
