import 'package:creditsea_assignment/providers/loan_details_provider.dart';
import 'package:creditsea_assignment/providers/screen_provider.dart';
import 'package:creditsea_assignment/providers/steeper_selected_index.dart';
import 'package:creditsea_assignment/screens/applicatio_screen.dart';
import 'package:creditsea_assignment/screens/application_status_panel.dart';
import 'package:creditsea_assignment/screens/steeper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creditsea_assignment/backend/firebase_functions.dart';

class OfferScreen extends ConsumerWidget {
  const OfferScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final principal = ref.watch(principalAmountProvider);
    final tenure = ref.watch(tenureProvider);

    // Get interest rate from table or fallback
    final interest = interestTable[principal]?[tenure] ?? 0.05;
    final interestAmount = principal * interest;
    final totalPayable = principal + interestAmount;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Our Offerings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 40),

              // Offer Card with Image
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset(
                        'assets/images/coin.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Offer Text
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(fontSize: 16, height: 1.5),
                  children: [
                    const TextSpan(
                      text: 'Congratulations! ',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const TextSpan(
                      text: 'We can offer you ',
                      style: TextStyle(color: Colors.black87),
                    ),
                    TextSpan(
                      text: "₹${principal.toInt()}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: ' within ',
                      style: TextStyle(color: Colors.black87),
                    ),
                    TextSpan(
                      text: "${tenure.toInt()} days",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: ', with a payable amount of ',
                      style: TextStyle(color: Colors.black87),
                    ),
                    TextSpan(
                      text: "₹${totalPayable.toStringAsFixed(0)}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: '. Just with few more steps.',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Text(
                'Proceed further to',
                style: TextStyle(fontSize: 16, color: Colors.black87),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              // Accept Offer Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    _onAcceptOffer(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Accept Offer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Extend Offer Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () async {
                    await saveLoanToFirebase(ref);

                    ref.watch(screenProvider.notifier).state =
                        ApplicatioScreen();
                    ref.watch(steeperselectedIndex.notifier).state = 2;
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (context) => Steeper()));
                    // ref.watch(steeperselectedIndex.notifier).state = 2;
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF1976D2), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Extend Offer',
                    style: TextStyle(
                      color: Color(0xFF1976D2),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _onAcceptOffer(BuildContext context) {
    // Add your accept offer logic here
    print('Accept Offer pressed');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Offer accepted successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _onExtendOffer(BuildContext context) {
    // Add your extend offer logic here
    print('Extend Offer pressed');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Offer extension requested!'),
        backgroundColor: Color(0xFF1976D2),
      ),
    );
  }
}
