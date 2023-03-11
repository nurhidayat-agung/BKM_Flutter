import 'package:flutter/material.dart';
import 'package:newbkmmobile/core/convert_date.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/models/service_book_resp.dart';
import 'package:newbkmmobile/ui/pages/service_book/service_book_detail_page.dart';
import 'package:newbkmmobile/ui/widgets/space_between_horizontal_text.dart';

class ServiceBookRow extends StatefulWidget {
  const ServiceBookRow({Key? key, required this.index, required this.dataServiceBook}) : super(key: key);
  final int index;
  final DataServiceBook dataServiceBook;

  @override
  State<ServiceBookRow> createState() => _ServiceBookRowState();
}

class _ServiceBookRowState extends State<ServiceBookRow> {
  final _convertDate = ConvertDate();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ServiceBookDetailPage(dataServiceBook: widget.dataServiceBook)
        ));
      },
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8.0),
              SpaceBetweenHorizontalText(
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
              SpaceBetweenHorizontalText(
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
              SpaceBetweenHorizontalText(
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
              SpaceBetweenHorizontalText(
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
            ],
          ),
        ),
      ),
    );
  }
}
