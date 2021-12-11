import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/models/shopmodel/CategoriesModel.dart';
import 'package:learning/models/shopmodel/homeModel.dart';
import 'package:learning/modules/ProductDetail/ProductDetails.dart';

import 'package:learning/shared/Cubit/Home/HomeCubit.dart';
import 'package:learning/shared/Cubit/Home/HomeStates.dart';
import 'package:learning/shared/compnents/component.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if(state is IconErrorChangeState ||state is CartIconErrorState )
          {
            var snackBar = SnackBar(content: Text('Not Authorized') , backgroundColor: Colors.red,);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        else if( state is CartSucessState)
            {
              var snackBar = SnackBar(content: Text(HomeCubit.get(context).changeCartModel.message) , backgroundColor: Colors.green,);
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit
              .get(context)
              .homeModel != null,
          builder: (context) =>
              bannerList(HomeCubit.get(context).homeModel,HomeCubit.get(context).categoriesModel , context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget bannerList(HomeModel homeModel,CategoriesModel categoriesModel , context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CarouselSlider(
              items: homeModel.data.banners.map(
                    (e) =>
                    Image(
                      image: NetworkImage('${e.image}'),
                      height: 250.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              ).toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayInterval: Duration(seconds: 5),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('New Categories', style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 25.0, fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => categoriesBuilder(categoriesModel.data.data[index]),
                      separatorBuilder: (context, index) => SizedBox(width: 8,),
                      itemCount: categoriesModel.data.data.length
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text('New Products', style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 25.0, fontWeight: FontWeight.bold),),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 1.3,
                crossAxisSpacing: 0.5,
                childAspectRatio: 1 / 1.40,
                children: List.generate(
                    homeModel.data.products.length,
                        (index) =>
                        productBuilder(
                            homeModel.data.products[index], context)),
              ),
            ),
          ],
        ),
      );
}

Widget productBuilder(ProductModel productModel, context) =>
    InkWell(
      onTap: (){
        if(HomeCubit.get(context).productDetailsModel.data.id == 56);
        {
          navigateTo(context, ProductDetails());
        }
      },
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: NetworkImage(productModel.image),
                    width: double.infinity,
                    height: 200,
                    // fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    productModel.name,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(
                      color: Colors.grey[800],
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Text(productModel.price.toString(),
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.grey[700])),
                        SizedBox(
                          width: 10,
                        ),
                        if (productModel.discount != 0)
                          Text(productModel.oldPrice.toString(),
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                  color: Colors.grey[400],
                                  decoration: TextDecoration.lineThrough)),

                        Expanded(
                            child: InkWell(
                                onTap: () {
                                  HomeCubit.get(context).changeFavoritesData(productModel.id);
                                },
                                child: HomeCubit.get(context).favourites[productModel.id] ? Icon(
                                  Icons.favorite,
                                  size: 18,
                                  color: Colors.red,
                                ) : Icon(
                                  Icons.favorite_outline_rounded,
                                  size: 18,
                                  color: Colors.grey,
                                ))),
                        Expanded(
                            child: InkWell(
                                onTap: () {
                                   HomeCubit.get(context).changeCartmodel(productModel.id);
                                },
                                child: HomeCubit.get(context).cart[productModel.id] ? Icon(
                                  Icons.shopping_cart_sharp,
                                  size: 18,
                                  color: Colors.green,
                                ) : Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 18,
                                  color: Colors.grey,
                                ))),
                      ],
                    ),
                  ),
                ],
              ),
              if (productModel.discount != 0)
                Positioned(
                  bottom: 55,
                  child: Container(
                    width: 55,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.red,
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                      child: Text(
                        'DISCOUNT ${productModel.discount}%',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Colors.white, fontSize: 7),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );


Widget categoriesBuilder(DataModel dataModel) =>
Stack(
  alignment: Alignment.bottomCenter,
  children: [
        Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(dataModel.image),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      color : Colors.black.withOpacity(0.5),
      width: 100,
      child: Text(dataModel.name , style: TextStyle(
        color:Colors.white,
        fontSize: 14,
      ),
        textAlign: TextAlign.center,
      ),
    )

  ],
);