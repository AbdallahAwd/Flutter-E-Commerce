import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/modules/shopApp/login/login.dart';
import 'package:learning/shared/Cubit/Home/HomeCubit.dart';
import 'package:learning/shared/Cubit/Home/HomeStates.dart';
import 'package:learning/shared/compnents/component.dart';
import 'package:learning/shared/networking/lacal/cacheHelper.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is UpdateProfileSucessState )
          {
            var snackBar = SnackBar(content: Text(HomeCubit.get(context).userData.message), backgroundColor: Colors.green,);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }else if (state is UpdatePasswordSucessState)
            {
              var snackBar = SnackBar(content: Text(HomeCubit.get(context).changePasswordModel.message), backgroundColor: Colors.green,);
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
      },
      builder: (context, state) {
        var emailController = TextEditingController();
        var nameController = TextEditingController();
        var phoneController = TextEditingController();
        var currentPasswordController = TextEditingController();
        var newPasswordController = TextEditingController();
        emailController.text = HomeCubit.get(context).userData.data.email;
        nameController.text = HomeCubit.get(context).userData.data.name;
       phoneController.text = HomeCubit.get(context).userData.data.phone;
       phoneController.text = HomeCubit.get(context).userData.data.phone;
        return SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.grey,

                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person , size: 70,color: Colors.grey,),
                  ),
                ),
                SizedBox(height: 50,),
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
                ),SizedBox(
                  height: 20,
                ),
                defaultTextFormFeild(
                  controller: currentPasswordController,
                  KeyType: TextInputType.text,
                  pre: Icons.password_outlined,
                  HintText: 'Current Password',
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Password required';
                    }
                  },
                ),SizedBox(
                  height: 20,
                ),
                defaultTextFormFeild(
                  controller: newPasswordController,
                  KeyType: TextInputType.text,
                  pre: Icons.password_outlined,
                  HintText: 'New Password',
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Password required';
                    }
                  },
                  submit: (String value)
                  {
                    HomeCubit.get(context).postPasswordData(
                        currentPassword: currentPasswordController.text,
                        newPassword: newPasswordController.text);
                  }
                ),SizedBox(
                  height: 20,
                ),
                if(state is UpdateProfileLoadingState)
                  LinearProgressIndicator(),

                defaultButton(onPress: ()
                {
                  HomeCubit.get(context).updateUserData(
                    email: emailController.text,
                    name: nameController.text,
                    phone: phoneController.text,
                  );
                  HomeCubit.get(context).postPasswordData(
                    currentPassword: currentPasswordController.text,
                    newPassword: newPasswordController.text,
                  );
                }, text: 'Update' , ),
                SizedBox(height: 15,),
                defaultButton(onPress: ()
                {
                  CacheHelper.removeData('Token').then((value) {
                    navigateAnd(context, LogInScreen());
                  });
                }, text: 'logout' , defaultButtonColor: Colors.grey[400] ),


              ],
            ),
          ),
        );

      },
    );
  }
}




Widget Demo() => Container(
  width: double.infinity,
  height: 70,
  color: Colors.green,
  child: Text('ABDaaaaaaaaaaaaaaaaaaa'),
);
