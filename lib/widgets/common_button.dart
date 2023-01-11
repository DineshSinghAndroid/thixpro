import 'package:Thixpro/widgets/sementions.dart';
import 'package:flutter/material.dart';

import '../resources/app_theme.dart';

class AddButton extends StatelessWidget {
  final String? titleText;
  final bool? expended;
  final bool? isIcon;
  final double? outSideMargin;
  final VoidCallback? onPresses;
  final bool? icon;
  const AddButton({
    Key? key,
    this.titleText = "",
    this.expended = false,
    this.outSideMargin = 0,
    this.onPresses,
    this.isIcon = false,
    this.icon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPresses,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(100),
        ),
        margin: EdgeInsets.symmetric(horizontal: outSideMargin!),
        width: expended! ? double.maxFinite : null,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: isIcon!
            ? Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        titleText != "" ? AddSize.size10 : AddSize.size5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon == true)
                      Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.white,
                        size: AddSize.size18,
                      ),
                    Icon(
                      titleText != "" ? Icons.adaptive.share : Icons.more_horiz,
                      color: Colors.white,
                      size: AddSize.size18,
                    ),
                    SizedBox(
                      width: titleText != "" ? AddSize.size5 : 0,
                    ),
                    Text(
                      titleText!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: AddSize.font14),
                    ),
                  ],
                ),
              )
            : Text(
                titleText!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: AddSize.font16),
              ),
      ),
    );
  }
}
