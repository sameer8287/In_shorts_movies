import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../theme/my_text_theme.dart';
import 'common_card.dart';

class CommonButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onPressed;
  final bool isOutlined;

  const CommonButton({super.key, required this.btnText, required this.onPressed, this.isOutlined = false});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onPressed,
      child: CommonCard(
        color: isOutlined ? Colors.white : AppTheme.primaryColor,
        shapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          side: isOutlined ? BorderSide(color: AppTheme.primaryColor) : BorderSide.none,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.016),
            child: Center(
              child: Text(
                "$btnText",
                style: MyTextTheme.myBodyMediumTheme(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  textColor: isOutlined ? AppTheme.primaryColor : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
