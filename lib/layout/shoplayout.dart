
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/modules/Cart/Cart.dart';
import 'package:learning/modules/Search/SearchScreen.dart';
import 'package:learning/modules/shopApp/login/login.dart';
import 'package:learning/shared/Cubit/Home/HomeCubit.dart';
import 'package:learning/shared/Cubit/Home/HomeStates.dart';
import 'package:learning/shared/compnents/component.dart';
import 'package:learning/shared/networking/lacal/cacheHelper.dart';

class ShopLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit , HomeStates>(
      listener: (context , state) {},
      builder: (context , state)
      {
        HomeCubit cubit = HomeCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(onPressed: ()
              {
                navigateTo(context, SearchScreen());
              }, icon: Icon(Icons.search)),
              IconButton(onPressed: ()
              {
                navigateTo(context, CartScreen());
              }, icon: Icon(Icons.shopping_cart_outlined)),


            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar:BottomNavigationBar(
            items: cubit.items,
            unselectedLabelStyle:  TextStyle(
                color: Colors.black
            ),
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeNav(index);
            },
          ),

        );
      },
    );
  }
}
