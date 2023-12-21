import 'package:dandia_driver/core/constants/app_assets.dart';
import 'package:dandia_driver/features/auth/presentation/sign_in/bloc/signin_bloc.dart';
import 'package:dandia_driver/shared/app_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInView extends StatefulWidget {
  static const String routeName = '/sign_in';
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    AppAssets.carIMage,
                    width: 220.w,
                  ),
                  SizedBox(height: 30.h),
                  const Text(
                    "Login as a Driver",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(children: [
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            const AppInputDecoration(labelString: "Email"),
                        style: const TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 22.h),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration:
                            const AppInputDecoration(labelString: "Password"),
                        style: const TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 22.h),
                      ElevatedButton(
                        onPressed: () {
                          context.read<SigninBloc>().add(SigninWithEmailEvent(
                              email: _emailController.text,
                              password: _passwordController.text));
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 80.w, vertical: 10.h),
                            backgroundColor: Colors.purple),
                        child: const Text("Login"),
                      ),
                      SizedBox(height: 22.h),
                      TextButton(
                          onPressed: () {
                            context
                                .read<SigninBloc>()
                                .add(NavigateToSignupEvent());
                          },
                          child: const Text(
                            "Don't have an account? Sign Up",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ))
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
