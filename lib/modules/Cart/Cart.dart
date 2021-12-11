import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/models/shopmodel/CartGetModel.dart';
import 'package:learning/models/shopmodel/FavModel.dart';
import 'package:learning/shared/Cubit/Home/HomeCubit.dart';
import 'package:learning/shared/Cubit/Home/HomeStates.dart';
import 'package:learning/shared/compnents/component.dart';

class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit , HomeStates>(
      listener: (context , state) {},
      builder: (context , state) {
        var emailController = TextEditingController();

        return  Scaffold(
          appBar: AppBar(),

          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [

                SizedBox(height: 10,),
               // if (state is GetCartSucessState)
                  Expanded(
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => listProductBuilder1(context , HomeCubit.get(context).favoritesModel.data.data[index] , ),
                        separatorBuilder: (context, index) => SizedBox(height: 10,),
                        itemCount:  HomeCubit.get(context).favoritesModel.data.data.length
                    ),
                  ),
                if (state is GetCartLoadingState)
                  LinearProgressIndicator(),
              ],
            ),
          ),
          persistentFooterButtons: [
            defaultButton(onPress: ()
            {}, text: 'Pay')
          ],
        );
      },
    );
  }
}
Widget listProductBuilder1(context,  FavoritesData data , {bool isSearch = false}) => Container(
  height: 150,
  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        Stack(
          children: [
            Image(
              image: NetworkImage(data.product.image),
              width: 150,
              height: 150,
            ),
            if (data.product.discount != 0 && isSearch == false)
              Positioned(
                bottom: 5,
                child: Container(
                  width: 55,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.red,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 3, vertical: 1),
                    child: Text(
                      'DISCOUNT ${data.product.discount} %',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: Colors.white, fontSize: 7),
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                data.product.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.black, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    data.product.price.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Colors.black, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if (data.product.discount != 0 && isSearch == false)
                    Text(
                      data.product.oldPrice.toString(),
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: Colors.grey[400],
                          decoration: TextDecoration.lineThrough),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 10),
        //   child: InkWell(
        //       onTap: () {
        //          HomeCubit.get(context).changeCartmodel(data.id);
        //          HomeCubit.get(context).emit(CartIconSucessState());
        //       },
        //
        //       child: HomeCubit.get(context).cart[data.id] ? Icon(
        //         Icons.shopping_cart_sharp,
        //         size: 18,
        //         color: Colors.green,
        //       ) : Icon(
        //       Icons.shopping_cart_outlined,
        //       size: 18,
        //       color: Colors.grey,
        //     ),
        //
        //   ),

      ],
    ),
  ),
);