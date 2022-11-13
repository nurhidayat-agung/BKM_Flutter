import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:newbkmmobile/core/convert_date.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/models/history_resp.dart';
import 'package:newbkmmobile/ui/pages/history/history_detail_page.dart';

class HistoryRow extends StatefulWidget {
  const HistoryRow({Key? key, required this.index, required this.history, required this.historyBefore}) : super(key: key);
  final int index;
  final HistoryResp history;
  final HistoryResp historyBefore;

  @override
  State<HistoryRow> createState() => _HistoryRowState();
}

class _HistoryRowState extends State<HistoryRow> {
  final _convertDate = ConvertDate();

  _getAllDoNumber() {
    if (widget.history.doConnect != null) {
      var id1 = int.parse(widget.history.id ?? "0");
      var id2 = int.parse(widget.history.doConnect?.id ?? "0");
      if (id1 > id2) {
        return "${widget.history.doConnect?.doNumber?.substring(0, 4)} & ${widget.history.doNumber!}";
      } else {
        return "${widget.history.doNumber?.substring(0, 4)} & ${widget.history.doConnect?.doNumber!}";
      }
    } else {
        return widget.history.doNumber ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.index == 0 || _convertDate.convertToMMMMyyyy(widget.history.loadDate ?? "") != _convertDate.convertToMMMMyyyy(widget.historyBefore.loadDate ?? "") ? true : false,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                top: 8.0,
                right: 8.0,
                bottom: 2.0,
              ),
              child: Text(
                _convertDate.convertToMMMMyyyy(widget.history.loadDate ?? ""),
                style: TextStyle(
                  color: R.colors.colorText,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      HistoryDetailPage(id: widget.history.id ?? "")
              ));
            },
            child: Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      _getAllDoNumber(),
                      style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      "${_convertDate.convertToddMMMyyyy1(widget.history.loadDate!)} - ${_convertDate.convertToddMMMyyyy1(widget.history.unloadDate!)}",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      children: [
                        Image.asset(
                          R.assets.fastDelivery,
                          scale: 2.5,
                        ),
                        const SizedBox(width: 4.0),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 14.0,
                            ),
                            children: [
                              TextSpan(
                                text: widget.history.pksName,
                                style: TextStyle(
                                  color: R.colors.colorTextLight,
                                ),
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: R.colors.colorTextLight,
                                    size: 16.0,
                                  ),
                                ),
                              ),
                              TextSpan(
                                  text: widget.history.destinationName,
                                  style: TextStyle(
                                    color: R.colors.colorTextLight,
                                  ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
