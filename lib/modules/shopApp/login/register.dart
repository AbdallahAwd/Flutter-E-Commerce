import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/layout/shoplayout.dart';
import 'package:learning/modules/shopApp/login/login.dart';
import 'package:learning/shared/Cubit/Register/register.dart';
import 'package:learning/shared/Cubit/Register/registerStates.dart';
import 'package:learning/shared/compnents/component.dart';
import 'package:learning/shared/compnents/constants.dart';
import 'package:learning/shared/networking/lacal/cacheHelper.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    var formkey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is SucessState )
          {
            if(state.registerModel.status == true)
            {
              CacheHelper.saveData(key: 'Token', value: state.registerModel.data.token).then((value) {
                if (value == true) {
                  Token = state.registerModel.data.token;

                  navigateAnd(context, ShopLayout());
                }
              });
            }
            else
            {
              final snackBar = SnackBar(content: Text(state.registerModel.message));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(17),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text('Sign in', style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 22,),),
                        SizedBox(height: 30.0,),
                        Text(
                          'Sign into our App to browse hot offers', style: Theme
                            .of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 17),),
                        SizedBox(height: 30.0,),
                        defaultTextFormFeild(
                          controller: nameController,
                          KeyType: TextInputType.text,
                          pre: Icons.person_outline,
                          HintText: 'Full name',
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Full Name required';
                            }
                          },),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormFeild(
                          controller: emailController,
                          KeyType: TextInputType.text,
                          pre: Icons.email_outlined,
                          HintText: 'Email Address',
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Email Address required';
                            }
                          },
                        ), SizedBox(
                          height: 20,
                        ),
                        defaultTextFormFeild(
                          controller: phoneController,
                          KeyType: TextInputType.number,
                          pre: Icons.phone_android_outlined,
                          HintText: 'Phone Number',
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Phone Number required';
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormFeild(
                          HintText: 'Password',
                          pre: Icons.password_outlined,
                          KeyType: TextInputType.visiblePassword,
                          suff: RegisterCubit
                              .get(context)
                              .suffix,
                          suffPress: () {
                            RegisterCubit.get(context).chanegIcon();
                          },
                          isObscure: RegisterCubit.get(context).isAppear,
                          controller: passwordController,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Password is too short';
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormFeild(
                          HintText: 'Confirm Password',
                          pre: Icons.password_outlined,
                          KeyType: TextInputType.visiblePassword,
                          suff: RegisterCubit
                              .get(context)
                              .suffix,
                          suffPress: () {
                            RegisterCubit.get(context).chanegIcon();
                          },
                          isObscure: RegisterCubit.get(context).isAppear,
                          controller: confirmPasswordController,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Password is too short';
                            }
                          },
                        ),
                        SizedBox(height: 20,),
                        ConditionalBuilder(condition: state is! LoadingState,
                          builder: (context) =>
                            defaultButton(onPress: () {
                              if (formkey.currentState.validate()) {
                                RegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text);
                              }
                            },
                                text: 'sign in'),
                        fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have one?'),
                            SizedBox(
                              width: 10,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (context) =>
                                          LogInScreen()), (route) => false);
                                },
                                child: Text('Log in')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
