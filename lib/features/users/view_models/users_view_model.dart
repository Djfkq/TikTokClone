import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokclonepractice/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktokclonepractice/features/users/models/user_profile_model.dart';
import 'package:tiktokclonepractice/features/users/repos/user_repo.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _repository;

  @override
  FutureOr<UserProfileModel> build() {
    _repository = ref.read(userRepo);
    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential credential) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    }
    final form = ref.read(signUpForm.notifier).state;

    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      bio: "undefined",
      link: "undefined",
      email: credential.user!.email ?? "anon@anon.com",
      uid: credential.user!.uid,
      name: credential.user!.displayName ?? "Anon",
      username: form["username"],
      birthday: form["birthday"],
    );
    await _repository.createProfile(profile);
    state = AsyncValue.data(profile);
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
