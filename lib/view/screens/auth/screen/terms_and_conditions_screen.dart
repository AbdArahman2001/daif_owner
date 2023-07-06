import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/view/basewidget/button/custom_back_button.dart';
import 'package:daif_owner/view/basewidget/button/custom_elevated_button.dart';
import 'package:daif_owner/view/basewidget/white_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utill/app_constants.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return Scaffold(
      appBar: WhiteAppBar(title: locale.terms_and_conditions,),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(termsAndConditions),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h,),
            CustomElevatedButton(onPressed: (){}, child: Text(locale.i_accept)),
            SizedBox(height: 52.h,),

          ],
        ),
      ),
    );
  }
}
