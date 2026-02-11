// single response model for all (4 in constants) auth operations

// Explanation: This SINGLE response model handles ALL types of auth responses
// Different operations return different data, so we make most fields optional
// The API always returns success/message, but data structure varies
class AuthResponse {
  // Common wrapper fields (for error responses)
  final bool? success;
  final String? message;
  final dynamic data;
  final String? otpCode;
  // Authentication tokens

  final String? token;
  final String? parentToken;
  final String? tokenType;

  // user/account information
  final String? phoneNumber;
  final List<Account>? accounts;
  final bool? canCreateNewAccount;

  // Individual account details
  final int? accountId;
  final String? accountName;
  final String? firstName;
  final String? lastName;
  final int? age;
  final bool? isPrimary;
  final String? birthDate;
  final String? profileImageUrl;

  AuthResponse({
    this.success,
    this.message,
    this.data,
    this.otpCode,
    this.token,
    this.parentToken,
    this.tokenType,
    this.phoneNumber,
    this.accounts,
    this.canCreateNewAccount,
    this.accountId,
    this.accountName,
    this.firstName,
    this.lastName,
    this.age,
    this.isPrimary,
    this.birthDate,
    this.profileImageUrl,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    // Check if this is a WRAPPED response
    final hasWrapper = json['success'] != null && json['message'] != null;
    if (hasWrapper) {
      // WRAPPED response (400 errors) - data is inside 'data' field
      final data = json['data'] ?? {};
      return AuthResponse(
        otpCode: json['otpCode'],
        success: json['success'],
        message: json['message'],
        data: json['data'],
        // Extract ALL fields from the data object
        token: data['token'],
        parentToken: data['parentToken'],
        tokenType: data['tokenType'],
        phoneNumber: data['phoneNumber'],
        accounts: data['accounts'] != null
            ? (data['accounts'] as List)
            .map((account) => Account.fromJson(account))
            .toList()
            : null,
        canCreateNewAccount: data['canCreateNewAccount'],
        accountId: data['accountId'],
        accountName: data['accountName'],
        firstName: data['firstName'],
        lastName: data['lastName'],
        age: data['age'],
        isPrimary: data['isPrimary'],
        birthDate: data['birthDate'],
        profileImageUrl: data['profileImageUrl'],
      );
    } else {
      // DIRECT response (200 success) - fields are in JSON root
        return AuthResponse(
          success: json['success'],
          otpCode: 'otpCode',
          token: json['token'],
          parentToken: json['parentToken'],
          tokenType: json['tokenType'],
          phoneNumber: json['phoneNumber'],
          accounts: json['accounts'] != null
              ? (json['accounts'] as List)
                .map((account) => Account.fromJson(account))
                .toList()
              : null,
          canCreateNewAccount: json['canCreateNewAccount'],
          accountId: json['accountId'],
          accountName: json['accountName'],
          firstName: json['firstName'],
          lastName: json['lastName'],
          age: json['age'],
          isPrimary: json['isPrimary'],
          birthDate: json['birthDate'],
          profileImageUrl: json['profileImageUrl'],
        );
    }
  }
}

class Account {
  final int accountId;
  final String accountName;
  final String profileImageUrl;
  final String firstName;
  final String lastName;
  final int age;
  final bool isPrimary;

  // Note: birthDate is not in account objects from verifyOtp

  Account({
    required this.accountId,
    required this.accountName,
    required this.profileImageUrl,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.isPrimary,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
        accountId: json['accountId'] ?? 0,
        accountName: json['accountName'] ?? '',
        profileImageUrl: json['profileImageUrl'] ?? '',
        firstName: json['firstName'] ?? '',
        lastName: json['lastName'] ?? '',
        age: json['age'] ?? 0,
        isPrimary: json['isPrimary'] ?? false,
    );
  }
}