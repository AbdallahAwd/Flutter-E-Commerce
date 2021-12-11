import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/models/shopmodel/Search.dart';

import 'package:learning/shared/Cubit/Search/SearchStates.dart';
import 'package:learning/shared/Cubit/Search/searchCubit.dart';
import 'package:learning/shared/compnents/component.dart';

class SearchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultTextFormFeild(
                      HintText: 'Search',
                      pre: Icons.search,
                      KeyType: TextInputType.emailAddress,
                      controller: searchController,
                      submit: (String text)
                      {
                        if(formKey.currentState.validate())
                        {
                          SearchCubit.get(context).postSearch(text);
                        }

                      },
                      validate: (String value) {
                        if (value.isEmpty) {
                          return ' must not be Empty !';
                        }
                      },
                    ),
                    SizedBox(height: 10,),
                    if (state is Success)
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => listProductBuilder(context , SearchCubit.get(context).searchModel.data.data[index] , isSearch: true),
                          separatorBuilder: (context, index) => SizedBox(height: 10,),
                          itemCount:  SearchCubit.get(context).searchModel.data.data.length
                      ),
                    ),
                    if (state is Loading)
                      LinearProgressIndicator(),
                  ],
                ),
              ),
            ),
            // persistentFooterButtons: [
            //   defaultButton(onPress: (){}, text: 'Cart')
            // ],
          );
        },
      ),
    );
  }
}
Widget listProductBuilder(context,  data , {bool isSearch = false}) => Container(
  height: 150,
  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        Stack(
          children: [
            Image(
              image: NetworkImage(data.image),
              width: 150,
              height: 150,
            ),
            if (data.discount != 0 && isSearch == false)
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
                      'DISCOUNT ${data.discount} %',
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
                data.name,
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
                    data.price.toString(),
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
                  if (data.discount != 0 && isSearch == false)
                    Text(
                      data.oldPrice.toString(),
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