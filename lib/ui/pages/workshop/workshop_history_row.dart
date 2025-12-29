import 'package:flutter/material.dart';
import 'package:newbkmmobile/core/convert_date.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/models/legacy/history_workshop_resp.dart';
import 'package:newbkmmobile/ui/widgets/align_start_horizontal_text.dart';

class WorkshopHistoryRow extends StatefulWidget {
  const WorkshopHistoryRow({Key? key, required this.dataHistoryWorkshop}) : super(key: key);
  final DataHistoryWorkshop dataHistoryWorkshop;

  @override
  State<WorkshopHistoryRow> createState() => _WorkshopHistoryRowState();
}

class _WorkshopHistoryRowState extends State<WorkshopHistoryRow> {
  final _convertDate = ConvertDate();

  getListPart() {
    var remarkPart = "";
    var listSparepart = widget.dataHistoryWorkshop.listSparepart;
    if (listSparepart!.isNotEmpty) {
      for (var i = 0; i < listSparepart.length; i++) {
        remarkPart += "${listSparepart[i].itemName} - ${listSparepart[i].qty} ${listSparepart[i].unitName}\n";
      }
    }

    return remarkPart;
  }

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
              content: widget.dataHistoryWorkshop.code ?? "",
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
              content: "${_convertDate.convertToddMMMyyyy1(widget.dataHistoryWorkshop.registerAt!)}",
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
              title: R.strings.tglMasuk,
              content: widget.dataHistoryWorkshop.checkin ?? "",
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
              title: R.strings.tglMasuk,
              content: widget.dataHistoryWorkshop.checkout ?? "",
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
              content: widget.dataHistoryWorkshop.reason ?? "",
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
              title: R.strings.deskripsi,
              content: widget.dataHistoryWorkshop.description ?? "",
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
              content: widget.dataHistoryWorkshop.statusDesc ?? "",
              colorTitle: R.colors.colorText,
              colorContent: Colors.white,
              fontSizeTitle: 14.0,
              fontSizeContent: 14.0,
              fontWeightTitle: FontWeight.normal,
              fontWeightContent: FontWeight.bold,
              colorBackgroundContent: widget.dataHistoryWorkshop.statusColor ?? Colors.transparent,
            ),
            const SizedBox(height: 18.0),
            AlignStartHorizontalText(
              title: R.strings.daftarBarang,
              content: getListPart(),
              colorTitle: R.colors.colorText,
              colorContent: R.colors.colorText,
              fontSizeTitle: 14.0,
              fontSizeContent: 14.0,
              fontWeightTitle: FontWeight.normal,
              fontWeightContent: FontWeight.bold,
              colorBackgroundContent: Colors.transparent,
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
