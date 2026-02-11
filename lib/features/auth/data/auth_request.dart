// single request model for all (4 in constants) auth operations

class AuthRequest {
  // common fields that might be used in multiple operations
  String? phoneNumber; // Used in sentOtp, verifyOtp
  String? otpCode; // Used in veryfyOtp
  String? parentToken; // Used in selectAccount, createAccount (from verifyOtp response)
  int? accountId; // Used only in selectAccount
  String? accountName; // Used only in createAccount
  String? firstName; // Used only in createAccount
  String? lastName; // Used only in createAccount
  String? birthDate; // Used only in createAccount
  String? profileImageUrl; // Used only in createAccount

// Main constructor with all optional parameters
// Explanation: This constructor allows creating requests for any operation
// We mark most parameters as optional with ? so we don't have to provide them all

  AuthRequest({
    this.phoneNumber,
    this.otpCode,
    this.parentToken,
    this.accountId,
    this.accountName,
    this.firstName,
    this.lastName,
    this.birthDate,
    this.profileImageUrl
  });

// Convert object to JSON for API request
// Explanation: When we send data to API, we need to convert Dart objects to JSON format
// This method creates a Map that can be converted to JSON string using json.encode()
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};

    // Always include phone number since it's required in most operations
    map['phoneNumber'] = phoneNumber;

    // Include other fields only if they are not null
    // Explanation: We use null-aware checking to avoid sending empty fields to API
    if (otpCode != null) map['otpCode'] = otpCode;
    if (parentToken != null) map['parentToken'] = parentToken;
    if (accountId != null) map['accountId'] = accountId;
    if (accountName != null) map['accountName'] = accountName;
    if (firstName != null) map['firstName'] = firstName;
    if (lastName != null) map['lastName'] = lastName;
    if (birthDate != null) map['birthDate'] = birthDate;
    if (profileImageUrl != null) map['profileImageUrl'] = profileImageUrl;

    return map;
  }

  AuthRequest.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    otpCode = json['otpCode'];
    parentToken = json['parentToken'];
    accountId = json['accountId'];
    accountName = json['accountName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    birthDate = json['birthDate'];
    profileImageUrl = json['profileImageUrl'];
  }

// Factory methods for specific operations
// Explanation: Factory methods are special constructors that return instances
// They make it easier to create requests for specific operations

// For sending OTP - only needs phone number
//   factory AuthRequest.sendOtp(String phoneNumber) {
//     return AuthRequest(phoneNumber: phoneNumber);
//   }

// For verifying OTP - needs phone number and OTP code
//   factory AuthRequest.verifyOtp(String phoneNumber, String otpCode) {
//     return AuthRequest(phoneNumber: phoneNumber, otpCode: otpCode);
//   }
}