import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omar_ahmed_maps/business_logic/phone_auth/phone_auth_cubit.dart';
import 'package:omar_ahmed_maps/constants/my_colors.dart';
import 'package:omar_ahmed_maps/constants/strings.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class OtpScreen extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final phoneNumber;

  OtpScreen({Key? key, required this.phoneNumber}) : super(key: key);
  late String otpCode;
//  String otpCode;
  Widget _buildIntroTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Verify your phone number",
            style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 30),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: RichText(
            text: TextSpan(
                text: "Enter you 6 digit code numbers sent to you at ",
                style: const TextStyle(
                    color: Colors.black, fontSize: 18, height: 1.4),
                children: <TextSpan>[
                  TextSpan(
                    text: '$phoneNumber',
                    style: const TextStyle(color: Colors.blue),
                  ),
                ]),
          ),
        ),
      ],
    );
  }

  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );
    showDialog(
        barrierColor: Colors.white.withOpacity(0),
        barrierDismissible: false,
        context: context,
        builder: ((context) {
          return alertDialog;
        }));
  }

  /// .......................................

  Widget _buildPinCodeFields(BuildContext context) {
    return Container(
      child: PinCodeTextField(
        appContext: context,
        autoFocus: true,
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        length: 6,
        obscureText: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          borderWidth: 1,
          activeColor: MyColors.blue,
          inactiveColor: MyColors.blue,
          inactiveFillColor: Colors.white,
          activeFillColor: MyColors.lightBlue,
          selectedColor: MyColors.blue,
          selectedFillColor: Colors.white,
        ),
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Colors.white,
        enableActiveFill: true,
        onCompleted: (submittedCode) {
          otpCode = submittedCode;
          print("Completed");
        },
        onChanged: (value) {
          print(value);
        },
      ),
    );
  }

//............................

  void _login(BuildContext context) {
    BlocProvider.of<AuthCubit>(context).submitOTP(otpCode);
  }

  /// .......................................

  Widget _buildVerifyButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          showProgressIndicator(context);
          _login(context);
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(110, 50),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: const Text("Verify",
            style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }

  Widget _buildPhoneVerificationBloc() {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is AuthLoading) {
          showProgressIndicator(context);
        }
        if (state is PhoneOTPVerified) {
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed(mapScreen);
        }
        if (state is AuthError) {
          Navigator.pop(context);
          String errMsg = (state).errMsg;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errMsg),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 88),
            child: Column(
              children: [
                _buildIntroTexts(),
                const SizedBox(
                  height: 88,
                ),
                _buildPinCodeFields(context),
                const SizedBox(
                  height: 60,
                ),
                _buildVerifyButton(context),
                _buildPhoneVerificationBloc(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
