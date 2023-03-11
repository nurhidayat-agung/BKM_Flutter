import 'package:flutter/material.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/models/history_waiting_list_resp.dart';
import 'package:newbkmmobile/ui/widgets/align_start_horizontal_text.dart';

class WorkshopWaitingListRow extends StatefulWidget {
  const WorkshopWaitingListRow({Key? key, required this.dataHistoryWaitingList}) : super(key: key);
  final DataHistoryWaitingList dataHistoryWaitingList;

  @override
  State<WorkshopWaitingListRow> createState() => _WorkshopWaitingListRowState();
}

class _WorkshopWaitingListRowState extends State<WorkshopWaitingListRow> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 8.0),
            AlignStartHorizontalText(
              title: R.strings.kodePend,
              content: widget.dataHistoryWaitingList.code ?? "",
              colorTitle: R.colors.colorText,
              colorContent: R.colors.colorText,
              fontSizeTitle: 14.0,
              fontSizeContent: 14.0,
              fontWeightTitle: FontWeight.normal,
              fontWeightContent: FontWeight.bold,
              colorBackgroundContent: Colors.transparent,
            ),
            const SizedBox(height: 18.0),
            AlignStartHorizontalText(
              title: R.strings.namaDriver,
              content: widget.dataHistoryWaitingList.driver?.driverName ?? "",
              colorTitle: R.colors.colorText,
              colorContent: R.colors.colorText,
              fontSizeTitle: 14.0,
              fontSizeContent: 14.0,
              fontWeightTitle: FontWeight.normal,
              fontWeightContent: FontWeight.bold,
              colorBackgroundContent: Colors.transparent,
            ),
            const SizedBox(height: 18.0),
            AlignStartHorizontalText(
              title: R.strings.noPol,
              content: widget.dataHistoryWaitingList.vehicle?.vehicleNumber ?? "",
              colorTitle: R.colors.colorText,
              colorContent: R.colors.colorText,
              fontSizeTitle: 14.0,
              fontSizeContent: 14.0,
              fontWeightTitle: FontWeight.normal,
              fontWeightContent: FontWeight.bold,
              colorBackgroundContent: Colors.transparent,
            ),
            const SizedBox(height: 18.0),
            AlignStartHorizontalText(
              title: R.strings.tglPend,
              content: widget.dataHistoryWaitingList.registerAt ?? "",
              colorTitle: R.colors.colorText,
              colorContent: R.colors.colorText,
              fontSizeTitle: 14.0,
              fontSizeContent: 14.0,
              fontWeightTitle: FontWeight.normal,
              fontWeightContent: FontWeight.bold,
              colorBackgroundContent: Colors.transparent,
            ),
            const SizedBox(height: 18.0),
            AlignStartHorizontalText(
              title: R.strings.kendala,
              content: widget.dataHistoryWaitingList.reason ?? "",
              colorTitle: R.colors.colorText,
              colorContent: R.colors.colorText,
              fontSizeTitle: 14.0,
              fontSizeContent: 14.0,
              fontWeightTitle: FontWeight.normal,
              fontWeightContent: FontWeight.bold,
              colorBackgroundContent: Colors.transparent,
            ),
            const SizedBox(height: 18.0),
            AlignStartHorizontalText(
              title: R.strings.status,
              content: widget.dataHistoryWaitingList.statusDesc ?? "",
              colorTitle: R.colors.colorText,
              colorContent: Colors.white,
              fontSizeTitle: 14.0,
              fontSizeContent: 14.0,
              fontWeightTitle: FontWeight.normal,
              fontWeightContent: FontWeight.bold,
              colorBackgroundContent: widget.dataHistoryWaitingList.statusColor ?? Colors.transparent,
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
