import 'package:flutter/material.dart';
import 'package:newbkmmobile/models/trip/delivery_response.dart';
import 'package:newbkmmobile/models/trip/trip_detail_response.dart';

class InfoCard extends StatelessWidget {
  final TripDetail detail;
  final DeliveryData deliveryData;

  const InfoCard({
    super.key,
    required this.detail,
    required this.deliveryData,
  });

  @override
  Widget build(BuildContext context) {
    final origin = deliveryData.deliveryOrder?.pksId ?? "-";
    final destination = deliveryData.deliveryOrder?.destinationId ?? "-";
    final commodity = deliveryData.deliveryOrder?.commodityId ?? "-";
    final doBesar = deliveryData.deliveryOrder?.doNumber ?? "-";
    final doDate = deliveryData.deliveryOrder?.doDate ?? "-";
    final doKecil = deliveryData.linkedDetail?.deliveryOrder?.doNumber ?? "-";
    final supir = detail.driver?.name ?? "-";
    final kendaraan = detail.vehicle?.policeNumber ?? "-";

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 18, 16, 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$origin → $destination",
            style: const TextStyle(
              color: Color(0xFFD35400),
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 4),
          Text(
            "$origin → $destination",
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),

          const SizedBox(height: 12),
          const Text("Kommodity", style: TextStyle(fontSize: 13)),
          Text(
            commodity,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0B3B54),
            ),
          ),

          const SizedBox(height: 12),

          const Text("No DO Besar", style: TextStyle(fontSize: 13)),
          const SizedBox(height: 4),
          Text(doBesar,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
          Text(doDate, style: const TextStyle(color: Colors.black54)),

          const Divider(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("No DO Kecil",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              Text(doKecil,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Nama Supir",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              Text(supir,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("No Kendaraan",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              Text(kendaraan,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
