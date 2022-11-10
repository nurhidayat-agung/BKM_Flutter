import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/models/history_resp.dart';

class HistoryRow extends StatefulWidget {
  const HistoryRow({Key? key, required this.history}) : super(key: key);
  final HistoryResp history;

  @override
  State<HistoryRow> createState() => _HistoryRowState();
}

class _HistoryRowState extends State<HistoryRow> {

  _getFormattedDate(String date) {
    var localDate = DateTime.parse(date).toLocal();
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(localDate.toString());
    var outputFormat = DateFormat('dd MMM yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                widget.history.doNumber!,
                style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                "${_getFormattedDate(widget.history.loadDate!)} - ${_getFormattedDate(widget.history.unloadDate!)}",
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
    );
  }
}
