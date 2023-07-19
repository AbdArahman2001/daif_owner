import 'package:daif_owner/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Column(

        children: [
          SizedBox(height: 16.h,),
          ContactMethod(
            icon: Icons.facebook,
            title: 'Facebook',
            onPressed: () {
              Helper.doLaunchURL(
                  'https://www.facebook.com'); // Replace with your Facebook URL
            },
          ),
          ContactMethod(
            icon: Icons.web,
            title: 'Website',
            onPressed: () {
              Helper.doLaunchURL(
                  'https://www.dayf-app.com/'); // Replace with your website URL
            },
          ),
          ContactMethod(
            icon: Icons.chat,
            title: 'WhatsApp',
            onPressed: () {
              Helper.doLaunchURL(
                  'https://api.whatsapp.com/send?phone=+972595663793'); // Replace with your WhatsApp URL
            },
          ),
          ContactMethod(
            icon: Icons.send,
            title: 'Telegram',
            onPressed: () {
              Helper.doLaunchURL('https://t.me/+w2iPz4txTu8yYjc6');
            },
          ),
          ContactMethod(
            icon: Icons.email,
            title: 'Email',
            onPressed: () {
              Helper.doLaunchURL('mailto:info@dayf-app.com');
            },
          ),
          ContactMethod(
            icon: Icons.phone,
            title: 'Phone Number',
            onPressed: () {
              Helper.doLaunchURL('tel:0595663793');
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
        leading: Icon(icon,color: Theme.of(context).primaryColor,),
        title: Text(title),
      ),
    );
  }
}
