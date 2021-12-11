import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/layout/shoplayout.dart';
import 'package:learning/modules/shopApp/login/ResetPassword.dart';
import 'package:learning/modules/shopApp/login/register.dart';
import 'package:learning/shared/Cubit/logIn/loginCubit.dart';
import 'package:learning/shared/Cubit/logIn/shoploginstate.dart';
import 'package:learning/shared/compnents/component.dart';
import 'package:learning/shared/compnents/constants.dart';
import 'package:learning/shared/networking/lacal/cacheHelper.dart';

class LogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<LoginCubit, ShopLoginStates>(
        listener: (context, state) {

          if(state is ShopLoginSuccessState )
            {
              if(state.loginModel.status == true)
              {

                CacheHelper.saveData(key: 'Token', value: state.loginModel.data.token).then((value) {
                  if (value != null) {
                    Token = state.loginModel.data.token;
                    navigateAnd(context, ShopLayout());
                  }
                });

              }
              else
                {
                  final snackBar = SnackBar(content: Text(state.loginModel.message));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
            }
      },
        builder: (context, state) {

          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45.0),
                        child: Image(
                          image: AssetImage('assets/login.png'),
                          height: 300,
                          width: 300,
                        ),
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
                      defaultTextFormFeild(
                        HintText: 'Password',
                        pre: Icons.password_outlined,
                        KeyType: TextInputType.visiblePassword,
                        suff: LoginCubit.get(context).suffix,
                        suffPress: ()
                        {
                          LoginCubit.get(context).chanegIcon();
                        },
                        submit: (value)
                        {
                        if (formKey.currentState.validate()) {
                            LoginCubit.get(context).userLogin(
                            email: emailController.text,
                            password: passwordController.text);
                          }},
                            isObscure: LoginCubit.get(context).isAppear,
                            controller: passwordController,
                            validate: (String value)
                        {
                          if(value.isEmpty)
                            {
                              return 'Password is too short';
                            }
                        },
                      ),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {

                                navigateTo(context, ResetPassword());
                              },
                              child: Text('Forget Password ?' , style: TextStyle(decoration: TextDecoration.underline),)),
                        ],
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        width: double.infinity,
                        child: ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                            text: 'login',
                            onPress: () {
                              if (formKey.currentState.validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);

                              }
                            },
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account ?'),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                navigateTo(context, RegisterScreen());
                              },
                              child: Text('Sign in')),
                        ],
                      ),
                      Text('OR'),
                      SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        children: [
                          CircleAvatar(
                            child:
                                Image(image: AssetImage('assets/facebook.png')),
                            radius: 40,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          CircleAvatar(
                            child:
                                Image(image: AssetImage('assets/google.png')),
                            radius: 40,
                            backgroundColor: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },

    );
  }
}
