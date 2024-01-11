import 'package:flutter/material.dart';
import 'package:tiktokclonepractice/constants/gaps.dart';
import 'package:tiktokclonepractice/constants/routeurls.dart';
import 'package:tiktokclonepractice/constants/sizes.dart';
import 'package:tiktokclonepractice/features/authentication/widgets/form_button.dart';
import 'package:tiktokclonepractice/utils.dart';
import 'package:go_router/go_router.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};

  void _onSubmitTap(BuildContext context) {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        context.goNamed(RouteNames.interestsScreen);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Log in",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Gaps.v28,
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(
                    color: isDarkMode(context) ? Colors.grey.shade700 : null,
                  ),
                ),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please write your email';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  if (newValue != null) {
                    formData["email"] = newValue;
                  }
                },
              ),
              Gaps.v16,
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Passsword",
                  hintStyle: TextStyle(
                    color: isDarkMode(context) ? Colors.grey.shade700 : null,
                  ),
                ),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'wrong password';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  if (newValue != null) {
                    formData['password'] = newValue;
                  }
                },
              ),
              Gaps.v28,
              FormButton(
                text: "Log in",
                disabled: false,
                onTap: _onSubmitTap,
              )
            ],
          ),
        ),
      ),
    );
  }
}