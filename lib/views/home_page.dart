import 'dart:typed_data';

import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/globals/app_assets.dart';
import 'package:my_portfolio/globals/app_buttons.dart';
import 'package:my_portfolio/globals/app_colors.dart';
import 'package:my_portfolio/globals/app_text_styles.dart';
import 'package:my_portfolio/globals/constants.dart';
import 'package:my_portfolio/helper%20class/helper_class.dart';
import 'package:my_portfolio/widgets/profile_animation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final socialButtons = <String>[
    AppAssets.linkedIn,
    AppAssets.github,
  ];
  final socialLinks = <String>[
    "https://www.linkedin.com/in/safa-basheer-98916418a",
    "https://github.com/safabash",
  ];

  var socialBI;
  Future<void> _savePdfLocally() async {
    try {
      // Load the PDF from the assets
      ByteData data = await rootBundle.load('assets/pdf/cv.pdf');
      List<int> bytes = data.buffer.asUint8List();

      // Get the local path to save the file
      var dir = await getApplicationDocumentsDirectory();
      String filePath = '${dir.path}/cv.pdf';

      // Write the PDF to the file system
      File file = File(filePath);
      await file.writeAsBytes(bytes);

      // Open the PDF file
      OpenFile.open(filePath);

      // Optionally show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF saved successfully')),
      );
    } catch (e) {
      // Handle any errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return HelperClass(
      mobile: Column(
        children: [
          buildHomePersonalInfo(size),
          Constants.sizedBox(height: 25.0),
          const ProfileAnimation()
        ],
      ),
      tablet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(child: buildHomePersonalInfo(size)),
          const ProfileAnimation(),
        ],
      ),
      desktop: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(child: buildHomePersonalInfo(size)),
          const ProfileAnimation(),
        ],
      ),
      paddingWidth: size.width * 0.1,
      bgColor: Colors.transparent,
    );
  }

  Column buildHomePersonalInfo(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeInDown(
          duration: const Duration(milliseconds: 1200),
          child: Text(
            'Hello, It\'s Me',
            style: AppTextStyles.montserratStyle(color: Colors.white),
          ),
        ),
        Constants.sizedBox(height: 15.0),
        FadeInRight(
          duration: const Duration(milliseconds: 1400),
          child: Text(
            'Safa Basheer Ahamed',
            style: AppTextStyles.headingStyles(),
          ),
        ),
        Constants.sizedBox(height: 15.0),
        FadeInLeft(
          duration: const Duration(milliseconds: 1400),
          child: Row(
            children: [
              Text(
                'And I\'m a ',
                style: AppTextStyles.montserratStyle(color: Colors.white),
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText('Freelancer',
                      textStyle: AppTextStyles.montserratStyle(
                          color: Colors.lightBlue)),
                  TyperAnimatedText(
                    'Flutter Developer',
                    textStyle:
                        AppTextStyles.montserratStyle(color: Colors.lightBlue),
                  ),
                ],
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              )
            ],
          ),
        ),
        Constants.sizedBox(height: 15.0),
        FadeInDown(
          duration: const Duration(milliseconds: 1600),
          child: Text(
            'Flutter developer with 1.5 years of experience building cross-platform mobile apps. '
            ' Proficient in Dart, they excel in creating responsive,'
            ' high-performance applications',
            style: AppTextStyles.normalStyle(),
          ),
        ),
        Constants.sizedBox(height: 22.0),
        SizedBox(
          height: 48,
          child: ListView.separated(
            itemCount: socialButtons.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, child) =>
                Constants.sizedBox(width: 8.0),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  if (!await launchUrl(Uri.parse(socialLinks[index]))) {
                    throw Exception('Could not launch url');
                  }
                },
                onHover: (value) {
                  setState(() {
                    if (value) {
                      socialBI = index;
                    } else {
                      socialBI = null;
                    }
                  });
                },
                borderRadius: BorderRadius.circular(550.0),
                hoverColor: AppColors.themeColor,
                splashColor: AppColors.lawGreen,
                child: buildSocialButton(
                    asset: socialButtons[index],
                    hover: socialBI == index ? true : false),
              );
            },
          ),
        ),
        Constants.sizedBox(height: 18.0),
        FadeInUp(
          duration: const Duration(milliseconds: 1800),
          child: AppButtons.buildMaterialButton(
              onTap: () {
                _savePdfLocally();
              },
              buttonName: 'Download CV'),
        ),
      ],
    );
  }

  Ink buildSocialButton({required String asset, required bool hover}) {
    return Ink(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.themeColor, width: 2.0),
        color: AppColors.bgColor,
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(6),
      child: Image.asset(
        asset,
        width: 10,
        height: 12,
        color: hover ? AppColors.bgColor : AppColors.themeColor,
        // fit: BoxFit.fill,
      ),
    );
  }
}
