import 'package:creditsea_assignment/providers/screen_provider.dart';
import 'package:creditsea_assignment/screens/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Fixed Stepper class
class Steeper extends ConsumerStatefulWidget {
  const Steeper({super.key});

  @override
  ConsumerState<Steeper> createState() => _Stepper();
}

class _Stepper extends ConsumerState<Steeper> {
  List<bool> whichSelected = List<bool>.generate(
    3,
    (index) => index == 0 ? true : false,
  );

  @override
  Widget build(BuildContext context) {
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        whichSelected[1] = false;
                        whichSelected[2] = false;
                        whichSelected[0] = true;
                      });
                    },
                    child: CustomStepper(
                      serialnumber: "1",
                      content: "Register",
                      isselected: whichSelected[0],
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        whichSelected[0] = false;
                        whichSelected[2] = false;
                        whichSelected[1] = true;
                      });
                    },
                    child: CustomStepper(
                      serialnumber: "2",
                      content: "Offer",
                      isselected: whichSelected[1],
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        whichSelected[0] = false;
                        whichSelected[1] = false;
                        whichSelected[2] = true;
                      });
                    },
                    child: CustomStepper(
                      serialnumber: "3",
                      content: "Approval",
                      isselected: whichSelected[2],
                    ),
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
    if (whichSelected[0]) {
      return screen;
    } else if (whichSelected[1]) {
      return const Center(
        child: Text("Offer Screen"),
      ); // Replace with your Offer widget
    } else if (whichSelected[2]) {
      return const Center(
        child: Text("Approval Screen"),
      ); // Replace with your Approval widget
    }
    return const Detail(); // Default
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
