// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:room_automation/features/auth/data/entities/user_details.dart';
// import 'package:room_automation/features/auth/domain/bloc/login_bloc.dart';
// import 'package:room_automation/features/home/presentation/pages/home_Screen.dart';

// class RegisterScreen extends StatelessWidget {
//   RegisterScreen({super.key});
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final phoneController = TextEditingController();
//   final passwerdController = TextEditingController();
//   final confirmPasswerdController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F7FB),
//       appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24),
//         child: BlocConsumer<AuthBloc, AuthState>(
//           listener: (context, state) {
//             if (state is AuthRegistrationError) {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text(state.message)));
//             }
//             if (state is AuthRegAuthenticated) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text("User Created Successfully")),
//               );
//               Navigator.pop(context);
//             }
//           },
//           builder: (context, state) {
//             return Column(
//               children: [
//                 Container(
//                   width: 110,
//                   height: 110,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     gradient: LinearGradient(
//                       colors: [Color(0xff8B5CF6), Color(0xff06B6D4)],
//                     ),
//                   ),
//                   child: const Icon(
//                     Icons.person_add_alt_1,
//                     color: Colors.white,
//                     size: 55,
//                   ),
//                 ),

//                 const SizedBox(height: 25),

//                 const Text(
//                   "Create Account",
//                   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                 ),

//                 const SizedBox(height: 10),

//                 const Text(
//                   "Create your small signal account",
//                   style: TextStyle(color: Colors.grey),
//                 ),

//                 const SizedBox(height: 35),

//                 _field(nameController, "Full Name", Icons.person_outline),

//                 const SizedBox(height: 16),

//                 _field(emailController, "Email", Icons.email_outlined),

//                 const SizedBox(height: 16),

//                 _field(phoneController, "Phone Number", Icons.phone_outlined),

//                 const SizedBox(height: 16),

//                 _field(
//                   passwerdController,
//                   "Password",
//                   Icons.lock_outline,
//                   obscure: true,
//                 ),

//                 const SizedBox(height: 16),

//                 _field(
//                   confirmPasswerdController,
//                   "Confirm Password",
//                   Icons.lock_outline,
//                   obscure: true,
//                 ),

//                 const SizedBox(height: 30),

//                 SizedBox(
//                   width: double.infinity,
//                   height: 58,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       UserDetails details = UserDetails(
//                         id: '',
//                         name: nameController.text.trim(),
//                         email: emailController.text.trim(),
//                         phoneNumber: phoneController.text.trim(),
//                         passwordString: passwerdController.text.trim(),
//                       );
//                       context.read<AuthBloc>().add(
//                         RegisterRequested(userDetails: details),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.black,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(18),
//                       ),
//                     ),
//                     child: const Text(
//                       "Create Account",
//                       style: TextStyle(color: Colors.white, fontSize: 18),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 25),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text("Already have an account?"),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => HomeScreen()),
//                         );
//                       },
//                       child: const Text("Login"),
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   static Widget _field(
//     TextEditingController controller,
//     String hint,
//     IconData icon, {
//     bool obscure = false,
//   }) {
//     return TextField(
//       controller: controller,
//       obscureText: obscure,
//       decoration: InputDecoration(
//         hintText: hint,
//         prefixIcon: Icon(icon),
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(18),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_automation/features/auth/data/entities/user_details.dart';
import 'package:room_automation/features/auth/domain/bloc/login_bloc.dart';
import 'package:room_automation/features/home/presentation/pages/home_Screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthRegistrationError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }

            if (state is AuthRegAuthenticated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("User Created Successfully")),
              );

              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xff8B5CF6), Color(0xff06B6D4)],
                      ),
                    ),
                    child: const Icon(
                      Icons.person_add_alt_1,
                      color: Colors.white,
                      size: 55,
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "Create Account",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Create your small signal account",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 35),

                  _field(
                    controller: nameController,
                    hint: "Full Name",
                    icon: Icons.person_outline,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Name is required";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  _field(
                    controller: emailController,
                    hint: "Email",
                    icon: Icons.email_outlined,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Email is required";
                      }

                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );

                      if (!emailRegex.hasMatch(value.trim())) {
                        return "Enter a valid email";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  _field(
                    controller: phoneController,
                    hint: "Phone Number",
                    icon: Icons.phone_outlined,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Phone number is required";
                      }

                      if (value.trim().length != 10) {
                        return "Enter a valid 10-digit number";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  _field(
                    controller: passwordController,
                    hint: "Password",
                    icon: Icons.lock_outline,
                    obscure: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }

                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  _field(
                    controller: confirmPasswordController,
                    hint: "Confirm Password",
                    icon: Icons.lock_outline, //mode added
                    obscure: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Confirm your password"; //affef
                      }

                      if (value != passwordController.text) {
                        return "Passwords do not match";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: state is AuthRegistrationLoading
                          ? null
                          : () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }

                              final details = UserDetails(
                                id: '',
                                name: nameController.text.trim(),
                                email: emailController.text.trim(),
                                phoneNumber: phoneController.text.trim(),
                                passwordString: passwordController.text.trim(),
                              );

                              context.read<AuthBloc>().add(
                                RegisterRequested(userDetails: details),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: state is AuthRegistrationLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            )
                          : const Text(
                              "Create Account",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => HomeScreen()),
                          );
                        },
                        child: const Text("Login"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        errorMaxLines: 2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
