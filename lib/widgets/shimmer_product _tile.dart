// ignore: file_names
import 'dart:math';

import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

class ShimmerProductTile extends StatelessWidget {
  const ShimmerProductTile({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeShimmer(
      width: double.infinity,
      height: Random().nextInt(100) + 50,
      baseColor: Colors.grey,
      highlightColor: Colors.white70,
    );
  }
}
