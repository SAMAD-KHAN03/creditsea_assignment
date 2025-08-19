class Loan {
  final String loanId;
  final String userId;
  final String? purpose;
  final double principalAmount;
  final double tenure;
  final double interestRate;
  final double totalPayable;

  Loan({
    required this.loanId,
    required this.userId,
    required this.purpose,
    required this.principalAmount,
    required this.tenure,
    required this.interestRate,
    required this.totalPayable,
  });

  Map<String, dynamic> toJson() {
    return {
      'loanId': loanId,
      'userId': userId,
      'purpose': purpose,
      'principalAmount': principalAmount,
      'tenure': tenure,
      'interestRate': interestRate,
      'totalPayable': totalPayable,
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  factory Loan.fromJson(Map<String, dynamic> json) {
    return Loan(
      loanId: json['loanId'],
      userId: json['userId'],
      purpose: json['purpose'],
      principalAmount: (json['principalAmount'] as num).toDouble(),
      tenure: (json['tenure'] as num).toDouble(),
      interestRate: (json['interestRate'] as num).toDouble(),
      totalPayable: (json['totalPayable'] as num).toDouble(),
    );
  }
}