class Bank {
  String bankName;
  String accountNumber;
  String ifscCode;
  double balc;
  Bank(
      {required this.bankName,
      required this.accountNumber,
      required this.ifscCode,
      required this.balc});
  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
        bankName: json['bankName'],
        accountNumber: json['accountNumber'],
        ifscCode: json['ifscCode'],
        balc: json['balance']);
  }
  Map<String, dynamic> tojson() {
    return {
      'bankName': bankName,
      'accountNumber': accountNumber,
      'ifscCode': ifscCode,
      'balance': balc
    };
  }
}

class Account {
  String email;
  String accountHolderName;
  List<Bank> banks;
  Account(
      {required this.email,
      required this.accountHolderName,
      required this.banks});
  factory Account.fromJson(Map<String, dynamic> json) {
    var banksFromJson = json['banks'] as List;
    List<Bank> bankList = banksFromJson.map((e) => Bank.fromJson(e)).toList();
    return Account(
        email: json['email'],
        accountHolderName: json['accountHolderName'],
        banks: bankList);
  }
  Map<String, dynamic> tojson() {
    return {
      'email': email,
      'accountHolderName': accountHolderName,
      'banks': banks.map((e) => e.tojson()).toList()
    };
  }
}
