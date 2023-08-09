import 'package:flutter/material.dart';
import '../../../helper/enum_data.dart';
import '../../screens/profile/widget/language_type_list_tile_widget.dart';
class ChooseLanguageDialog extends StatelessWidget {
  const ChooseLanguageDialog({Key? key, required this.languageGroup, required this.changeLanguage}) : super(key: key);
final LanguageType languageGroup;
final void Function(LanguageType? languageType) changeLanguage;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...LanguageType.values.map((language) =>
              LanguageTypeListTileWidget(
                  languageType: language,
                  langGroup: languageGroup,
                  onChanged: changeLanguage))
        ],
      ),
    );
  }
}
