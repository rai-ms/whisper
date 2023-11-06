import 'package:flutter/material.dart';
import '../global/global.dart';
import '../utils/app_helper/app_color.dart';

class LoadingWidgetTile extends StatelessWidget {
  const LoadingWidgetTile({super.key, this.count = 1, this.width});
  final int count;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(count, (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              const CircleAvatar(radius: 30,backgroundColor: AppColors.greyShade,),
              sizedBox(wid: 4),
              Container(
                width: width ?? getFullWidth(context)*.8,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.greyShade
                ),)
            ],
          ),
        ),)
      ],
    );
  }
}
