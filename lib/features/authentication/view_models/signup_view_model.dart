import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclonepractice/constants/routeurls.dart';
import 'package:tiktokclonepractice/features/authentication/repos/authentication_repo.dart';
import 'package:tiktokclonepractice/utils.dart';
import 'package:go_router/go_router.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;
  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);
    ///////////////////////////////////////////////////////////////////////////
    // await _authRepo.signUp(form["email"], form["password"]);
    // state = const AsyncValue.data(null);
    ///////////////////////////////////////////////////////////////////////////
    ///위의 두줄을 아래 guard하나로 됨
    ///(함수 실행시 에러발생하면 에러내용을 state에 넣고, 아니면 결과를 state에 넣음)
    state = await AsyncValue.guard(
      () async => await _authRepo.emailSignUp(
        form["email"],
        form["password"],
      ),
    );
    if (state.hasError) {
      showFirebaseErrorSnack(
        context,
        state.error,
      );
    } else {
      context.goNamed(RouteNames.interestsScreen);
    }
  }
}

final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
