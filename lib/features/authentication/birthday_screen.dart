import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktokclonepractice/constants/gaps.dart';
import 'package:tiktokclonepractice/constants/routeurls.dart';
import 'package:tiktokclonepractice/constants/sizes.dart';
import 'package:tiktokclonepractice/features/authentication/widgets/form_button.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokclonepractice/utils.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();
  DateTime initialDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _setTextFieldDate(initialDate);
  }

  void onNextTap(BuildContext context) {
    context.goNamed(RouteNames.interestsScreen);
  }

  void _setTextFieldDate(DateTime date) {
    final String textDate = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(text: textDate);
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign up",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              "When's your birthday?",
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v8,
            const Opacity(
              opacity: 0.7,
              child: Text(
                "Your birthday won't be shown publicly",
                style: TextStyle(
                  fontSize: Sizes.size16,
                  // color: Colors.black38,
                ),
              ),
            ),
            Gaps.v16,
            TextField(
              controller: _birthdayController,
              enabled: false,
              style: TextStyle(
                color: isDarkMode(context) ? Colors.grey.shade700 : null,
              ),
            ),
            Gaps.v16,
            FormButton(
              disabled: false,
              text: "Next",
              onTap: onNextTap,
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 300,
        child: SizedBox(
          child: CupertinoTheme(
            data: CupertinoThemeData(
              brightness:
                  isDarkMode(context) ? Brightness.dark : Brightness.light,
            ),
            child: CupertinoDatePicker(
              onDateTimeChanged: _setTextFieldDate,
              mode: CupertinoDatePickerMode.date,
              maximumDate: DateTime(initialDate.year - 10),
              initialDateTime: DateTime(initialDate.year - 10),
            ),
          ),
        ),
      ),
    );
  }
}
