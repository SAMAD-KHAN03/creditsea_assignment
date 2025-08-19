import 'package:creditsea_assignment/providers/screen_provider.dart';
import 'package:creditsea_assignment/providers/steeper_selected_index.dart';
import 'package:creditsea_assignment/screens/detail.dart';
import 'package:creditsea_assignment/screens/offer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Fixed Stepper class
class Steeper extends ConsumerStatefulWidget {
  const Steeper({super.key});

  @override
  ConsumerState<Steeper> createState() => _Stepper();
}

class _Stepper extends ConsumerState<Steeper> {
  // List<bool> whichSelected = List<bool>.generate(
  //   3,
  //   (index) => index == 0 ? true : false,
  // );

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(steeperselectedIndex);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Stepper Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CustomStepper(
                    serialnumber: "1",
                    content: "Register",
                    isselected: index == 0,
                  ),
                  const Spacer(),
                  CustomStepper(
                    serialnumber: "2",
                    content: "Offer",
                    isselected: index == 1,
                  ),
                  const Spacer(),
                  CustomStepper(
                    serialnumber: "3",
                    content: "Approval",
                    isselected: index == 2,
                  ),
                ],
              ),
            ),

            // Content Area - This is the key fix!
            Expanded(child: _buildCurrentStep(ref)),
          ],
        ),
      ),
    );
  }

  // Method to return the current step widget
  Widget _buildCurrentStep(WidgetRef ref) {
    final screen = ref.watch(screenProvider);
    // final index = ref.watch(steeperselectedIndex);
    return screen;
  }
}

// Fixed CustomStepper class
class CustomStepper extends StatefulWidget {
  final String serialnumber;
  final String content;
  final bool isselected;

  const CustomStepper({
    super.key,
    required this.serialnumber,
    required this.content,
    required this.isselected,
  });

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.isselected
                ? const Color.fromARGB(255, 0, 117, 255)
                : const Color.fromARGB(34, 117, 117, 117),
          ),
          child: Center(
            child: Text(
              widget.serialnumber,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          widget.content,
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 117, 255),
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
