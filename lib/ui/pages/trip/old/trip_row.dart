import 'package:flutter/material.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/models/trip_resp.dart';

class TripRow extends StatefulWidget {
  const TripRow({Key? key, required this.tripResp}) : super(key: key);
  final TripResp tripResp;

  @override
  State<TripRow> createState() => _TripRowState();
}

class _TripRowState extends State<TripRow> {
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
                widget.tripResp.doNumber!,
                style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 16.0,
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
                          text: widget.tripResp.pksName,
                          style: TextStyle(
                            color: R.colors.colorTextLight,
                          ),
                        ),
                        WidgetSpan(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Icon(
                              Icons.arrow_forward,
                              color: R.colors.colorTextLight,
                              size: 16.0,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: "${widget.tripResp.destinationName} | ${widget.tripResp.commodityName}",
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
