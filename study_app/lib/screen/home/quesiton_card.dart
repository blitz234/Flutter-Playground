import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/configs/themes/app_icons.dart';
import 'package:study_app/configs/themes/custom_text_styles.dart';
import 'package:study_app/configs/themes/ui_parameter.dart';
import 'package:study_app/controllers/question_paper/question_paper_controller.dart';
import 'package:study_app/models/question_paper_model.dart';
import 'package:study_app/widgets/app_icon_text.dart';

class QuestionCard extends GetView<QuestionPaperController> {
  const QuestionCard({super.key, required this.model});

  final QuestionPaperModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: Theme.of(context).cardColor),
      child: InkWell(
        onTap: () {
          controller.navigateToQuestions(paper: model);
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ColoredBox(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      child: SizedBox(
                        height: Get.width * 0.15,
                        width: Get.width * 0.15,
                        child: (model.imageUrl == "")
                            ? const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: CircularProgressIndicator(),
                              )
                            : CachedNetworkImage(
                                placeholder: ((context, url) {
                                  return Container(
                                    alignment: Alignment.center,
                                    child: const CircularProgressIndicator(),
                                  );
                                }),
                                imageUrl: model.imageUrl!,
                                errorWidget: ((context, url, error) {
                                  return Image.asset(
                                      "assets/images/app_splash_logo.png");
                                })),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${model.title}',
                          style: cardTitles(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 15),
                          child: Text(model.description.toString()),
                        ),
                        Row(children: [
                          AppIconText(
                              icon: Icon(
                                Icons.help_outline_sharp,
                                color: UIParameters.isDarkMode(context)
                                    ? Colors.white
                                    : Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.8),
                              ),
                              text: Text(
                                '${model.questionCount} questions',
                                style: detailText.copyWith(
                                    color: UIParameters.isDarkMode(context)
                                        ? Colors.white
                                        : Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w700),
                              )),
                          const SizedBox(
                            width: 15,
                          ),
                          AppIconText(
                              icon: Icon(
                                Icons.timer,
                                color: UIParameters.isDarkMode(context)
                                    ? Colors.white
                                    : Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.8),
                              ),
                              text: Text(
                                model.timeInMinutes(),
                                style: detailText.copyWith(
                                    color: UIParameters.isDarkMode(context)
                                        ? Colors.white
                                        : Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w700),
                              ))
                        ])
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                  bottom: -10.0,
                  right: -10.0,
                  child: GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(cardBorderRadius),
                              bottomRight: Radius.circular(cardBorderRadius))),
                      child: const Icon(AppIcons.trophyOutline),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
