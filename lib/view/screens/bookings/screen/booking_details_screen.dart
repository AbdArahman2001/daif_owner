import 'package:daif_owner/utill/assets_manager.dart';
import 'package:daif_owner/view/basewidget/button/custom_back_button.dart';
import 'package:daif_owner/view/screens/bookings/widget/booking_id_widget.dart';
import 'package:daif_owner/view/screens/bookings/widget/booking_time_and_date_widget.dart';
import 'package:daif_owner/view/screens/bookings/widget/custom_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../localization/my_localizations.dart';
import '../../../../utill/color_manager.dart';
import '../../../../utill/styles_manager.dart';
import '../../../basewidget/custom_app_bar.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: locale.booking_details,
        actions: SizedBox.shrink(),
        leading: IconButton(onPressed: ()=>Get.back(),icon: const Icon(Icons.arrow_back_ios),),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Text(
          "${locale.booking} #25012",
            style: style_600_18(ColorManager.blackTextColor),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 10.h,),
          Text(
            "Sat, 08-Oct-22, Night",
            style:
            style_400_16(ColorManager.blackTextColor.withOpacity(0.8)),
          ),
              SizedBox(height: 10.h,),

              SingleInformationRow(label: locale.place_name, value: "Al-Mashtal"),
              SizedBox(height: 10.h,),
              SingleInformationRow(label: locale.number_of_persons, value: "15"),
              SizedBox(height: 16.h,),
              CustomDividerWidget(),
              SizedBox(height: 8.h,),
              Row(
                children: [
                  Text(
                    locale.finance_info,
                    style: style_600_18(ColorManager.blackTextColor),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(width: 180.w,),
                  TextButton(onPressed: (){}, child: Text(locale.edit,style: style_500_17(ColorManager.primaryColor),))
                ],
              ),
              SingleInformationRow(label: locale.booking_price, value: "700"),
              SizedBox(height: 10.h,),
              SingleInformationRow(label: locale.paid_amount, value: "150"),
              SizedBox(height: 10.h,),
              SingleInformationRow(label: locale.payment_method, value: locale.jawwal_pay),
              SizedBox(height: 10.h,),
              SingleInformationRow(label: locale.remaining_amount, value: "550"),
              SizedBox(height: 16.h,),
              CustomDividerWidget(),
              SizedBox(height: 16.h,),
              Text(
                locale.customer_info,
                style: style_600_18(ColorManager.blackTextColor),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 10.h,),
              SingleInformationRow(label: locale.full_name, value: "إبراهيم عطاالله محمود ريحان"),
              SizedBox(height: 10.h,),
              SingleInformationRow(label: locale.phone_number, value: "0594493032"),
              SizedBox(height: 10.h,),
              SingleInformationRow(label: locale.address, value: "شمال غزة - الفالوجا"),
              SizedBox(height: 10.h,),
              SingleInformationRow(label: locale.id_number, value: "4070587302"),
              SizedBox(height: 10.h,),
              Text("${locale.id_confirmation_img}:",style: style_400_16(ColorManager.grey2)),
              SizedBox(height: 12.h,),
              Center(child: ClipRRect(borderRadius:BorderRadius.circular(10.r),child: Image.asset(ImageAssets.placeHolderImg,width: MediaQuery.of(context).size.width*.8,height: 200,fit: BoxFit.cover,))),
              SizedBox(height: 40.h,),

            ],
          ),
        ),
      ),
    );
  }
}

class SingleInformationRow extends StatelessWidget {
  const SingleInformationRow({Key? key, required this.label, required this.value}) : super(key: key);
final String label;
final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: Text("$label:",style: style_400_16(ColorManager.grey2),)),
        Flexible(flex:6,child: Text(value ,style: style_600_16(ColorManager.blackTextColor),)),
      ],
    );
  }
}

