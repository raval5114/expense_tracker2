class Bill {
  String consumerNumber;
  String name;
  List<PaymentHistory> paymentHistory;

  Bill({
    required this.consumerNumber,
    required this.name,
    required this.paymentHistory,
  });

  factory Bill.fromJson(Map<String, dynamic> json) {
    var list = json['paymentHistory'] as List;
    List<PaymentHistory> paymentHistoryList =
        list.map((i) => PaymentHistory.fromJson(i)).toList();

    return Bill(
      consumerNumber: json['consumerNumber'],
      name: json['name'],
      paymentHistory: paymentHistoryList,
    );
  }

  // Method to convert Bill object to JSON
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> paymentHistoryList =
        paymentHistory.map((i) => i.toJson()).toList();

    return {
      'consumerNumber': consumerNumber,
      'name': name,
      'paymentHistory': paymentHistoryList,
    };
  }
}

class PaymentHistory {
  String paymentDate;
  double amountPaid;
  String status;

  PaymentHistory({
    required this.paymentDate,
    required this.amountPaid,
    required this.status,
  });

  // Method to convert JSON to PaymentHistory object
  factory PaymentHistory.fromJson(Map<String, dynamic> json) {
    return PaymentHistory(
      paymentDate: json['paymentDate'],
      amountPaid: json['amountPaid'].toDouble(),
      status: json['status'],
    );
  }

  // Method to convert PaymentHistory object to JSON
  Map<String, dynamic> toJson() {
    return {
      'paymentDate': paymentDate,
      'amountPaid': amountPaid,
      'status': status,
    };
  }
}
