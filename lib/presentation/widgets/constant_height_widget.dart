import 'package:flutter/material.dart';

class KHeight extends StatelessWidget {
  final double size;

  const KHeight({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * size,
    );
  }
}
