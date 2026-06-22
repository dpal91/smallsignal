import 'package:flutter/material.dart';
import 'package:room_automation/features/add%20device/presentation/pages/add_device_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(
                            "https://picsum.photos/200",
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEAD8FF),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                "Plus",
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            IconButton(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => AddDeviceScreen(),
                                //   ),
                                // );
                              },
                              icon: Icon(
                                Icons.add,
                                size: 34,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // Search Bar
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [
                            Colors.pink,
                            Colors.orange,
                            Colors.green,
                            Colors.cyan,
                          ],
                        ),
                      ),
                      child: Container(
                        height: 58,
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 34,
                              height: 34,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [Colors.purple, Colors.cyan],
                                ),
                              ),
                              child: const Icon(
                                Icons.blur_on,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                "How can I help?",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const Icon(Icons.mic_none, color: Colors.black54),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Favorites
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Favorites",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.menu, size: 28),
                      ],
                    ),

                    const SizedBox(height: 180),

                    // Empty State
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            "Add Your First Device",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Connect a device and let AI control it for you",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(180, 58),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              "Add Now",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Navigation
            // Container(
            //   height: 80,
            //   decoration: const BoxDecoration(
            //     color: Colors.white,
            //     boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: const [
            //       NavItem(icon: Icons.home, label: "Home", active: true),
            //       NavItem(icon: Icons.check_box_outlined, label: "Smart"),
            //       CircleAvatar(
            //         radius: 24,
            //         backgroundColor: Colors.grey,
            //         child: Text(
            //           "00:11",
            //           style: TextStyle(color: Colors.white, fontSize: 11),
            //         ),
            //       ),
            //       NavItem(icon: Icons.explore_outlined, label: "Explore"),
            //       NavItem(icon: Icons.person_outline, label: "Me"),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: active ? Colors.black : Colors.grey),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: active ? Colors.black : Colors.grey),
        ),
      ],
    );
  }
}
