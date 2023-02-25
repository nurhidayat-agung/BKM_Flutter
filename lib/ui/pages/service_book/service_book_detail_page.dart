import 'package:flutter/material.dart';
import 'package:newbkmmobile/core/convert_date.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/models/service_book_resp.dart';
import 'package:newbkmmobile/ui/widgets/pair_horizontal_text.dart';

class ServiceBookDetailPage extends StatefulWidget {
  const ServiceBookDetailPage({Key? key, required this.dataServiceBook}) : super(key: key);
  final DataServiceBook dataServiceBook;

  @override
  State<ServiceBookDetailPage> createState() => _ServiceBookDetailPageState();
}

class _ServiceBookDetailPageState extends State<ServiceBookDetailPage> {
  final _convertDate = ConvertDate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.titleServiceBookDetailPage),
      ),
      backgroundColor: Colors.grey[100]!,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 8.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8.0),
              PairHorizontalText(
                title: R.strings.tglServis,
                content: "${_convertDate.convertToddMMMyyyy1(widget.dataServiceBook.serviceDate!)}",
                colorTitle: R.colors.colorText,
                colorContent: R.colors.colorText,
                fontSizeTitle: 14.0,
                fontSizeContent: 14.0,
                fontWeightTitle: FontWeight.normal,
                fontWeightContent: FontWeight.bold,
              ),
              const SizedBox(height: 18.0),
              PairHorizontalText(
                title: R.strings.kmServis,
                content: "${widget.dataServiceBook.km}",
                colorTitle: R.colors.colorText,
                colorContent: R.colors.colorText,
                fontSizeTitle: 14.0,
                fontSizeContent: 14.0,
                fontWeightTitle: FontWeight.normal,
                fontWeightContent: FontWeight.bold,
              ),
              const SizedBox(height: 18.0),
              PairHorizontalText(
                title: R.strings.aktualKmServis,
                content: "${widget.dataServiceBook.actualKm}",
                colorTitle: R.colors.colorText,
                colorContent: R.colors.colorText,
                fontSizeTitle: 14.0,
                fontSizeContent: 14.0,
                fontWeightTitle: FontWeight.normal,
                fontWeightContent: FontWeight.bold,
              ),
              const SizedBox(height: 18.0),
              PairHorizontalText(
                title: R.strings.keterangan,
                content: "${widget.dataServiceBook.description}",
                colorTitle: R.colors.colorText,
                colorContent: R.colors.colorText,
                fontSizeTitle: 14.0,
                fontSizeContent: 14.0,
                fontWeightTitle: FontWeight.normal,
                fontWeightContent: FontWeight.bold,
              ),
              const SizedBox(height: 8.0),
              Container(
                color: Colors.grey[300],
                height: 1.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
