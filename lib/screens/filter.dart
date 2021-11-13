import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/screens/product/Filter.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/List/listview.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/no_found_product.dart';
import 'package:provider/provider.dart';

class Filter extends StatefulWidget {
  const Filter({Key key}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<Product> products = [];
  FocusNode _focusNode = FocusNode();
  String _selectedFilter="product";
  String _selectedSort="price_asc";

  String search_index;
@override
  void initState() {

  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Scaffold(
      appBar: AppBar(title: Text(getTransrlate(context, 'filter')),centerTitle: true,),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Container(
                      height: 40,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: "  ${getTransrlate(context, 'search')}",
                            contentPadding: EdgeInsets.all(5.0),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: themeColor.getColor(),
                                width: 1.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: themeColor.getColor(),
                                width: 1.0,
                              ),
                            ),
                            filled: true,
                          ),
                          onChanged: (string) {
                            search_index = string;
                            getSearch(search_index);

                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              buildBottomAppBar(context),

              products.isEmpty
                  ? NotFoundProduct()
                  : List_product(
                      product: products,
                      ctx: context,
                    )
            ],
          ),
        ),
      ),
    );
  }
  Row buildBottomAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.symmetric(
                  vertical: BorderSide(color:Colors.black12, width: .5),
                  horizontal: BorderSide(color: Colors.black12, width: 1))),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          height: 36,
          width:ScreenUtil.getWidth(context)/3.2,
          child:  DropdownButton<dynamic>(
            icon: Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Icon(Icons.expand_more, color: Colors.black54),
            ),
            hint: Text(
              "${getTransrlate(context, 'product')}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            iconSize: 14,
            underline: SizedBox(),
            value: _selectedFilter,
            items: [buildDropdown("product",getTransrlate(context, "product")),buildDropdown("sellers",getTransrlate(context, "sellers")),buildDropdown("brands",getTransrlate(context, "brands"))],
            onChanged: ( selectedFilter) {
              setState(() {
                _selectedFilter = selectedFilter;
              });
              getSearch(search_index);

            },
          ),
        ),
        GestureDetector(
          onTap: () {

          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.symmetric(
                    vertical: BorderSide(color: Colors.black12, width: .5),
                    horizontal:
                    BorderSide(color: Colors.black12, width: 1))),
            height: 36,
            width: MediaQuery.of(context).size.width * .33,
            child: Center(
                child: InkWell(
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (_) =>
                            Filterdialog()).then((value) => {
                              print(value),
                      getSearch("${search_index}$value")
                    });
                  },
                  child: Container(
                    width: 50,
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_alt_outlined,
                          size: 13,
                        ),
                        SizedBox(width: 2),
                        Text(
                          "${getTransrlate(context, 'filter')}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.symmetric(
                  vertical: BorderSide(color:Colors.black12, width: .5),
                  horizontal: BorderSide(color: Colors.black12, width: 1))),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          height: 36,
          width:ScreenUtil.getWidth(context)/3.2,
          child:  DropdownButton<dynamic>(
            icon: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Icon(Icons.swap_vert, color: Colors.black54),
            ),
            hint: Text(
              "${getTransrlate(context, 'Sort')}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            iconSize: 14,
            underline: SizedBox(),
            value: _selectedSort,
            items: [buildDropdown("price_desc",getTransrlate(context, "SortByPricemore")),buildDropdown("price_asc",getTransrlate(context, "SortByPriceLess")),buildDropdown("date_asc",getTransrlate(context, "SortByold")),buildDropdown("date_desc",getTransrlate(context, "SortByNew"))],
            onChanged: ( selectedFilter) {
              setState(() {
                _selectedSort = selectedFilter;
              });
              getSearch(search_index);

            },
          ),
        ),

      ],
    );
  }
  DropdownMenuItem buildDropdown(
      String value,String item) {

    return DropdownMenuItem(
      value: value,
      child: Center(
        child: Text(item,style:  TextStyle(
          color: Colors.black,
          fontSize: 13,
        ),),
      ),
    );
  }

  void getSearch(String search_index) {
    if (search_index.length >= 1) {
      API(context)
          .get(
        'productss/search?search=$search_index&sort=$_selectedSort',
      )
          .then((value) {
        if (value != null) {
          if (value['status_code'] == 200) {
            setState(() {
              products = ProductModel.fromJson(
                  value['data'])
                  .products;
            });
          } else {
            showDialog(
                context: context,
                builder: (_) => ResultOverlay(
                    "${value['message']}"));
          }
        }
      });
    } else {
      setState(() {
        products = [];
      });
    }
  }
}
