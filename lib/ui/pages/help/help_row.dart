import 'package:flutter/material.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/models/help_resp.dart';
import 'package:newbkmmobile/ui/pages/help/help_detail_page.dart';

class HelpRow extends StatefulWidget {
  const HelpRow({Key? key, required this.index, required this.helpResp}) : super(key: key);
  final int index;
  final HelpResp helpResp;

  @override
  State<HelpRow> createState() => _HelpRowState();
}

class _HelpRowState extends State<HelpRow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                HelpDetailPage(helpResp: widget.helpResp)
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Card(
          elevation: 0.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.helpResp.title ?? "",
                  style: TextStyle(
                    color: R.colors.colorText,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
