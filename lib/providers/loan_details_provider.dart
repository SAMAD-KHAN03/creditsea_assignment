import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedPurposeProvider = StateProvider<String?>((ref) => null);
final principalAmountProvider = StateProvider<double>((ref) => 30000);
final tenureProvider = StateProvider<double>((ref) => 40);
final interestProvider = StateProvider<double>((ref) => 1);

final Map<double, Map<double, double>> interestTable = {
  for (double principal = 20000; principal <= 100000; principal += 20000)
    principal: {
      for (double tenure = 20; tenure <= 40; tenure += 5)
        tenure: double.parse(
          (((principal / 100000) * 0.1) + ((tenure / 40) * 0.05))
              .toStringAsFixed(3),
        ),
    },
};
