import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/splash_bloc/splash_bloc.dart';
import 'package:movie_app/screens/home_screen.dart';

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  static const routeName = '/splash-screen';
  SplashBloc _bloc = SplashBloc();
  @override
  Widget build(BuildContext context) {
    _bloc.add(OnBoardStatus());
    return Scaffold(
      body: SafeArea(
        child: BlocListener<SplashBloc, SplashState>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is InitiateHomeState) {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.routeName, (route) => false);
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('assets/image1.png'),
              Spacer(
                flex: 2,
              ),
              Spacer(
                flex: 2,
              ),
              Text(
                'Moviesto',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 35,
              ),
              CircularProgressIndicator(
                strokeWidth: 1,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
