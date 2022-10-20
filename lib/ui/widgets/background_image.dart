import 'package:flutter/material.dart';
import 'package:newbkmmobile/core/r.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(R.assets.bgLogin),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
