// import 'package:daif_owner/localization/my_localizations.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../helper/enum_data.dart';
// import 'language_type_list_tile_widget.dart';
//
// class ChangeLanguageWidget extends StatelessWidget {
//   ChangeLanguageWidget(
//       {Key? key, required this.changeLanguageFunc, required this.languageGroup})
//       : super(key: key);
//   final void Function(LanguageType? e) changeLanguageFunc;
//   final LanguageType languageGroup;
//
//   @override
//   Widget build(BuildContext context) {
//     final locale = MyLocalizations.translate(context);
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             fixedSize: Size(double.infinity,60.h),
//               backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//               elevation: 2),
//           onPressed: () {
//             final dialog = AlertDialog(
//               content: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 24.w),
//                 child: Column(
//                   children: [
//                     ...LanguageType.values.map((language) =>
//                         LanguageTypeListTileWidget(
//                             languageType: language,
//                             langGroup: languageGroup,
//                             onChanged: changeLanguageFunc))
//                   ],
//                 ),
//               ),
//             );
//             showDialog(context: context, builder: (context) => dialog);
//           },
//           child: Row(
//             children: [Text(locale.change_language), const Icon(Icons.language)],
//           )),
//     );
//   }
// }
