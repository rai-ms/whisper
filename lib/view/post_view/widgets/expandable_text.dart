import 'package:flutter/material.dart';
import 'package:whisper/utils/app_helper/app_style.dart';

class ExpandableText extends StatefulWidget {
  ExpandableText({super.key, required this.text, this.isExpanded = false});
  final String text;
  bool isExpanded;

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      InkWell(
        onTap: () {
          widget.isExpanded = !widget.isExpanded;
          setState(() {});
        },
        child: AnimatedSize(
            duration: const Duration(milliseconds: 50),
            child: ConstrainedBox(
                constraints: widget.isExpanded
                    ? const BoxConstraints()
                    : const BoxConstraints(maxHeight: 30.0),
                child: Text(
                  widget.text,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  style: AppStyle.primaryColorDarkMedium14(context),
                ))),
      ),
    ]);
  }
}
