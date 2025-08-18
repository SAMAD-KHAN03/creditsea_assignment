import 'package:creditsea_assignment/providers/screen_provider.dart';
import 'package:creditsea_assignment/screens/pan_verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoanCalculator extends ConsumerStatefulWidget {
  const LoanCalculator({Key? key}) : super(key: key);

  @override
  ConsumerState<LoanCalculator> createState() => _LoadCalculator();
}

const blackColor = Color.fromARGB(255, 58, 58, 58);

class _LoadCalculator extends ConsumerState<LoanCalculator> {
  String? selectedPurpose;
  double principalAmount = 30000;
  double tenure = 40; // in days

  final List<String> loanPurposes = [
    'Personal Use',
    'Business',
    'Education',
    'Medical Emergency',
    'Home Improvement',
    'Debt Consolidation',
    'Travel',
    'Wedding',
    'Other',
  ];

  // Calculate interest and total payable
  double get interestAmount => principalAmount * 0.01; // 1% interest
  double get totalPayable => principalAmount + interestAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header Section
              SizedBox(
                width: 228,
                height: 45,
                child: Image.asset("assets/images/logo3.png"),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color.fromARGB(255, 58, 58, 58),
                      size: 24,
                    ),
                  ),
                  Text(
                    "Apply for loan",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                      fontSize: 20,
                      color: Color.fromARGB(255, 58, 58, 58),
                      // fontStyle: FontStyle.
                    ),
                  ),
                ],
              ),
              const Text(
                "We've calculated your loan eligibility. Select your preferred loan amount and tenure.",
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 58, 58, 58),
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 24),

              // Interest and Processing Fee Cards
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color.fromARGB(
                            255,
                            0,
                            117,
                            255,
                          ).withOpacity(0.3),
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      ),
                      child: const Text(
                        'Interest Per Day 1%',
                        style: TextStyle(fontSize: 14, color: blackColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color.fromARGB(
                            255,
                            0,
                            117,
                            255,
                          ).withOpacity(0.3),
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      ),
                      child: const Text(
                        'Processing Fee 10%',
                        style: TextStyle(fontSize: 14, color: blackColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Purpose of Loan
              const Text(
                'Purpose of Loan*',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                dropdownColor: Colors.grey[50],
                value: selectedPurpose,
                decoration: InputDecoration(
                  hintText: 'Select purpose of loan',
                  hintStyle: TextStyle(color: blackColor),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: blackColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: blackColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 117, 255),
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                items: loanPurposes.map((purpose) {
                  return DropdownMenuItem<String>(
                    value: purpose,
                    child: Text(purpose),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPurpose = value;
                  });
                },
              ),

              const SizedBox(height: 32),

              // Principal Amount Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Principal Amount',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '₹ ${principalAmount.toInt().toString()}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Principal Amount Slider
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Color.fromARGB(255, 0, 117, 255),
                  inactiveTrackColor: Colors.grey[300],
                  thumbColor: Color.fromARGB(255, 0, 117, 255),
                  overlayColor: Color.fromARGB(
                    255,
                    0,
                    117,
                    255,
                  ).withOpacity(0.2),
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 10,
                  ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 20,
                  ),
                ),
                child: Slider(
                  value: principalAmount,
                  min: 10000,
                  max: 100000,
                  divisions: 18,
                  onChanged: (value) {
                    setState(() {
                      principalAmount = value;
                    });
                  },
                ),
              ),

              const SizedBox(height: 32),

              // Tenure Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tenure',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '${tenure.toInt()} Days',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Tenure Slider
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Color.fromARGB(255, 0, 117, 255),
                  inactiveTrackColor: Colors.grey[300],
                  thumbColor: Color.fromARGB(255, 0, 117, 255),
                  overlayColor: Color.fromARGB(
                    255,
                    0,
                    117,
                    255,
                  ).withOpacity(0.2),
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 10,
                  ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 20,
                  ),
                ),
                child: Slider(
                  value: tenure,
                  min: 20,
                  max: 45,
                  divisions: 5,
                  onChanged: (value) {
                    setState(() {
                      tenure = value;
                    });
                  },
                ),
              ),

              // Tenure Range Labels
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '20 Days',
                      style: TextStyle(fontSize: 12, color: blackColor),
                    ),
                    Text(
                      '45 Days',
                      style: TextStyle(fontSize: 12, color: blackColor),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Loan Summary Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color.fromARGB(255, 0, 117, 255),
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Principle Amount',
                          style: TextStyle(fontSize: 16, color: blackColor),
                        ),
                        Text(
                          '₹${principalAmount.toInt()}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 0, 117, 255),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Interest',
                          style: TextStyle(fontSize: 16, color: blackColor),
                        ),
                        Text(
                          '1%',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 0, 117, 255),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Payable',
                          style: TextStyle(fontSize: 16, color: blackColor),
                        ),
                        Text(
                          '₹${totalPayable.toInt()}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 0, 117, 255),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Thank you message
              const Text(
                'Thank you for choosing CreditSea. Please accept to proceed with the loan details.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 0, 117, 255),
                  // textBaseline: TextAlign.center,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // Apply Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedPurpose != null) {
                      // Handle loan application
                      _showConfirmationDialog();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a purpose for the loan'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 117, 255),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Apply',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Cancel Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 0, 117, 255),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 0, 117, 255),
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Loan Application'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Purpose: $selectedPurpose'),
              Text('Principal Amount: ₹${principalAmount.toInt()}'),
              Text('Tenure: ${tenure.toInt()} days'),
              Text('Total Payable: ₹${totalPayable.toInt()}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Loan application submitted successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
