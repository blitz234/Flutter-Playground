import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:study_app/configs/themes/ui_parameter.dart';

class QuestionScreenHolder extends StatelessWidget {
  const QuestionScreenHolder({super.key});

  @override
  Widget build(BuildContext context) {
    var line = Container(
      width: double.infinity,
      height: 12.0,
      color: Theme.of(context).scaffoldBackgroundColor,
    );

    var answer = Container(
      width: double.infinity,
      height: 50.0,
      color: Theme.of(context).scaffoldBackgroundColor,
    );

    return Padding(
      padding: UIParameters.mobileScreenPadding,
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.blueGrey.withOpacity(0.5),
        child: EasySeparatedColumn(
            separatorBuilder: ((context, index) => const SizedBox(
                  height: 20,
                )),
            children: [
              EasySeparatedColumn(
                  children: [line, line, line, line],
                  separatorBuilder: ((context, index) => const SizedBox(
                        height: 10,
                      ))),
              answer,
              answer,
              answer
            ]),
      ),
    );
  }
}
