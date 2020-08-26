import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingContainer extends StatelessWidget {
  final double boxHeight;
  LoadingContainer({@required this.boxHeight});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white10,
      baseColor: Theme.of(context).primaryColorLight,
      direction: ShimmerDirection.ltr,
      child: Container(
        margin: EdgeInsets.all(10),
        height: boxHeight,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).primaryColorLight,
        ),
      ),
    );
  }
}
