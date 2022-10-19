import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omar_ahmed_maps/business_logic/phone_auth/phone_auth_cubit.dart';
import 'package:omar_ahmed_maps/constants/strings.dart';
import 'package:omar_ahmed_maps/presentation/screens/login_screen.dart';
import 'package:omar_ahmed_maps/presentation/screens/map_screen.dart';
import 'package:omar_ahmed_maps/presentation/screens/otp_screen.dart';

class AppRouter {
  AuthCubit? authCubit;
  AppRouter() {
    authCubit = AuthCubit();
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mapScreen:
        return MaterialPageRoute(
          builder: (_) => const MapScreen(),
        );

      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<AuthCubit>.value(
            value: authCubit!,
            child: LoginScreen(),
          ),
        );

      case otpScreen:
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<AuthCubit>.value(
            value: authCubit!,
            child: OtpScreen(phoneNumber: phoneNumber),
          ),
        );
    }
    return null;
  }
}
