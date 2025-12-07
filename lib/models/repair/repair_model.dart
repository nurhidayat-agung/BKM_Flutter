import 'package:flutter/material.dart';

class RepairModel {
  final String id;
  final String urgencyTitle;
  final String date;
  final String repairType;
  final String lastKm;
  final String status;
  final Color statusColor;
  final String description;

  RepairModel({
    required this.id,
    required this.urgencyTitle,
    required this.date,
    required this.repairType,
    required this.lastKm,
    required this.status,
    required this.statusColor,
    required this.description,
  });
}