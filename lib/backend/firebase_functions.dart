import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creditsea_assignment/models/loan_details.dart';
import 'package:creditsea_assignment/models/user_details.dart';
import 'package:creditsea_assignment/providers/loan_details_provider.dart';
import 'package:creditsea_assignment/providers/loan_list_provider.dart';
import 'package:creditsea_assignment/providers/profile_components_provider.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

Future<String> _getOrCreateUserId() async {
  final prefs = await SharedPreferences.getInstance();
  String? userId = prefs.getString("userId");

  if (userId == null) {
    userId = const Uuid().v4();
    await prefs.setString("userId", userId);
    print("🆕 New UserId created: $userId");
  } else {
    print("🔑 Existing UserId found: $userId");
  }

  return userId;
}

Future<void> saveUserDetailsToFirestore(WidgetRef ref) async {
  try {
    // Ensure unique userId exists
    final userId = await _getOrCreateUserId();

    // Read values from providers
    final firstname = ref.read(firstnameController).text.trim();
    final lastname = ref.read(lastnameController).text.trim();
    final email = ref.read(emailController).text.trim();
    final gender = ref.read(genderController) ?? '';
    final marital = ref.read(maritalStatus) ?? '';
    final dob = ref.read(dobController);
    final pan = ref.read(pandCardNumber).text.trim();

    // Create UserDetails object
    final userDetails = UserDetails(
      firstname: firstname,
      lastname: lastname,
      gender: gender,
      maritalstatus: marital,
      emailId: email,
      pannumber: pan,
      dob: dob,
    );
    print("sending data ");
    // Save to Firestore under `users/{userId}`
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(userDetails.toJson(), SetOptions(merge: true));

    print("✅ User details saved under ID $userId: $userDetails");
  } catch (e, st) {
    print("❌ Error saving user details: $e");
    print(st);
    rethrow;
  }
}

Future<void> loadUserDetailsOnAppStart(WidgetRef ref) async {
  try {
    // 1. Get userId from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("userId");

    if (userId == null) {
      print("⚠️ No userId found in SharedPreferences.");
      return;
    }

    // 2. Fetch from Firestore
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    if (!snapshot.exists) {
      print("⚠️ No user document found for userId $userId");
      return;
    }

    final data = snapshot.data()!;
    final userDetails = UserDetails.fromJson(data);

    // 3. Update Riverpod providers
    ref.read(firstnameController).text = userDetails.firstname;
    ref.read(lastnameController).text = userDetails.lastname;
    ref.read(emailController).text = userDetails.emailId;
    ref.read(genderController.notifier).state = userDetails.gender;
    ref.read(maritalStatus.notifier).state = userDetails.maritalstatus;
    ref.read(dobController.notifier).state = userDetails.dob;
    ref.read(pandCardNumber).text = userDetails.pannumber;

    print("✅ User details loaded and providers updated.");
  } catch (e, st) {
    print("❌ Error loading user details: $e");
    print(st);
  }
}

Future<void> saveLoanToFirebase(WidgetRef ref) async {
  try {
    final purpose = ref.read(selectedPurposeProvider);
    final principalAmount = ref.read(principalAmountProvider);
    final tenure = ref.read(tenureProvider);
    final interestRate = ref.read(interestProvider);

    final interestAmount = principalAmount * interestRate;
    final totalPayable = principalAmount + interestAmount;
    final userId = await _getOrCreateUserId();
    // Generate random unique loan ID
    final randomId =
        'loan_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(9999)}';

    final loan = Loan(
      loanId: randomId,
      userId: userId,
      purpose: purpose,
      principalAmount: principalAmount,
      tenure: tenure,
      interestRate: interestRate,
      totalPayable: totalPayable,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('loans')
        .doc(randomId)
        .set(loan.toJson());

    print("✅ Loan saved successfully with ID: $randomId");
  } catch (e) {
    print("❌ Error saving loan: $e");
  }
}

Future<List<Loan>> fetchLoansFromFirebase(WidgetRef ref) async {
  try {
    final userId = await _getOrCreateUserId(); // Same as in save function

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('loans')
        .get();

    final loans = snapshot.docs
        .map((doc) => Loan.fromJson(doc.data()))
        .toList();
    ref.watch(loanlistProvider.notifier).state = loans;
    print("✅ Fetched ${loans.length} loans for user $userId");
    return loans;
  } catch (e) {
    print("❌ Error fetching loans: $e");
    return [];
  }
}
