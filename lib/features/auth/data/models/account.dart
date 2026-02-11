class Account {
  int? accountId;
  String? accountName;
  String? profileImageUrl;
  String? firstName;
  String? lastName;
  int? age;
  bool? isPrimary;

  Account({
    this.accountId,
    this.accountName,
    this.profileImageUrl,
    this.firstName,
    this.lastName,
    this.age,
    this.isPrimary
  });

  Account.fromJson(Map<String, dynamic> json) {
    accountId: json['accountId'];
    accountName: json['accountName'];
    profileImageUrl: json['profileImageUrl'];
    firstName: json['firstName'];
    lastName: json['lastName'];
    age: json['age'];
    isPrimary: json['isPrimary'];
  }
}