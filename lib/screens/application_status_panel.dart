import 'package:flutter/material.dart';

class ApplicationStatusPanel extends StatefulWidget {
  final bool showScaffold; // whether to show AppBar + Scaffold or just panel
  const ApplicationStatusPanel({super.key, this.showScaffold = true});

  @override
  State<ApplicationStatusPanel> createState() => _ApplicationStatusPanelState();
}

class _ApplicationStatusPanelState extends State<ApplicationStatusPanel> {
  bool _isExpanded = true;

  final List<StatusStep> statusSteps = [
    StatusStep(
      title: "Application Submitted",
      icon: Icons.assignment_turned_in_outlined,
      status: StatusType.completed,
    ),
    StatusStep(
      title: "Application under Review",
      icon: Icons.rate_review_outlined,
      status: StatusType.current,
    ),
    StatusStep(
      title: "E-KYC",
      icon: Icons.verified_user_outlined,
      status: StatusType.pending,
    ),
    StatusStep(
      title: "E-Nach",
      icon: Icons.account_balance_outlined,
      status: StatusType.pending,
    ),
    StatusStep(
      title: "E-Sign",
      icon: Icons.draw_outlined,
      status: StatusType.pending,
    ),
    StatusStep(
      title: "Disbursement",
      icon: Icons.payments_outlined,
      status: StatusType.pending,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final panel = SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Expandable Panel with Loan Details
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ExpansionPanelList(
                elevation: 0,
                expandedHeaderPadding: EdgeInsets.zero,
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                children: [
                  ExpansionPanel(
                    backgroundColor: Colors.white,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Loan application no. #',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      );
                    },
                    body: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Column(
                        children: [
                          // Status Steps
                          ...statusSteps.map(
                            (step) => _buildStatusStep(step),
                          ),

                          const SizedBox(height: 30),

                          // Status Icon and Message
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1976D2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      const Icon(
                                        Icons.credit_card,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                      Positioned(
                                        bottom: 8,
                                        right: 8,
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF1976D2),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.visibility,
                                            color: Colors.white,
                                            size: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Application Under Review',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'We\'re carefully reviewing your application to ensure everything is in order. Thank you for your patience.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    isExpanded: _isExpanded,
                    canTapOnHeader: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  print('Continue button pressed');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1976D2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // Return with or without Scaffold
    return widget.showScaffold
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text(
                'Application Status',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: panel,
          )
        : panel;
  }

  Widget _buildStatusStep(StatusStep step) {
    Color stepColor;
    Color backgroundColor;

    switch (step.status) {
      case StatusType.completed:
        stepColor = const Color(0xFF4CAF50);
        backgroundColor = const Color(0xFFE8F5E8);
        break;
      case StatusType.current:
        stepColor = const Color(0xFF1976D2);
        backgroundColor = const Color(0xFFE3F2FD);
        break;
      case StatusType.pending:
      default:
        stepColor = Colors.grey[400]!;
        backgroundColor = Colors.grey[100]!;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  border: Border.all(color: stepColor, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(step.icon, color: stepColor, size: 20),
              ),
              if (statusSteps.indexOf(step) != statusSteps.length - 1)
                Container(width: 2, height: 30, color: Colors.grey[300]),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: stepColor.withOpacity(0.3)),
              ),
              child: Text(
                step.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: step.status == StatusType.pending
                      ? Colors.grey[600]
                      : Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatusStep {
  final String title;
  final IconData icon;
  final StatusType status;

  StatusStep({required this.title, required this.icon, required this.status});
}

enum StatusType { completed, current, pending }