import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';

class LoadingSpinner extends StatelessWidget {
  final double size;
  final Color color;
  const LoadingSpinner({
    super.key,
    this.size = 75,
    this.color = kBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: SpinKitCircle(
          size: size,
          color: color,
        ),
      ),
    );
  }
}
