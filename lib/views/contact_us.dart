import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:my_portfolio/globals/app_buttons.dart';
import 'package:my_portfolio/helper%20class/helper_class.dart';
import '../globals/app_colors.dart';
import '../globals/app_text_styles.dart';
import '../globals/constants.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  // Global key to validate form
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  // Email sending function
  Future<void> send() async {
    if (_formKey.currentState?.validate() ?? false) {
      final Email email = Email(
        body: 'Name: ${_nameController.text}\n'
            'Email: ${_emailController.text}\n'
            'Mobile: ${_mobileController.text}\n'
            'Message: ${_bodyController.text}',
        subject: _subjectController.text,
        recipients: ['safabasheerahamed@gmail.com'], // Your email ID here
        isHTML: false,
      );

      String platformResponse;

      try {
        await FlutterEmailSender.send(email);
        platformResponse = 'Message sent successfully!';
      } catch (error) {
        print(error);
        platformResponse = 'Failed to send message: $error';
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(platformResponse),
        ),
      );
    }
  }

  // Validator function to check if the field is empty
  String? _validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  Column buildForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        buildContactText(),
        Constants.sizedBox(height: 40.0),
        Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: buildTextField(
                      controller: _nameController,
                      hintText: 'Full Name',
                      validator: (value) => _validateField(value, 'Full Name'),
                    ),
                  ),
                  Constants.sizedBox(width: 20.0),
                  Expanded(
                    child: buildTextField(
                      controller: _emailController,
                      hintText: 'Email Address',
                      validator: (value) =>
                          _validateField(value, 'Email Address'),
                    ),
                  ),
                ],
              ),
              Constants.sizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: buildTextField(
                      controller: _mobileController,
                      hintText: 'Mobile Number',
                      validator: (value) =>
                          _validateField(value, 'Mobile Number'),
                    ),
                  ),
                  Constants.sizedBox(width: 20.0),
                  Expanded(
                    child: buildTextField(
                      controller: _subjectController,
                      hintText: 'Email Subject',
                      validator: (value) => _validateField(value, 'Subject'),
                    ),
                  ),
                ],
              ),
              Constants.sizedBox(height: 20.0),
              buildTextField(
                controller: _bodyController,
                hintText: 'Your Message',
                maxLines: 15,
                validator: (value) => _validateField(value, 'Message'),
              ),
              Constants.sizedBox(height: 40.0),
              AppButtons.buildMaterialButton(
                buttonName: 'Send Message',
                onTap: send,
              ),
              Constants.sizedBox(height: 30.0),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return HelperClass(
      mobile: Form(
        key: _formKey, // Form key to validate form
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildContactText(),
            Constants.sizedBox(height: 40.0),
            buildTextField(
              controller: _nameController,
              hintText: 'Full Name',
              validator: (value) => _validateField(value, 'Full Name'),
            ),
            Constants.sizedBox(height: 20.0),
            buildTextField(
              controller: _emailController,
              hintText: 'Email Address',
              validator: (value) => _validateField(value, 'Email Address'),
            ),
            Constants.sizedBox(height: 20.0),
            buildTextField(
              controller: _mobileController,
              hintText: 'Mobile Number',
              validator: (value) => _validateField(value, 'Mobile Number'),
            ),
            Constants.sizedBox(height: 20.0),
            buildTextField(
              controller: _subjectController,
              hintText: 'Email Subject',
              validator: (value) => _validateField(value, 'Subject'),
            ),
            Constants.sizedBox(height: 20.0),
            buildTextField(
              controller: _bodyController,
              hintText: 'Your Message',
              maxLines: 15,
              validator: (value) => _validateField(value, 'Message'),
            ),
            Constants.sizedBox(height: 40.0),
            AppButtons.buildMaterialButton(
              buttonName: 'Send Message',
              onTap: send, // Send email on button press
            ),
            Constants.sizedBox(height: 30.0),
          ],
        ),
      ),
      tablet: buildForm(),
      desktop: buildForm(),
      paddingWidth: size.width * 0.2,
      bgColor: AppColors.bgColor,
    );
  }

  // Function to build a text field with validation
  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required String? Function(String?) validator,
    int maxLines = 1,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.transparent,
      elevation: 8,
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors.white,
        style: AppTextStyles.normalStyle(),
        maxLines: maxLines,
        decoration: buildInputDecoration(hintText: hintText),
        validator: validator, // Add validation here
      ),
    );
  }

  // Column buildForm() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       buildContactText(),
  //       Constants.sizedBox(height: 40.0),
  //       Row(
  //         children: [
  //           Expanded(
  //             child: Material(
  //               borderRadius: BorderRadius.circular(10),
  //               color: Colors.transparent,
  //               elevation: 8,
  //               child: TextField(
  //                 cursorColor: AppColors.white,
  //                 style: AppTextStyles.normalStyle(),
  //                 decoration: buildInputDecoration(hintText: 'Full Name'),
  //               ),
  //             ),
  //           ),
  //           Constants.sizedBox(width: 20.0),
  //           Expanded(
  //             child: Material(
  //               borderRadius: BorderRadius.circular(10),
  //               color: Colors.transparent,
  //               elevation: 8,
  //               child: TextField(
  //                 cursorColor: AppColors.white,
  //                 style: AppTextStyles.normalStyle(),
  //                 decoration: buildInputDecoration(hintText: 'Email Address'),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       Constants.sizedBox(height: 20.0),
  //       Row(
  //         children: [
  //           Expanded(
  //             child: Material(
  //               borderRadius: BorderRadius.circular(10),
  //               color: Colors.transparent,
  //               elevation: 8,
  //               child: TextField(
  //                 cursorColor: AppColors.white,
  //                 style: AppTextStyles.normalStyle(),
  //                 decoration: buildInputDecoration(hintText: 'Mobile Number'),
  //               ),
  //             ),
  //           ),
  //           Constants.sizedBox(width: 20.0),
  //           Expanded(
  //             child: Material(
  //               borderRadius: BorderRadius.circular(10),
  //               color: Colors.transparent,
  //               elevation: 8,
  //               child: TextField(
  //                 cursorColor: AppColors.white,
  //                 style: AppTextStyles.normalStyle(),
  //                 decoration: buildInputDecoration(hintText: 'Email Subject'),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       Constants.sizedBox(height: 20.0),
  //       Material(
  //         borderRadius: BorderRadius.circular(10),
  //         color: Colors.transparent,
  //         elevation: 8,
  //         child: TextField(
  //           maxLines: 15,
  //           cursorColor: AppColors.white,
  //           style: AppTextStyles.normalStyle(),
  //           decoration: buildInputDecoration(hintText: 'Your Message'),
  //         ),
  //       ),
  //       Constants.sizedBox(height: 40.0),
  //       AppButtons.buildMaterialButton(
  //           buttonName: 'Send Message', onTap: () {}),
  //       Constants.sizedBox(height: 30.0),
  //     ],
  //   );
  // }

  FadeInDown buildContactText() {
    return FadeInDown(
      duration: const Duration(milliseconds: 1200),
      child: RichText(
        text: TextSpan(
          text: 'Contact ',
          style: AppTextStyles.headingStyles(fontSize: 30.0),
          children: [
            TextSpan(
              text: 'Me!',
              style: AppTextStyles.headingStyles(
                  fontSize: 30, color: AppColors.robinEdgeBlue),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration({required String hintText}) {
    return InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.comfortaaStyle(),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: AppColors.bgColor2,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 16));
  }
}
