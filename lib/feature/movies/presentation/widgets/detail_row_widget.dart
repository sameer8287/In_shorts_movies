import 'package:flutter/material.dart';

import '../../../../core/theme/my_text_theme.dart';

class DetailRowWidget extends StatelessWidget {
  final String label;
  final String value;

  const DetailRowWidget({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: MyTextTheme.myBodySmallTheme(fontSize: 14, fontWeight: FontWeight.w500, textColor: Colors.grey[700]),
            ),
          ),
          Expanded(
            child: Text(value, style: MyTextTheme.myBodySmallTheme(fontSize: 14, textColor: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
