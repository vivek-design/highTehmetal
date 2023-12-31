import 'package:basic/InvoiceManager/dataupdate.dart';

import 'package:connectivity/connectivity.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:basic/Uitilities/auth.dart';
import 'package:basic/Uitilities/col.dart';
import 'package:basic/Uitilities/router.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';




import 'package:input_quantity/input_quantity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Uitilities/nointernet.dart';

class Invoice_front extends StatefulWidget {
  const Invoice_front({super.key});

  @override
  State<Invoice_front> createState() => _Invoice_frontState();
}

class _Invoice_frontState extends State<Invoice_front> {
  String selected_customer = 'Select Customer';

  String selected_item = 'Select Item';

  // List of items in our dropdown menu
  List<String> customer = [
    'Select Customer',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  var products = ['Select Item'];
  Map<String, List<String>> mp = {};

  List<Item> item = [
    Item('-', 0),
  ];

  int quatity_count = 0;
  bool isremoved = false;

  late DatabaseReference _orderRef;

  Future<bool> getCustomer() async {
    _orderRef = FirebaseDatabase.instance
        .ref()
        .child('AppData1nG3AefClW3j4Y5ZqwX76Ba9x2VV5axcOWlRMFflh8Hg');
    await _orderRef.onValue.listen((event) {
      customer.clear();
      // customer.add('Select Customer');
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? data =
            event.snapshot.value as Map<dynamic, dynamic>?;
        data?.forEach((orderKey, orderData) {
          
          customer.add(orderKey.toString());
          List<String> will_add = [];

      

          orderData?.forEach((value) {
            if (value != null) {
        

              String a = value['Item No'].toString() +
                  "  " +
                  value['Item Description'].toString();
              will_add.add(a);
            }
          });

          mp[orderKey.toString()] = will_add;
        });
      }
      
    });

    await Future.delayed(Duration(seconds: 2));

    return true;
  }

