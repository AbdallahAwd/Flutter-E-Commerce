import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/modules/shopApp/login/login.dart';
import 'package:learning/shared/Cubit/logIn/loginCubit.dart';
import 'package:learning/shared/Cubit/logIn/shoploginstate.dart';
import 'package:learning/shared/compnents/component.dart';

class VerifyCode extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, ShopLoginStates>(
      listener: (context, state) {
        if (state is ResetPSucessState)
          {
            final snackBar = SnackBar(content: Text(state.changePasswordModel.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
      },
      builder: (context, state) {
        var emailController = TextEditingController();
        var passwordController = TextEditingController();
        var codeController = TextEditingController();
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Verify Code', style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black
                ),),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'Your\'ve received an email with the code complete all information and log in with it again ',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey
                  ),),
                SizedBox(
                  height: 15.0,
                ),
                defaultTextFormFeild(
                  HintText: 'Email Address',
                  pre: Icons.email_outlined,
                  KeyType: TextInputType.emailAddress,
                  controller: emailController,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Email Address must not be Empty !';
                    }
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultTextFormFeild(
                  HintText: 'Code',
                  pre: Icons.code,
                  KeyType: TextInputType.number,
                  controller: codeController,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Email Address must not be Empty !';
                    }
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultTextFormFeild(
                  HintText: 'New Password',
                  pre: Icons.password,
                  KeyType: TextInputType.text,
                  controller: passwordController,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Email Address must not be Empty !';
                    }
                  },
                ), SizedBox(
                  height: 20.0,
                ),
                defaultButton(onPress: () {
                  LoginCubit.get(context).resetPassword(
                      email: emailController.text,
                      code: codeController.text,
                      password: passwordController.text,
                  );
                  if (state is ResetPSucessState)
                  {
                        navigateTo(context, LogInScreen());
                  }
                    }, text: 'Verify')

              ],
            ),
          ),
        );
      },
    );
  }
}
