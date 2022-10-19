import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omar_ahmed_maps/business_logic/phone_auth/phone_auth_cubit.dart';
import 'package:omar_ahmed_maps/constants/strings.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  AuthCubit authCubit = AuthCubit();

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: BlocProvider<AuthCubit>(
        create: (context) => authCubit,
        child: ElevatedButton(
          onPressed: () async {
            await authCubit.logOut();
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushReplacementNamed(loginScreen);
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
      ),
    );
  }
}