  @override
  void initState() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        // Navigate to NoInternetPage if there is no internet connection
       
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) {
          return No_internet();
        })));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var heigh = size.height;
    var widt = size.width;

    return FutureBuilder(
        future: getCustomer(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Center(
                    child: Row(
                  children: [
                    "Invoice manager".text.make(),
                    90.widthBox,
                    InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, router.previousHistory),
                      child: Icon(Icons.history_outlined),
                    ),
                  ],
                )),
                toolbarHeight: 90,
                backgroundColor: rang.always,
              ),
              body: SingleChildScrollView(
                child: Container(
                  width: widt,
                  child: Column(
                    children: [
                      20.heightBox,
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/logo.png",
                                    height: 30,
                                  ),
                                  20.widthBox,
                                  Text(
                                    "Welcome to Hi-Tech Metal Formings(I)",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
                                  )
                                ],
                              ),
                            ),
                            30.heightBox,
                            Container(
                              width: widt,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(143, 148, 251, 1),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Autocomplete<String>(
                                    optionsBuilder:
                                        (TextEditingValue textEditingValue) {
                                      if (textEditingValue.text.isEmpty ||
                                          textEditingValue
                                                  .selection.baseOffset ==
                                              0) {
                                        // Return the full customer list if the field is empty or focused
                                        return customer;
                                      }
                                      // Filter the customer list based on the user's input
                                      return customer.where((String option) {
                                        return option.toLowerCase().contains(
                                            textEditingValue.text
                                                .toLowerCase());
                                      });
                                    },
                                    onSelected: (String selectedValue) {
                                      setState(() {
                                        selected_customer = selectedValue;
                                        selected_item = "Select Item";
                                        products.clear();
                                        // products.add('Select Item');
                                        products.addAll(mp[selectedValue]!);
                                        item = [
                                          Item('-', 0),
                                        ];
                                      });
                                    },
                                    fieldViewBuilder: (context,
                                        textEditingController,
                                        focusNode,
                                        onFieldSubmitted) {
                                      // You can use the next snip of code if you dont want the initial text to come when you use setState((){});
                                      return Container(
                                        child: TextFormField(
                                          style: TextStyle(fontSize: 12),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            labelText: 'Select customer',
                                            fillColor: rang.always,
                                            focusColor: rang.always,
                                            suffixIcon: IconButton(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 12, 0, 0),
                                              onPressed:
                                                  textEditingController.clear,
                                              icon: Icon(
                                                Icons.clear,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please select customer ';
                                            }
                                            return null;
                                          },

                                          controller:
                                              textEditingController, //uses fieldViewBuilder TextEditingController
                                          focusNode: focusNode,
                                        ),
                                      );
                                    },
                                    // optionsMaxHeight: 400,
                                    optionsViewBuilder:
                                        (context, onSelected, options) {
                                      return Align(
                                        alignment: Alignment.topLeft,
                                        child: Material(
                                          child: Container(
                                            width: 250,
                                            height: 500,
                                            // color: Colors.cyan,
                                            child: ListView.builder(
                                              padding: EdgeInsets.all(10.0),
                                              itemCount: options.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final String option =
                                                    options.elementAt(index);

                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      onSelected(option);
                                                      isremoved = false;
                                                    });
                                                  },
                                                  child: ListTile(
                                                    title: Text(
                                                      option,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: 325,
                        height: 250,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, 1),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Container(
                            width: 260,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  width: 300,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black26),
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Autocomplete<String>(
                                    optionsBuilder:
                                        (TextEditingValue textEditingValue) {
                                      if (textEditingValue.text.isEmpty ||
                                          textEditingValue
                                                  .selection.baseOffset ==
                                              0) {
                                        // Return the full customer list if the field is empty or focused
                                        return products;
                                      }
                                      // Filter the customer list based on the user's input
                                      return products.where((String option) {
                                        return option.toLowerCase().contains(
                                            textEditingValue.text
                                                .toLowerCase());
                                      });
                                    },
                                    onSelected: (String selectedValue) {
                                      setState(() {
                                        selected_item = selectedValue!;
                                      });
                                    },

                                    fieldViewBuilder: (context,
                                        textEditingController,
                                        focusNode,
                                        onFieldSubmitted) {
                                      // You can use the next snip of code if you dont want the initial text to come when you use setState((){});
                                      return TextFormField(
                                        style: TextStyle(fontSize: 12),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'Select Items',
                                          fillColor: rang.always,
                                          focusColor: rang.always,
                                          suffixIcon: IconButton(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 12, 0, 0),
                                            onPressed:
                                                textEditingController.clear,
                                            icon: Icon(
                                              Icons.clear,
                                              size: 20,
                                            ),
                                          ),
                                        ),

                                        controller:
                                            textEditingController, //uses fieldViewBuilder TextEditingController
                                        focusNode: focusNode,
                                      );
                                    },

                                    // optionsMaxHeight: 400,
                                    optionsViewBuilder:
                                        (context, onSelected, options) {
                                      return Align(
                                        alignment: Alignment.topLeft,
                                        child: Material(
                                          child: Container(
                                            width: 300,
                                            height: 400,
                                            // color: Colors.cyan,
                                            child: ListView.builder(
                                              padding: EdgeInsets.all(10.0),
                                              itemCount: options.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final String option =
                                                    options.elementAt(index);

                                                return GestureDetector(
                                                  onTap: () {
                                                    onSelected(option);
                                                  },
                                                  child: ListTile(
                                                    title: Text(
                                                      option,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },

                                    // initialValue: const TextEditingValue(
                                    //     text: "Select Customer "),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      "    Quantity :".text.bold.make(),
                                      40.widthBox,
                                      InputQty(
                                        btnColor1: rang
                                            .always, //color of the increase and decrease icon
                                        maxVal:
                                            double.maxFinite, //max val to go
                                        minVal: 1,
                                        initVal: 1, //min starting val
                                        onQtyChanged: (val) {
                                          //on value changed we may set the value
                                          //setstate could be called

                                          quatity_count = val as int;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                20.heightBox,
                                Container(
                                  child: InkWell(
                                    onTap: () {
                                      //this process returns the future so withput the use of await keywoed it will return the instance of future
                                      setState(() {
                                        if (selected_item != 'Select Item') {
                                          int index = -1;
                                          bool flag = false;
                                          for (int i = 0;
                                              i < item.length;
                                              i++) {
                                            if (item[i].name == selected_item) {
                                              flag = true;

                                              handle_multiple(context, i);
                                              break;
                                            }
                                          }

                                          if (flag == false) {
                                            item.add(Item(
                                                selected_item, quatity_count));
                                            displaytoast("Item added", context);
                                          }
                                          if (item.length > 1 &&
                                              isremoved == false) {
                                            item.removeAt(0);
                                            isremoved = true;
                                          }
                                        } else {
                                          displaytoast(
                                              "select the suitable item  ",
                                              context);
                                        }
                                      });
                                    },
                                    child: Ink(
                                      height: 50,
                                      child: Container(
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: rang.always,
                                        ),
                                        child: Center(
                                            child: Text("Add",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      50.heightBox,
                      Container(
                        width: widt,
                        // height: 250,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, 1),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),

                        child: DataTable(
                          dataRowHeight: 70,
                          columns: [
                            DataColumn(label: Text('Item Name')),
                            DataColumn(label: Text('Quantity')),
                            DataColumn(label: Text('Remove'))
                          ],
                          rows: item
                              .map(
                                (iteme) => DataRow(
                                  cells: [
                                    DataCell(Text(iteme.name,
                                        style: TextStyle(fontSize: 10))),
                                    DataCell(Text(iteme.quantity.toString())),
                                    DataCell(
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          // Add functionality to remove the item
                                          setState(() {
                                            item.remove(
                                                iteme); // Remove the item from the list
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      50.heightBox,
                      InkWell(
                        onTap: () {
                          //this process returns the future so withput the use of await keywoed it will return the instance of future
                          if (selected_customer != 'Select Customer' &&
                              item[0].name != '-') {
                            List<Map<String, dynamic>> orderItems = [];
                            for (var iteme in item) {
                              orderItems.add({
                                'name': iteme.name,
                                'quantity': iteme.quantity,
                              });
                            }

                            DatabaseReference _orderRef2 =
                                FirebaseDatabase.instance.ref().child('orders');
                            _orderRef2.child(selected_customer).push().set({
                              'items': orderItems,
                              'timestamp': DateTime.now().toString(),
                            });

                            Navigator.pushNamed(context, router.successordrer);
                          } else {
                            displaytoast("Please select the customer and items",
                                context);
                          }
                        },
                        child: Ink(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                rang.always,
                                Color.fromRGBO(226, 53, 57, 5),
                              ])),
                          child: Center(
                            child: Text(" Order",
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
                      50.heightBox,
                    ],
                  ),
                ),
              ),
              drawer: Drawer(
                width: 200,
                child: Container(
                  child: Column(children: [
                    SizedBox(
                      height: 125,
                      child: Container(
                        color: rang.always,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: "Logout".text.make(),
                      onTap: () => {
                        Auth().signOut(),
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            router.loginroute, (route) => false),
                      },
                    )
                  ]),
                ),
              ),
              bottomNavigationBar: CurvedNavigationBar(
                color: rang.always,
                backgroundColor: Colors.white,
                index: 0,
                items: [
                  Icon(Icons.home),
                  Icon(Icons.data_object_outlined),
                ],
                onTap: (index) async {
                  if (index == 0) {
                    await Future.delayed(const Duration(seconds: 1));
                    index = 0;
                    // Navigator.pushNamed(context, router.History);
                    setState(() {
                      index = 0;
                    });
                  }

                  if (index == 1) {
                    await Future.delayed(const Duration(seconds: 1));
                    index = 1;
                  
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => dataUpdate(Customer: customer)),
                      (Route<dynamic> route) => false,
                    );
                    setState(() {
                      index = 0;
                    });
                  }
                },
              ),
            );
          }
          return Scaffold(
            body: Container(
                child: Center(
              child: CircularProgressIndicator(
                color: rang.always,
              ),
            )),
          );
        });
  }

  Future<void> handle_multiple(
    BuildContext context,
    int i,
  ) {
    return showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: "Item already added".text.make(),
            content:
                "This item is already been added \n Do you want to add it again?"
                    .text
                    .make(),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text(
                  'Cancle',
                  style: TextStyle(
                    color: Color.fromARGB(255, 142, 10, 10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(
                    color: Color.fromARGB(255, 142, 10, 10),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    item[i].quantity += quatity_count;
                    displaytoast("Item added", context);
                    Navigator.of(context).pop();
                  });
                },
              ),
            ],
          );
        });
  }
}

displaytoast(String s, BuildContext context) {
  Fluttertoast.showToast(msg: s);
}

class Item {
  final String name;
  int quantity;

  Item(this.name, this.quantity);
}
