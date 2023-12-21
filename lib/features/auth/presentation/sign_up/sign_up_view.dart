import 'dart:io';

import 'package:dandia_driver/core/constants/app_assets.dart';
import 'package:dandia_driver/features/auth/presentation/sign_up/bloc/signup_bloc.dart';
import 'package:dandia_driver/shared/app_input_decoration.dart';
import 'package:dandia_driver/shared/app_text_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/sign_up';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _vehicleModelController = TextEditingController();
  final TextEditingController _vehicleColorController = TextEditingController();
  final TextEditingController _vehicleRegistrationController =
      TextEditingController();

  var _country = countries.firstWhere((element) => element.code == "KE");

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _vehicleModelController.dispose();
    _vehicleColorController.dispose();
    _vehicleRegistrationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                    if (state.image == null) {
                      return CircleAvatar(
                        radius: 80.r,
                        backgroundImage:
                            const AssetImage(AppAssets.profileAvatarMan),
                      );
                    } else {
                      return CircleAvatar(
                        radius: 80.r,
                        backgroundImage: FileImage(File(state.image!.path)),
                      );
                    }
                  },
                ),
                SizedBox(height: 8.h),
                InkWell(
                  onTap: () {
                    context.read<SignupBloc>().add(ChooseImageEvent());
                  },
                  child: const Text(
                    "Select Image",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(children: [
                    TextFormField(
                      controller: _usernameController,
                      validator: (value) {
                        return AppTextValidators.validateUserName(value);
                      },
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration:
                          const AppInputDecoration(labelString: "User Name"),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 18.h),
                    TextFormField(
                      validator: (value) {
                        return AppTextValidators.validateEmail(value);
                      },
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration:
                          const AppInputDecoration(labelString: "Email"),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 22.h),
                    TextFormField(
                      validator: (value) {
                        return AppTextValidators.validatePassword(value);
                      },
                      controller: _passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration:
                          const AppInputDecoration(labelString: "Password"),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 22.h),
                    IntlPhoneField(
                      controller: _phoneController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration:
                          const AppInputDecoration(labelString: "Phone Number"),
                      initialCountryCode: 'KE',
                      onChanged: (phone) {
                        if (phone.number.length >= _country.minLength &&
                            phone.number.length <= _country.maxLength) {
                          context
                              .read<SignupBloc>()
                              .add(PhonenumberChanged(phoneNumber: phone));
                        }
                      },
                      onCountryChanged: (country) {
                        _country = country;
                      },
                    ),
                    SizedBox(height: 22.h),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your vehicle model";
                        }
                        return null;
                      },
                      controller: _vehicleModelController,
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration:
                          const AppInputDecoration(labelString: "Card Model"),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 22.h),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your vehicle color";
                        }
                        return null;
                      },
                      controller: _vehicleColorController,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration:
                          const AppInputDecoration(labelString: "Car Color"),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 22.h),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your vehicle registration number";
                        }
                        return null;
                      },
                      controller: _vehicleRegistrationController,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const AppInputDecoration(
                          labelString: "Car Registration Number"),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    BlocBuilder<SignupBloc, SignupState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<SignupBloc>()
                                  .add(SignupWithEmailEvent(
                                    carColor: _vehicleColorController.text,
                                    carModel: _vehicleModelController.text,
                                    carNumber:
                                        _vehicleRegistrationController.text,
                                    image: state.image,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    username: _usernameController.text,
                                    phone:
                                        "${state.phoneNumber?.countryCode}${state.phoneNumber?.number}",
                                  ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 80.w, vertical: 10.h),
                              backgroundColor: Colors.purple),
                          child: const Text("Sign Up"),
                        );
                      },
                    ),
                    SizedBox(height: 22.h),
                    TextButton(
                        onPressed: () {
                          context
                              .read<SignupBloc>()
                              .add(NavigateToSigninEvent());
                        },
                        child: const Text(
                          "Already have an account? Sign In",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ))
                  ]),
                ),
              ],
            ),
          ),
        ));
  }
}
