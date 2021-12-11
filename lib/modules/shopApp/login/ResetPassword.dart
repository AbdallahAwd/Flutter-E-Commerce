import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/modules/shopApp/login/VerifyCode&Reset.dart';
import 'package:learning/shared/Cubit/logIn/loginCubit.dart';
import 'package:learning/shared/Cubit/logIn/shoploginstate.dart';
import 'package:learning/shared/compnents/component.dart';

class ResetPassword extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    return BlocConsumer<LoginCubit , ShopLoginStates >(
      listener: (context , state) {
        if(state is ResetSucessState)
          {
            final snackBar = SnackBar(content: Text(state.changePasswordModel.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
      },
      builder: (context , state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Forget Password' , style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black
                ),),
                SizedBox(
                  height: 15.0,
                ),
                Text('If you forget your password type your email down their to verify your email' , style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey
                ),),
                SizedBox(
                  height: 25.0,
                ),
                defaultTextFormFeild(
                  HintText: 'Email Address',
                  pre: Icons.email_outlined,
                  KeyType: TextInputType.emailAddress,
                  controller: emailController,
                  validate: (String value)
                  {
                    if(value.isEmpty)
                    {
                      return 'Email Address must not be Empty !';
                    }
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),

                defaultButton(onPress: ()
                {
                  LoginCubit.get(context).verifyEmail(emailController.text);
                  navigateTo(context, VerifyCode());
                }, text: 'Send Code'),
                SizedBox(
                  height: 20.0,
                ),


              ],
            ),
          ),
        );
      },
    );
  }
}
