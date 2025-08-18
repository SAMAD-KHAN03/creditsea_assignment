// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:creditsea_assignment/providers/profile_components_provider.dart';
import 'package:creditsea_assignment/providers/screen_provider.dart';
import 'package:creditsea_assignment/providers/text_editing_controllers_providers.dart';
import 'package:creditsea_assignment/screens/emailverification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Your Detail widget (unchanged)
class Detail extends ConsumerStatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  ConsumerState<Detail> createState() => _Detail();
}

class _Detail extends ConsumerState<Detail> {
  final List<String> genders = ["Male", "Female", "Other"];
  final List<String> maritalStatuses = ["Single", "Married", "Other"];

  @override
  Widget build(BuildContext context) {
    final _firstNameController = ref.watch(firstnameController);
    final _lastNameController = ref.watch(lastnameController);
    String? _gender = ref.watch(genderController);
    DateTime? _dob = ref.watch(dobController);
    String? _maritalStatus = ref.watch(maritalStatus);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Personal Details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // First & Last Name
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: "First Name*",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: "Last Name*",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Gender
          DropdownButtonFormField<String>(
            value: _gender,
            decoration: const InputDecoration(
              labelText: "Gender*",
              border: OutlineInputBorder(),
            ),
            items: genders
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) => setState(() => _gender = val),
          ),
          const SizedBox(height: 16),

          // Date of Birth
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: "Date of Birth*",
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() => _dob = picked);
                  }
                },
              ),
            ),
            controller: TextEditingController(
              text: _dob == null
                  ? ""
                  : "${_dob!.day}-${_dob!.month}-${_dob!.year}",
            ),
          ),
          const SizedBox(height: 16),

          // Marital Status
          DropdownButtonFormField<String>(
            value: _maritalStatus,
            decoration: const InputDecoration(
              labelText: "Your Marital Status*",
              border: OutlineInputBorder(),
            ),
            items: maritalStatuses
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) => setState(() => _maritalStatus = val),
          ),

          const Spacer(),

          // Continue button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // validation and navigation
                ref.watch(screenProvider.notifier).state = Emailverification();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 117, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                "Continue",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
