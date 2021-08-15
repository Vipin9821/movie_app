import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/login_bloc/login_bloc.dart';
import 'package:movie_app/widgets/login_button.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  _validateForm() {
    final _isValid = _formKey.currentState.validate();
    if (!_isValid) {
      return;
    } else {
      BlocProvider.of<LoginBloc>(context).add(NewUserRegistrationEvent(
        email: _emailcontroller.text,
        pass: _passwordController.text,
      ));
    }
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
         
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailcontroller,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your Email',
              ),
              validator: (val) {
                if (val.length < 2 &&
                    !val.contains('@') &&
                    !val.contains('.')) {
                  return 'Enter valid email';
                }
                return null;
              },
            ),
       
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter password',
              ),
              validator: (val) {
                if (val.length < 8) {
                  return 'Password length must be greater than 8.';
                }
                return null;
              },
            ),
            SizedBox(
              height: 25,
            ),
            LoginButton(
              width: 120,
              height: 50,
              onTap: _validateForm,
              color: Colors.orange,
              textColor: Colors.black,
              // iconColor: Colors.black,
              // iconData: FontAwesomeIcons.google,
              label: 'Sign up',
            ),
          ],
        ),
      ),
    );
  }
}
