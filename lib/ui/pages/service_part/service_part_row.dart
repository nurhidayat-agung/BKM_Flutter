import 'package:flutter/material.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/models/service_part_resp.dart';
import 'package:newbkmmobile/ui/pages/service_part/replacement_part_history_page.dart';

class ServicePartRow extends StatefulWidget {
  const ServicePartRow({Key? key, required this.index, required this.dataServicePart}) : super(key: key);
  final int index;
  final DataServicePart dataServicePart;

  @override
  State<ServicePartRow> createState() => _ServicePartRowState();
}

class _ServicePartRowState extends State<ServicePartRow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ReplacementPartHistoryPage(dataServicePart: widget.dataServicePart)
        ));
      },
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.dataServicePart.itemName ?? "",
                style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                widget.dataServicePart.itemCode ?? "",
                style: TextStyle(
                  color: R.colors.colorTextLight,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
