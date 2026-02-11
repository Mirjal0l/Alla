

import '../account.dart';

class VerifyOtpResponse {
  String? parentToken;
  String? phoneNumber;
  List<Account>? accounts;
  bool? canCreateNewAccount;

  VerifyOtpResponse({
    this.parentToken,
    this.phoneNumber,
    this.accounts,
    this.canCreateNewAccount
  });

  VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    parentToken = json['parentToken'];
    phoneNumber = json['phoneNumber'];
    accounts = json['accounts'];
    canCreateNewAccount = json['canCreateNewAccount'];
  }
}