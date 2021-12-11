import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/models/shopmodel/FavModel.dart';
import 'package:learning/modules/ProductDetail/ProductDetails.dart';
import 'package:learning/shared/Cubit/Home/HomeCubit.dart';
import 'package:learning/shared/Cubit/Home/HomeStates.dart';
import 'package:learning/shared/compnents/component.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! FavoriteLoadingState,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => FavoriteScreenBuilder(context,
                  HomeCubit.get(context).favoritesModel.data.data[index]),
              separatorBuilder: (context, index) => SizedBox(
                    height: 5,
                  ),
              itemCount:
                  HomeCubit.get(context).favoritesModel.data.data.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget FavoriteScreenBuilder(context, FavoritesData favoritesData) => InkWell(

  onTap: (){
    var ID = HomeCubit.get(context).productDetailsModel.data.id;
    if(ID == 56);
    {
      navigateTo(context, ProductDetails());
    }
  },
      child: Container(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Stack(
                children: [
                  Image(
                    image: NetworkImage(favoritesData.product.image),
                    width: 150,
                    height: 150,
                  ),
                  if (favoritesData.product.discount != 0)
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
                            'DISCOUNT ${favoritesData.product.discount} %',
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
                      favoritesData.product.name,
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
                          favoritesData.product.price.toString(),
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
                        if (favoritesData.product.discount != 0)
                          Text(
                            favoritesData.product.oldPrice.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                    onTap: () {
                      HomeCubit.get(context)
                          .changeFavoritesData(favoritesData.product.id);
                    },
                    child: HomeCubit.get(context)
                            .favourites[favoritesData.product.id]
                        ? Icon(
                            Icons.favorite,
                            size: 18,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.favorite_outline_rounded,
                            size: 18,
                            color: Colors.grey,
                          )),
              ),
            ],
          ),
        ),
      ),
    );
