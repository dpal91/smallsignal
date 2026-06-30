import 'package:flutter/material.dart';

class SmartSwitchCard extends StatelessWidget {
  final String name;
  final bool isOn;
  final VoidCallback onTap;

  const SmartSwitchCard({
    super.key,
    required this.name,
    required this.isOn,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),

                gradient: isOn
                    ? const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF14363E),
                          Color(0xFF45E5F1),
                        ],
                      )
                    : LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.grey.shade800,
                          Colors.grey.shade700,
                        ],
                      ),

                border: Border.all(
                  color: isOn
                      ? const Color(0xFF45E5F1)
                      : Colors.grey.shade600,
                ),

                boxShadow: isOn
                    ? [
                        BoxShadow(
                          color: const Color(
                            0xFF45E5F1,
                          ).withOpacity(0.25),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16,
                  ),
                  child: Container(
                    width: 42,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isOn
                          ? Colors.yellow
                          : Colors.grey.shade400,
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}