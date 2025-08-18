import 'package:creditsea_assignment/providers/text_editing_controllers_providers.dart';
import 'package:creditsea_assignment/screens/steeper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordBottomSheet extends ConsumerStatefulWidget {
  const PasswordBottomSheet({super.key});

  @override
  ConsumerState<PasswordBottomSheet> createState() => _PasswordBottomSheet();
}

class _PasswordBottomSheet extends ConsumerState<PasswordBottomSheet> {
  bool _obscurePassword = true;
  bool _obscureRePassword = true;

  @override
  Widget build(BuildContext context) {
    final _passwordController = ref.watch(passwordController);
    final _rePasswordController = ref.watch(refpasswordController);
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          _passwordController.clear();
          _rePasswordController.clear();
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Create a password",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 25),

              /// Enter Password
              const Text(
                "Enter password",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: "Enter password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// Re-enter Password
              const Text(
                "Re enter password",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _rePasswordController,
                obscureText: _obscureRePassword,
                decoration: InputDecoration(
                  hintText: "Re enter password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureRePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureRePassword = !_obscureRePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),

              /// Password hint
              const Text(
                "*your password must include at least 8 characters, inclusive of at least 1 special character",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const Spacer(),

              /// Proceed button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Validate passwords here
                    if (_passwordController.text ==
                            _rePasswordController.text &&
                        _passwordController.text.length >= 8) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Password set successfully!"),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Passwords do not match or invalid"),
                        ),
                      );
                    }
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (context) => Steeper()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 117, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Proceed",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
