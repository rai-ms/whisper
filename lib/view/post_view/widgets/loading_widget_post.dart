import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../global/global.dart';
import '../../../utils/app_helper/app_color.dart';

class LoadingPost extends StatelessWidget {
  const LoadingPost({super.key, this.length = 1});
  final int length;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(length, (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
            child: Container(
              height: 500,
              width: getFullWidth(context),
              decoration: BoxDecoration(
                color: AppColors.greyShade,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).canvasColor,
                      blurRadius: 2,
                      spreadRadius: 1),
                ],
              ),
              child: Column(
                children: [
                  sizedBox(hei: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizedBox(wid: 16),
                      const CircleAvatar(radius: 25,backgroundColor: AppColors.grey,),
                      sizedBox(wid: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                            width: 100,
                            decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          sizedBox(hei: 6),
                          Container(
                            height: 20,
                            width: 200,
                            decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: sizedBox()),
                      const Icon(Icons.more_vert, color: AppColors.grey,),
                      sizedBox(wid: 24),
                    ],
                  ),
                  sizedBox(hei: 16),
                  Expanded(
                    child: Row(
                      children: [
                        sizedBox(wid: 18),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        sizedBox(wid: 18),
                      ],
                    ),
                  ),
                  sizedBox(hei: 26),
                  Row(
                    children: [
                      sizedBox(wid: 18),
                      Expanded(
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context).primaryColorDark,
                                    blurRadius: 5,
                                    spreadRadius: 0)
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Icon(FontAwesomeIcons.thumbsUp),
                                  sizedBox(hei: 4),
                                  Container(
                                    height: 10,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: AppColors.grey,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Icon(FontAwesomeIcons.commentDots),
                                  sizedBox(hei: 4),
                                  Container(
                                    height: 10,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: AppColors.grey,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Icon(FontAwesomeIcons.share),
                                  sizedBox(hei: 4),
                                  Container(
                                    height: 10,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: AppColors.grey,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      sizedBox(wid: 18),
                    ],
                  ),
                  sizedBox(hei: 10),
                ],
              ),
            ),
          ),)
        ],
      ),
    );
  }
}
