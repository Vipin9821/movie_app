import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/login_bloc/login_bloc.dart';
import 'package:movie_app/screens/sign_up_screen.dart';
import 'package:movie_app/widgets/login_form.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login-screen';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          image: DecorationImage(
            image: AssetImage('assets/poster.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.8),
          child: BlocListener<LoginBloc, LoginState>(
            bloc: BlocProvider.of<LoginBloc>(context),
            listener: (context, state) {
              print(state);
              if (state is LoggedInState) {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return HomeScreen();
                }), (route) => false);
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreen.routeName, (route) => false);
              }
    
              if (state is LoginErrorState) {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(
                      'Login Error',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: Text('${state.errorMessage}'),
                    actions: [
                      InkWell(
                        onTap: () {
                          BlocProvider.of<LoginBloc>(context)
                              .add(LoginCancelledEvent());
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 16,
                          ),
                          child: Text(
                            'Ok',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
              if (state is LoginLoadingState) {
                showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                        ),
                      );
                    });
              }

              if (state is SignUpScreenState) {
               Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context){
                 return SignUpScreen();
               }), (route) => false);
              }
            },
            child: _loginScreenContent(size, context),
          ),
        ),
      ),
    );
  }

  Widget _loginScreenContent(Size size, BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: SafeArea(
        child: Container(
          height: size.height * 0.9,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(),
              Spacer(),
              Image.asset(
                "assets/popcorn.png",
                // height: ,
                width: 300,
                alignment: Alignment.center,
              ),
              Spacer(
                flex: 3,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Signin here",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    // fontFamily: GoogleFonts.comfortaa().fontFamily
                    letterSpacing: 1,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              LoginForm(),
              // LoginButton(
              //   width: size.width * 0.8,
              //   height: 70,
              //   onTap: () {
              //     BlocProvider.of<LoginBloc>(context)
              //         .add(SignInWithGoogleEvent());
              //   },
              //   color: Colors.blue,
              //   // iconData: FontAwesomeIcons.google,
              //   label: 'Sign in with Google',
              // ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account? Register One!",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<LoginBloc>(context)
                            .add(ToggleSignUpEvent());
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
