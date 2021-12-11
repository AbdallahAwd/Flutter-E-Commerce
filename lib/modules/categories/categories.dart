import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/models/shopmodel/CategoriesModel.dart';
import 'package:learning/shared/Cubit/Home/HomeCubit.dart';
import 'package:learning/shared/Cubit/Home/HomeStates.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit , HomeStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        return ListView.separated(
            itemBuilder: (context , index) => builder(HomeCubit.get(context).categoriesModel.data.data[index]) ,
            separatorBuilder: (context , index) => SizedBox(height: 5,),
            itemCount: HomeCubit.get(context).categoriesModel.data.data.length
        );
      },
    );
  }
Widget builder(DataModel dataModel)
  => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(dataModel.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 20,),
        Text(dataModel.name , style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),),
        Spacer(),

        Icon(Icons.keyboard_arrow_right_rounded)
      ],
    ),
  );
}
