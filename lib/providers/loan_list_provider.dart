import 'package:creditsea_assignment/models/loan_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loanlistProvider = StateProvider<List<Loan>>((ref) => []);
