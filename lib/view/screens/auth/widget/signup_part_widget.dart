import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/utill/color_manager.dart';
import 'package:daif_owner/utill/styles_manager.dart';
import 'package:daif_owner/view/basewidget/button/custom_elevated_button.dart';
import 'package:daif_owner/view/screens/auth/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class SignUpPartWidget extends StatelessWidget {
  const SignUpPartWidget(
      {Key? key, required this.isTermsAndConditions, required this.changeTermsAndConditions, required this.signUpFunc, })
      : super(key: key);
  final bool isTermsAndConditions;
  final ValueChanged<bool?> changeTermsAndConditions;
  final VoidCallback signUpFunc;
  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: isTermsAndConditions,
              onChanged: changeTermsAndConditions,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.r)),
            ),
            Text(
              locale.terms_and_conditions,
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineSmall,
            ),
          ],
        ),
        SizedBox(
          height: 30.h,
        ),
        CustomElevatedButton(onPressed: signUpFunc, child: Text(locale.sign_up),),
        SizedBox(
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(locale.i_have_account, style: Theme
                .of(context)
                .textTheme
                .headlineMedium,),
            TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
                onPressed:  ()=>Get.to(const LoginScreen()), child: Text(locale.login,))
          ],
        )
      ],
    );
  }
}
