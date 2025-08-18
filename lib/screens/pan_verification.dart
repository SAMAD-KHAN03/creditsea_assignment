import 'package:creditsea_assignment/providers/screen_provider.dart';
import 'package:creditsea_assignment/screens/emailverification.dart';
import 'package:creditsea_assignment/screens/loan_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PanVerification extends ConsumerStatefulWidget {
  @override
  _PanVerification createState() => _PanVerification();
}

class _PanVerification extends ConsumerState<PanVerification> {
  final TextEditingController _panController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _panController.dispose();
    super.dispose();
  }

  void _onVerifyPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Handle verification logic here
      String panNumber = _panController.text.trim();
      print('PAN Number to verify: $panNumber');
      // You can add your verification API call here
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => LoanCalculator()));
    }
  }

  String? _validatePAN(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your PAN number';
    }

    // Basic PAN validation (10 characters, alphanumeric)
    if (value.length != 10) {
      return 'PAN number must be 10 characters long';
    }

    // PAN format: 5 letters, 4 digits, 1 letter
    RegExp panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
    if (!panRegex.hasMatch(value.toUpperCase())) {
      return 'Please enter a valid PAN number';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            ref.watch(screenProvider.notifier).state = Emailverification();
          },
        ),
        title: Text(
          'Verify PAN Number',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            
            // 👇 Makes sure it scrolls only when needed
            shrinkWrap: true,
            children: [
              // Card Image Container
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFFE8F4FD),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/images/pan.png',
                    height: 120,
                    width: 180,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              SizedBox(height: 25),

              // Input Label
              Text(
                'Enter Your PAN Number*',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 12),

              // PAN Input Field
              TextFormField(
                controller: _panController,
                textCapitalization: TextCapitalization.characters,
                maxLength: 10,
                validator: _validatePAN,
                decoration: InputDecoration(
                  hintText: 'e.g., ABCDE1234F',
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF1976D2), width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  counterText: '', // Hide character counter
                ),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),

              SizedBox(height: 40),

              // Verify Button
              Container(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    _onVerifyPressed(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 117, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Verify',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
