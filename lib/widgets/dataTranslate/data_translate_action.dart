import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';

class DataTranslateAction extends StatelessWidget {
  final bool isEnableText;
  final bool isEnableAudio;
  final VoidCallback textFunction;
  final VoidCallback audioFunction;
  const DataTranslateAction({
    super.key,
    required this.isEnableAudio,
    required this.isEnableText,
    required this.textFunction,
    required this.audioFunction,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: textFunction,
          child: Container(
            height: 75,
            width: (width / 10) * 4,
            decoration: BoxDecoration(
              color: isEnableText ? kBlue : kWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: kBlue,
                width: 3,
              ),
            ),
            child: Center(
              child: Icon(
                CupertinoIcons.pencil_ellipsis_rectangle,
                size: 50,
                color: isEnableText ? kWhite : kBlue,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: audioFunction,
          child: Container(
            height: 75,
            width: (width / 10) * 4,
            decoration: BoxDecoration(
              color: isEnableAudio ? kBlue : kWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: kBlue,
                width: 3,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.mic,
                size: 50,
                color: isEnableAudio ? kWhite : kBlue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
