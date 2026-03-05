import 'package:adcc/features/events/sections/Join%20Event/join_event_emergency_card.dart';
import 'package:adcc/features/events/sections/Join%20Event/join_event_event_card.dart';
import 'package:adcc/features/events/sections/Join%20Event/join_event_text_field.dart';
import 'package:adcc/features/events/sections/Join%20Event/joint_event_header.dart';
import 'package:flutter/material.dart';

class JoinEvent extends StatefulWidget {
  const JoinEvent({super.key});

  @override
  State<JoinEvent> createState() => _JoinEventState();
}

class _JoinEventState extends State<JoinEvent> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController =
      TextEditingController(text: "Ahmed Al Mansouri");
  final TextEditingController emailController =
      TextEditingController(text: "ahmed.almansouri@email.com");
  final TextEditingController phoneController =
      TextEditingController(text: "+971 50 123 4567");
  final TextEditingController emergencyNameController =
      TextEditingController(text: "Contact person name");
  final TextEditingController emergencyPhoneController =
      TextEditingController(text: "+971 50 123 4567");

  String? selectedBikeType;
  String? haveBike;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9EF),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                    const SizedBox(height: 10),

JoinEventHeader(
  onBackTap: () => Navigator.pop(context),
),

const SizedBox(height: 20),

const JoinEventEventCard(),
                      const SizedBox(height: 24),

                    
                      const Text(
                        "Personal Information",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),

                      const SizedBox(height: 16),
_buildLabel("Full Name *"),
JoinEventTextField(
  controller: fullNameController,
  hintText: "Ahmed Al Mansouri",
),

                      const SizedBox(height: 14),
_buildLabel("Email Address *"),
JoinEventTextField(
  controller: emailController,
  hintText: "ahmed.almansouri@email.com",
),

                      const SizedBox(height: 14),
_buildLabel("Phone Number *"),
JoinEventTextField(
  controller: phoneController,
  hintText: "+971 50 123 4567",
),

                      const SizedBox(height: 24),

                      /// CYCLING INFO
                      const Text(
                        "Cycling Information",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),

                      const SizedBox(height: 16),

                    _buildLabel("Do you have your own bike?"),
JoinEventDropdown(
  value: haveBike,
  hint: "Select option",
  items: const ["Yes", "No"],
  onChanged: (val) {
    setState(() => haveBike = val);
  },
),

                      const SizedBox(height: 14),

                    _buildLabel("Bike Type *"),
JoinEventDropdown(
  value: selectedBikeType,
  hint: "Select bike type",
  items: const [
    "Road Bike",
    "Mountain Bike",
    "Hybrid Bike"
  ],
  onChanged: (val) {
    setState(() => selectedBikeType = val);
  },
),
                      const SizedBox(height: 24),

JoinEventEmergencyCard(
  nameController: emergencyNameController,
  phoneController: emergencyPhoneController,
),

                      const SizedBox(height: 80),
            /// BOTTOM BUTTON
            Container(
              padding: const EdgeInsets.all(2),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 51,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD63B36),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Complete Registration",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "I accept the terms and confirm that all information\nprovided is accurate. I understand the safety\nrequirements and will comply with all event guidelines.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0XFF6A7282),
                        height: 1.4),
                  )
                ],
              ),
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
              )
            )
          ]
        ))
    );
  }



  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

}