
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';


Widget defaultTextFormFeild({
  @required TextEditingController controller,
  @required IconData pre,
  @required String HintText,
  Function validate,
  var onChange,
  IconData suff,
  bool isObscure = false,
  @required var KeyType,
  Function suffPress,
  var submit,
}) =>
    TextFormField(
      keyboardType: KeyType,
      obscureText: isObscure,
      controller: controller,
      onChanged: onChange,
      onFieldSubmitted: submit,
      decoration: InputDecoration(
        prefixIcon: Icon(pre),
        suffixIcon: IconButton(onPressed: suffPress, icon: Icon(suff)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        labelText: HintText,
      ),
      validator: validate,
    );

  defaultButton({
  @required onPress,
  @required String text,
  double fontSize = 18,
    Color defaultFontColor = Colors.white,
    Color defaultButtonColor = Colors.amber,
})
  =>  Container(
    width: double.infinity,
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: MaterialButton(

      onPressed: onPress,
      color: defaultButtonColor,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: defaultFontColor , fontWeight: FontWeight.w700 , fontSize: fontSize),
      ),
    ),
  );

  Widget listBuilder(articles , context ,) => InkWell(
    onTap: ()
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => (articles['url'])));
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    '${articles['urlToImage']}'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          SizedBox(width: 10.0,),
          Expanded(
            child: Container(
              height: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${articles['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${articles['description']}',
                    style:Theme.of(context).textTheme.bodyText2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

Widget DataHandler(list,{isSearch = false})
=> ConditionalBuilder(
  condition: list.length > 0,
  builder: (context ) => ListView.separated(
       physics: BouncingScrollPhysics(),
      itemBuilder: (context , index) => listBuilder(list[index] , context),
      separatorBuilder: (context , index) => Divider(height: 1,color: Colors.grey,endIndent: 10,indent: 20,),
      itemCount: list.length,
  ),
  fallback: (context) =>isSearch ? Container() : Center(child: CircularProgressIndicator()),
);


 navigateTo(context , screen)
{
  return Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}
navigateAnd(context , screen)
{
  return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> screen), (route) => false);
}

// Widget listProductBuilder(context, Data) => Container(
//   height: 150,
//   child: Padding(
//     padding: const EdgeInsets.all(10.0),
//     child: Row(
//       children: [
//         Stack(
//           children: [
//             Image(
//               image: NetworkImage(Data.product.image),
//               width: 150,
//               height: 150,
//             ),
//             if (Data.product.discount != 0)
//               Positioned(
//                 bottom: 5,
//                 child: Container(
//                   width: 55,
//                   height: 10,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.rectangle,
//                     color: Colors.red,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 3, vertical: 1),
//                     child: Text(
//                       'DISCOUNT ${Data.product.discount} %',
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyText2
//                           .copyWith(color: Colors.white, fontSize: 7),
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//         SizedBox(
//           width: 15,
//         ),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Text(
//                 Data.product.name,
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyText2
//                     .copyWith(color: Colors.black, fontSize: 14),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Row(
//                 children: [
//                   Text(
//                     Data.product.price.toString(),
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyText2
//                         .copyWith(color: Colors.black, fontSize: 14),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   if (Data.product.discount != 0)
//                     Text(
//                       Data.product.oldPrice.toString(),
//                       style: Theme.of(context).textTheme.bodyText2.copyWith(
//                           color: Colors.grey[400],
//                           decoration: TextDecoration.lineThrough),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: InkWell(
//               onTap: () {
//                 // HomeCubit.get(context).changeCartmodel(Data.product.id);
//               },
// // HomeCubit.get(context).cart[Data.product.id]
//               child: Icon(
//                 Icons.shopping_cart_sharp,
//                 size: 18,
//                 color: Colors.green,
//               )
//               //     : Icon(
//               //   Icons.shopping_cart_outlined,
//               //   size: 18,
//               //   color: Colors.grey,
//               // )
//               ),
//         ),
//       ],
//     ),
//   ),
// );