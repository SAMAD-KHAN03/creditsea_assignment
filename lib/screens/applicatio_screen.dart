import 'package:creditsea_assignment/backend/firebase_functions.dart';
import 'package:creditsea_assignment/screens/application_status_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

class ApplicatioScreen extends ConsumerStatefulWidget {
  const ApplicatioScreen({super.key});

  @override
  ConsumerState<ApplicatioScreen> createState() =>
      _ApplicatioScreenAlternative1State();
}

class _ApplicatioScreenAlternative1State
    extends ConsumerState<ApplicatioScreen> {
  @override
  void initState() {
    super.initState();
    fetchLoans(); // Call your async function, but do not await it
  }

  Future<void> fetchLoans() async {
    print("fetching loans");
    await fetchLoansFromFirebase(ref);
    // Do any post-fetch updates, e.g., setState if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "Aplication Status",

                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 2,
                ),
              ),
              ApplicationStatusPanel(showScaffold: false),
              ApplicationStatusPanel(showScaffold: false),
              ApplicationStatusPanel(showScaffold: false),
              // Add more panels as needed
            ],
          ),
        ),
      ),
    );
  }
}
