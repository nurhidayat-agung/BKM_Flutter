class TripResponse {
  bool? status;
  String? message;
  int? statusCode;
  TripData? data;

  TripResponse({
    this.status,
    this.message,
    this.statusCode,
    this.data,
  });

  factory TripResponse.fromJson(Map<String, dynamic> json) {
    return TripResponse(
      status: json['status'],
      message: json['message'],
      statusCode: json['status_code'],
      data: json['data'] != null ? TripData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "status_code": statusCode,
      "data": data?.toJson(),
    };
  }
}

class TripData {
  String? tripId;
  Order? order;
  List<OrderDetail>? orderDetail;
  Shipment? shipment;
  Payment? payment;

  TripData({
    this.tripId,
    this.order,
    this.orderDetail,
    this.shipment,
    this.payment,
  });

  factory TripData.fromJson(Map<String, dynamic> json) {
    return TripData(
      tripId: json['trip_id'],
      order: json['order'] != null ? Order.fromJson(json['order']) : null,
      orderDetail: json['order_detail'] != null
          ? List<OrderDetail>.from(
        json['order_detail'].map((x) => OrderDetail.fromJson(x)),
      )
          : null,
      shipment: json['shipment'] != null
          ? Shipment.fromJson(json['shipment'])
          : null,
      payment:
      json['payment'] != null ? Payment.fromJson(json['payment']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "trip_id": tripId,
      "order": order?.toJson(),
      "order_detail": orderDetail?.map((x) => x.toJson()).toList(),
      "shipment": shipment?.toJson(),
      "payment": payment?.toJson(),
    };
  }
}

class Order {
  String? orderId;
  String? customerId;
  String? requestDate;
  String? dueDate;
  String? recipientName;
  String? recipientPic;
  String? recipientContact;
  String? recipientNpwp;
  String? picCustomer;
  String? picContact;
  String? picJabatan;
  String? recipientAddress;
  String? recipientNote;

  Order({
    this.orderId,
    this.customerId,
    this.requestDate,
    this.dueDate,
    this.recipientName,
    this.recipientPic,
    this.recipientContact,
    this.recipientNpwp,
    this.picCustomer,
    this.picContact,
    this.picJabatan,
    this.recipientAddress,
    this.recipientNote,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['order_id'],
      customerId: json['customer_id'],
      requestDate: json['request_date'],
      dueDate: json['due_date'],
      recipientName: json['recipient_name'],
      recipientPic: json['recipient_pic'],
      recipientContact: json['recipient_contact'],
      recipientNpwp: json['recipient_npwp'],
      picCustomer: json['pic_customer'],
      picContact: json['pic_contact'],
      picJabatan: json['pic_jabatan'],
      recipientAddress: json['recipient_address'],
      recipientNote: json['recipient_note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "order_id": orderId,
      "customer_id": customerId,
      "request_date": requestDate,
      "due_date": dueDate,
      "recipient_name": recipientName,
      "recipient_pic": recipientPic,
      "recipient_contact": recipientContact,
      "recipient_npwp": recipientNpwp,
      "pic_customer": picCustomer,
      "pic_contact": picContact,
      "pic_jabatan": picJabatan,
      "recipient_address": recipientAddress,
      "recipient_note": recipientNote,
    };
  }
}

class OrderDetail {
  int? orderDetailId;
  String? itemId;
  int? quantity;
  int? itemPrice;
  int? discount;
  int? totalItem;
  Item? item;

  OrderDetail({
    this.orderDetailId,
    this.itemId,
    this.quantity,
    this.itemPrice,
    this.discount,
    this.totalItem,
    this.item,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      orderDetailId: json['order_detail_id'],
      itemId: json['item_id'],
      quantity: json['quantity'],
      itemPrice: json['item_price'],
      discount: json['discount'],
      totalItem: json['total_item'],
      item: json['item'] != null ? Item.fromJson(json['item']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "order_detail_id": orderDetailId,
      "item_id": itemId,
      "quantity": quantity,
      "item_price": itemPrice,
      "discount": discount,
      "total_item": totalItem,
      "item": item?.toJson(),
    };
  }
}

class Item {
  String? id;
  String? itemName;
  String? unitName;

  Item({
    this.id,
    this.itemName,
    this.unitName,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      itemName: json['item_name'],
      unitName: json['unit_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "item_name": itemName,
      "unit_name": unitName,
    };
  }
}

class Shipment {
  String? shipmentId;
  String? driver;
  String? adminProject;
  String? startTime;
  String? endTime;
  String? kodeUnik;
  int? totalAmount;
  String? vehicle;

  Shipment({
    this.shipmentId,
    this.driver,
    this.adminProject,
    this.startTime,
    this.endTime,
    this.kodeUnik,
    this.totalAmount,
    this.vehicle,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      shipmentId: json['shipment_id'],
      driver: json['driver'],
      adminProject: json['admin_project'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      kodeUnik: json['kode_unik'],
      totalAmount: json['total_amount'],
      vehicle: json['vehicle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "shipment_id": shipmentId,
      "driver": driver,
      "admin_project": adminProject,
      "start_time": startTime,
      "end_time": endTime,
      "kode_unik": kodeUnik,
      "total_amount": totalAmount,
      "vehicle": vehicle,
    };
  }
}

class Payment {
  String? adminProject;
  String? adminDriver;
  int? bayar;

  Payment({
    this.adminProject,
    this.adminDriver,
    this.bayar,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      adminProject: json['admin_project'],
      adminDriver: json['admin_driver'],
      bayar: json['bayar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "admin_project": adminProject,
      "admin_driver": adminDriver,
      "bayar": bayar,
    };
  }
}
