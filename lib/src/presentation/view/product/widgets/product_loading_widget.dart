import 'package:flutter/material.dart';

import '../../../widgets/shimmer_widget.dart';

class ProductLoadingWidget extends StatelessWidget {
  const ProductLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = (screenSize.width - 48) / 2;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShimmerWidget(
            width: width,
            height: 350,
          ),
          ShimmerWidget(
            width: width,
            height: 350,
          ),
        ],
      ),
    );
  }
}