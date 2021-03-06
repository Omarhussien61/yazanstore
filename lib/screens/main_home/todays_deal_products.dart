// import 'package:flutter/material.dart';
// import 'package:active_ecommerce_flutter/my_theme.dart';
// import 'package:active_ecommerce_flutter/ui_elements/product_card.dart';
// import 'package:active_ecommerce_flutter/repositories/product_repository.dart';
// import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
//
// class TodaysDealProducts extends StatefulWidget {
//
//   @override
//   _TodaysDealProductsState createState() => _TodaysDealProductsState();
// }
//
// class _TodaysDealProductsState extends State<TodaysDealProducts> {
//
//   ScrollController _scrollController;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: buildAppBar(context),
//       body: buildProductList(context),
//     );
//   }
//
//   AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       centerTitle: true,
//       leading: Builder(
//         builder: (context) => IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.dark_grey),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       title: Text(
//         "Today's Deal",
//         style: TextStyle(fontSize: 16, color: Colors.accent_color),
//       ),
//       elevation: 0.0,
//       titleSpacing: 0,
//     );
//   }
//
//   buildProductList(context) {
//     return FutureBuilder(
//         future: ProductRepository().getTodaysDealProducts(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             //snapshot.hasError
//             /*print("product error");
//             print(snapshot.error.toString());*/
//           return Container();
//           } else if (snapshot.hasData) {
//             var productResponse = snapshot.data;
//             return SingleChildScrollView(
//               child: GridView.builder(
//                 // 2
//                 //addAutomaticKeepAlives: true,
//                 itemCount: productResponse.products.length,
//                 controller: _scrollController,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                     childAspectRatio: 0.618),
//                 padding: EdgeInsets.all(16),
//                 physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   // 3
//                   return ProductCard(
//                     id: productResponse.products[index].id,
//                     image: productResponse.products[index].photo,
//                     name: productResponse.products[index].name,
//                     price: productResponse.products[index].price,
//                   );
//                 },
//               ),
//             );
//           } else {
//             return ShimmerHelper()
//                 .buildProductGridShimmer(scontroller: _scrollController);
//           }
//         });
//   }
//
// }
//
