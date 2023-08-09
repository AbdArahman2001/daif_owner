import 'package:daif_owner/helper/helper.dart';
import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/utill/app_constants.dart';
import 'package:daif_owner/utill/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = MyLocalizations.translate(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.contact_with_us),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 16.h,
          ),
          ContactMethod(
            icon: Icons.facebook,
            title: locale.facebook,
            onPressed: () {
              Helper.doLaunchURL(
                  'https://www.facebook.com'); // Replace with your Facebook URL
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: () {
                Helper.doLaunchURL(
                   AppConstants.dayfInstagram); // Replace with your Facebook URL
              },
              leading: Image.asset(
                IconAssets.instagramIcon,
                width:30.w ,
                height:30.w ,
              ),
              title: Text(locale.instagram),
            ),
          ),
          ContactMethod(
            icon: Icons.web,
            title: locale.website,
            onPressed: () {
              Helper.doLaunchURL(
                  AppConstants.dayfWebsite); // Replace with your website URL
            },
          ),
          ContactMethod(
            icon: Icons.chat,
            title: locale.whatsapp,
            onPressed: () {
              Helper.doLaunchURL(
                  AppConstants.dayfWhatsapp); // Replace with your WhatsApp URL
            },
          ),
          ContactMethod(
            icon: Icons.send,
            title: locale.telegram,
            onPressed: () {
              Helper.doLaunchURL(AppConstants.dayfTelegram);
            },
          ),
          ContactMethod(
            icon: Icons.email,
            title: locale.email,
            onPressed: () {
              Helper.doLaunchURL(AppConstants.dayfEmail);
            },
          ),
          ContactMethod(
            icon: Icons.phone,
            title: locale.phone_number,
            onPressed: () {
              Helper.doLaunchURL(AppConstants.dayfPhoneNumber);
            },
          ),
        ],
      ),
    );
  }
}

class ContactMethod extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  const ContactMethod({
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: onPressed,
        leading: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(title),
      ),
    );
  }
}
