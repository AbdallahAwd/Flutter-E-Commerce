import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/models/ProductModel.dart';
import 'package:learning/models/shopmodel/homeModel.dart';
import 'package:learning/shared/Cubit/Home/HomeCubit.dart';
import 'package:learning/shared/Cubit/Home/HomeStates.dart';
import 'package:learning/shared/compnents/component.dart';

class ProductDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit , HomeStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: DetailedProduct(context , HomeCubit.get(context).productDetailsModel),
            ),
          ),
          persistentFooterButtons: [
            defaultButton(onPress: (){}, text: 'Add to Favorites'),
            SizedBox(height: 10,),
          ],
        );
      },
    );
  }
}
Widget DetailedProduct(context , ProductDetailsModel productDetailsModel) => SingleChildScrollView(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 30,
      ),
      Stack(
        children: [
          Image(
            image: NetworkImage('${productDetailsModel.data.image}'),
            height: 380,
            width: double.infinity,
          ),
          if(productDetailsModel.data.discount != 0)
          Positioned(
            bottom: 50,
            child: Container(
              height: 15,
              width: 70,
              color: Colors.red,
              child: Text(' Discount ${productDetailsModel.data.discount}%' , style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        ' ${productDetailsModel.data.name}',
        style: Theme.of(context).textTheme.bodyText1.copyWith(),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Text(
            '   ${productDetailsModel.data.price}',
            style: Theme.of(context).textTheme.bodyText1.copyWith(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            width: 10,
          ),
          if(productDetailsModel.data.discount != 0)
            Text(
            '    ${productDetailsModel.data.oldPrice}',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Colors.grey,
                decoration: TextDecoration.lineThrough),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        'Description',
        style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 30),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        '${productDetailsModel.data.description}',
        style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 15),
        maxLines: 30,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  ),
);