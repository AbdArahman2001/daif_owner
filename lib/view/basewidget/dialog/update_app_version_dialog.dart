import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/view/basewidget/button/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_redirect/store_redirect.dart';

class UpdateAppVersionDialog extends StatelessWidget {
  const UpdateAppVersionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return AlertDialog(
      content: Column(
        children: [
          Text(locale.app_version_outdated),
          CustomElevatedButton(
              onPressed: () => StoreRedirect.redirect(),
              child: Text(locale.update)),
        ],
      ),
    );
  }
}
