import 'package:flutter/material.dart';
import 'package:newbkmmobile/core/convert_date.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/models/replacement_part_history_resp.dart';
import 'package:newbkmmobile/ui/widgets/space_between_horizontal_text.dart';

class ReplacementPartHistoryRow extends StatefulWidget {
  const ReplacementPartHistoryRow({Key? key, required this.index, required this.dataReplacementPartHistory}) : super(key: key);
  final int index;
  final DataReplacementPartHistory dataReplacementPartHistory;

  @override
  State<ReplacementPartHistoryRow> createState() => _ReplacementPartHistoryRowState();
}

class _ReplacementPartHistoryRowState extends State<ReplacementPartHistoryRow> {
  final _convertDate = ConvertDate();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            SpaceBetweenHorizontalText(
              title: R.strings.nomor,
              content: "${widget.dataReplacementPartHistory.transactionCode}",
              colorTitle: R.colors.colorText,
              colorContent: R.colors.colorText,
              fontSizeTitle: 14.0,
              fontSizeContent: 14.0,
              fontWeightTitle: FontWeight.normal,
              fontWeightContent: FontWeight.bold,
            ),
            const SizedBox(height: 18.0),
            SpaceBetweenHorizontalText(
              title: R.strings.merkPart,
              content: "${widget.dataReplacementPartHistory.brandName}",
              colorTitle: R.colors.colorText,
              colorContent: R.colors.colorText,
              fontSizeTitle: 14.0,
              fontSizeContent: 14.0,
              fontWeightTitle: FontWeight.normal,
              fontWeightContent: FontWeight.bold,
            ),
            const SizedBox(height: 18.0),
            SpaceBetweenHorizontalText(
              title: R.strings.pemohon,
              content: "${widget.dataReplacementPartHistory.requestBy}",
              colorTitle: R.colors.colorText,
              colorContent: R.colors.colorText,
              fontSizeTitle: 14.0,
              fontSizeContent: 14.0,
              fontWeightTitle: FontWeight.normal,
              fontWeightContent: FontWeight.bold,
            ),
            const SizedBox(height: 18.0),
            SpaceBetweenHorizontalText(
              title: R.strings.tglGanti,
              content: "${_convertDate.convertToddMMMyyyy1(widget.dataReplacementPartHistory.transactionDate!)}",
              colorTitle: R.colors.colorText,
              colorContent: R.colors.colorText,
              fontSizeTitle: 14.0,
              fontSizeContent: 14.0,
              fontWeightTitle: FontWeight.normal,
              fontWeightContent: FontWeight.bold,
            ),
            const SizedBox(height: 18.0),
            SpaceBetweenHorizontalText(
              title: R.strings.umur,
              content: "${widget.dataReplacementPartHistory.days}",
              colorTitle: R.colors.colorText,
              colorContent: R.colors.colorText,
              fontSizeTitle: 14.0,
              fontSizeContent: 14.0,
              fontWeightTitle: FontWeight.normal,
              fontWeightContent: FontWeight.bold,
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
