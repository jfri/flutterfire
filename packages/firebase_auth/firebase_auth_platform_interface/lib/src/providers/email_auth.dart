// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// @dart=2.9

import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:firebase_auth_platform_interface/src/auth_provider.dart';
import 'package:meta/meta.dart';

const _kLinkProviderId = 'emailLink';
const _kProviderId = 'password';

/// A [EmailAuthCredential] can be created by calling
/// [EmailAuthProvider.credential] with an email and password.
///
/// Usage of [EmailAuthProvider] would be when you wish to sign a user in with a
/// credential or reauthenticate a user.
abstract class EmailAuthProvider extends AuthProvider {
  /// Creates a new instance.
  EmailAuthProvider() : super(_kProviderId);

  /// This corresponds to the sign-in method identifier for email-link sign-ins.
  static String get EMAIL_LINK_SIGN_IN_METHOD {
    return _kLinkProviderId;
  }

  /// This corresponds to the sign-in method identifier for email-password
  /// sign-ins.
  static String get EMAIL_PASSWORD_SIGN_IN_METHOD {
    return _kProviderId;
  }

  // ignore: public_member_api_docs
  static String get PROVIDER_ID {
    return _kProviderId;
  }

  /// Creates a new [EmailAuthCredential] from a given email and password.
  static AuthCredential credential(
      {@required String email, @required String password}) {
    assert(email != null);
    assert(password != null);
    return EmailAuthCredential._credential(email, password);
  }

  /// Creates a new [EmailAuthCredential] from a given email and email link.
  static AuthCredential credentialWithLink(
      {@required String email, @required String emailLink}) {
    assert(email != null);
    assert(emailLink != null);
    return EmailAuthCredential._credentialWithLink(email, emailLink);
  }
}

/// The auth credential returned from calling
/// [EmailAuthProvider.credential].
class EmailAuthCredential extends AuthCredential {
  EmailAuthCredential._(
    String _signInMethod, {
    @required this.email,
    this.password,
    this.emailLink,
  }) : super(providerId: _kProviderId, signInMethod: _signInMethod);

  factory EmailAuthCredential._credential(String email, String password) {
    return EmailAuthCredential._(_kProviderId,
        email: email, password: password);
  }

  factory EmailAuthCredential._credentialWithLink(
      String email, String emailLink) {
    return EmailAuthCredential._(_kLinkProviderId,
        email: email, emailLink: emailLink);
  }

  /// The user's email address.
  final String email;

  /// The user account password.
  final String password;

  /// The sign-in email link.
  final String emailLink;

  @override
  Map<String, String> asMap() {
    return <String, String>{
      'providerId': providerId,
      'signInMethod': signInMethod,
      'email': email,
      'emailLink': emailLink,
      'secret': password,
    };
  }
}
