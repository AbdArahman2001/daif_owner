import 'package:daif_owner/helper/enum_data.dart';
import 'package:flutter/material.dart';

import '../../../../utill/styles_manager.dart';

class LanguageTypeListTileWidget extends StatelessWidget {
  const LanguageTypeListTileWidget(
      {Key? key,
      required this.languageType,
      required this.langGroup,
      required this.onChanged})
      : super(key: key);
  final LanguageType languageType;
  final LanguageType langGroup;
  final ValueChanged<LanguageType?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          languageType.getLanguageName(context),
          style: style_600_18(Theme.of(context).primaryColor),
        ),
        Radio<LanguageType>(
          value: languageType,
          groupValue: langGroup,
          onChanged: onChanged,
          activeColor: Theme.of(context).primaryColor,
          fillColor: MaterialStateProperty.resolveWith(
              (states) => Theme.of(context).primaryColor),
        ),
      ],
    );
  }
}
