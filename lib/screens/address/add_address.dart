import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/model/area_model.dart';
import 'package:flutter_pos/model/city_model.dart';
import 'package:flutter_pos/model/country_model.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../model/shipping_address.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key key}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final _formKey = GlobalKey<FormState>();
  Address address = new Address();
  List<Country> contries;
  List<City> cities;
  List<Area> area;
  TextEditingController code= TextEditingController();
  @override
  void initState() {
    getCountry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/User Icon.svg",
              color: Colors.white,
              height: 25,
            ),
            SizedBox(
              width: 10,
            ),
            Text(getTransrlate(context, 'MyAddress')),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getTransrlate(context, 'AddNewAddress'),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextFormField(
                  intialLabel: ' ',
                  keyboard_type: TextInputType.name,
                  labelText: getTransrlate(context, 'Firstname'),
                  hintText: getTransrlate(context, 'Firstname'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'Firstname');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    address.recipientName = value;
                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  keyboard_type: TextInputType.text,
                  labelText: getTransrlate(context, 'Lastname'),
                  hintText: getTransrlate(context, 'Lastname'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'Lastname');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    address.lastName = value;
                  },
                ),
                SizedBox(
                  height: 5,
                ),

                Text(
                  getTransrlate(context, 'Countroy'),
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                contries==null? Container(
                  child: DropdownSearch<String>(
                    showSearchBox: false,
                    showClearButton: false,
                    label: " ",
                    items: [''],
                    enabled: false,
                    //  onFind: (String filter) => getData(filter),
                  ),
                ):Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: DropdownSearch<Country>(
                    showSearchBox: true,
                    // label: getTransrlate(context, 'Countroy'),
                    validator: (Country item) {
                      if (item == null) {
                        return "Required field";
                      } else
                        return null;
                    },

                    items: contries,
                    //  onFind: (String filter) => getData(filter),
                    itemAsString: (Country u) => u.countryName,
                    onChanged: (Country data) {
                      print(data.id);
                      address.Country_id = data.id;
                        code.text=data.phonecode.toString();
                       setState(() {
                         area=null;
                         cities=null;
                       });
                      getArea(data.id);

                    },
                  ),
                ),
                area==null? Container(
                  child: DropdownSearch<String>(
                    showSearchBox: false,
                    showClearButton: false,
                    label: " ",
                    items: [''],
                    enabled: false,
                    //  onFind: (String filter) => getData(filter),
                  ),
                ):Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: DropdownSearch<Area>(
                    showSearchBox: true,
                    validator: (Area item) {
                      if (item == null) {
                        return "Required field";
                      } else
                        return null;
                    },

                    items: area,
                    //  onFind: (String filter) => getData(filter),
                    itemAsString: (Area u) => u.areaName,
                    onChanged: (Area data) {
                      address.area_id = data.id;
                      print(data.id);

                      setState(() {
                        cities=null;
                      });
                      getCity(data.id);

                    },
                  ),
                ),
                cities==null? Container(
                  child: DropdownSearch<String>(
                    showSearchBox: false,
                    showClearButton: false,
                    label: " ",
                    items: [''],
                    enabled: false,
                    //  onFind: (String filter) => getData(filter),
                  ),
                ):Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: DropdownSearch<City>(
                    showSearchBox: true,
                    validator: (City item) {
                      if (item == null) {
                        return "Required field";
                      } else
                        return null;
                    },

                    items: cities,
                    //  onFind: (String filter) => getData(filter),
                    itemAsString: (City u) => u.cityName,
                    onChanged: (City data) {
                      print(data.id);

                      address.city_id = data.id;
                    } ,
                  ),
                ),
                MyTextFormField(
                  intialLabel: '',
                  keyboard_type: TextInputType.emailAddress,
                  labelText: getTransrlate(context, 'district'),
                  hintText: getTransrlate(context, 'district'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'district');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    address.district = value;
                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  keyboard_type: TextInputType.emailAddress,
                  labelText: getTransrlate(context, 'Street'),
                  hintText: getTransrlate(context, 'Street'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'Street');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    address.street = value;
                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  keyboard_type: TextInputType.number,
                  labelText: getTransrlate(context, 'HomeNo'),
                  hintText: getTransrlate(context, 'HomeNo'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'HomeNo');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    address.homeNo = value;
                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  keyboard_type: TextInputType.number,
                  labelText: getTransrlate(context, 'FloorNo'),
                  hintText: getTransrlate(context, 'FloorNo'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'FloorNo');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    address.floorNo = value;
                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  keyboard_type: TextInputType.number,
                  labelText: getTransrlate(context, 'apartment_no'),
                  hintText: getTransrlate(context, 'apartment_no'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'apartment_no');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    address.apartmentNo = value;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: ScreenUtil.getWidth(context)/1.5 ,
                      child: MyTextFormField(
                        textDirection: TextDirection.ltr,

                        intialLabel: '',
                        keyboard_type: TextInputType.phone,
                        labelText: getTransrlate(context, 'phone'),
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(14),
                        ],
                        hintText: getTransrlate(context, 'phone'),
                        isPhone: true,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return getTransrlate(context, 'phone');
                          }
                          _formKey.currentState.save();
                          return null;
                        },
                        onSaved: (String value) {
                          address.recipientPhone ="+${code.text}$value";
                        },
                      ),
                    ),
                    Container(
                      width: ScreenUtil.getWidth(context)*0.2 ,
                      child: MyTextFormField(
                        textDirection: TextDirection.ltr,

                        enabled: false,
                        controller: code,
                        keyboard_type: TextInputType.phone,
                        labelText: getTransrlate(context, 'CountroyCode'),
                        hintText: getTransrlate(context, 'CountroyCode'),
                        isPhone: true,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return getTransrlate(context, 'CountroyCode');
                          }
                          _formKey.currentState.save();
                          return null;
                        },
                        onSaved: (String value) {
                          //address.recipientPhone = value;
                        },
                      ),
                    ),
                  ],
                ),
                MyTextFormField(
                  intialLabel: '',
                  textDirection: TextDirection.ltr,
                  keyboard_type: TextInputType.phone,
                  labelText: getTransrlate(context, 'telphone'),
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(14),
                  ],
                  hintText: getTransrlate(context, 'telphone'),
                  isPhone: true,
                  onSaved: (String value) {
                    address.telephoneNo = value;
                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  keyboard_type: TextInputType.emailAddress,
                  labelText: getTransrlate(context, 'nearest_milestone'),
                  hintText: getTransrlate(context, 'nearest_milestone'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'nearest_milestone');
                    } else if (value.length > 250) {
                      return "Over length";
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    address.nearestMilestone = value;
                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  keyboard_type: TextInputType.emailAddress,
                  labelText: getTransrlate(context, 'OrderNote'),
                  hintText: getTransrlate(context, 'OrderNote'),
                  isPhone: true,
                  onSaved: (String value) {
                    address.notices = value;
                  },
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: GestureDetector(
                        child: Container(
                          width: ScreenUtil.getWidth(context) / 2.5,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange)),
                          child: Center(
                            child: AutoSizeText(
                              getTransrlate(context, 'save'),
                              overflow: TextOverflow.ellipsis,
                              maxFontSize: 14,
                              maxLines: 1,
                              minFontSize: 10,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange),
                            ),
                          ),
                        ),
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            print( address.toJson());
                            API(context)
                                .post('user/add/shipping', address.toJson())
                                .then((value) {
                              if (value != null) {
                                if (value['status_code'] == 201) {
                                  Navigator.pop(context);
                                  showDialog(
                                      context: context,
                                      builder: (_) =>
                                          ResultOverlay("${value['message']}"));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (_) => ResultOverlay(
                                          '${value['message'] ?? ''}'));
                                }
                              }
                            });
                          }
                        },
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        child: Container(
                          width: ScreenUtil.getWidth(context) / 2.5,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Center(
                            child: AutoSizeText(
                              getTransrlate(context, 'close'),
                              overflow: TextOverflow.ellipsis,
                              maxFontSize: 14,
                              maxLines: 1,
                              minFontSize: 10,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getCity(int id) {
    API(context).get('cities/list/all/$id').then((value) {
      setState(() {
        cities=City_model.fromJson(value).data;
      });
    });

  }
  void getArea(int id) {
    API(context).get('areas/list/all/$id').then((value) {
      setState(() {
        area=Area_model.fromJson(value).data;
      });
    });

  }
  void getCountry() {
    API(context).get('countries/list/all').then((value) {
      setState(() {
        contries=Country_model.fromJson(value).data;

      });
    });

  }
}
