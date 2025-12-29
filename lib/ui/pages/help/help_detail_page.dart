import 'package:flutter/material.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/models/legacy/help_resp.dart';

class HelpDetailPage extends StatefulWidget {
  const HelpDetailPage({Key? key, required this.helpResp}) : super(key: key);
  final HelpResp helpResp;

  @override
  State<HelpDetailPage> createState() => _HelpDetailPageState();
}

class _HelpDetailPageState extends State<HelpDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.titleHelpDetailPage),
      ),
      backgroundColor: Colors.grey[100]!,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 8.0),
              Center(
                child: Text(
                  widget.helpResp.title ?? "",
                  style: TextStyle(
                    color: R.colors.colorText,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  widget.helpResp.value ?? "",
                  style: TextStyle(
                    color: R.colors.colorText,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
