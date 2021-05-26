import 'package:e_commerce/constaint.dart';
import 'package:e_commerce/models/productmodel.dart';
import 'package:e_commerce/servises/store.dart';
import 'package:e_commerce/widgets/textfield.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  static String id = 'adminpage';
  GlobalKey<FormState> formkey = GlobalKey();
  String _name, _price, _descerption, _categery, _location;
  final store = Store();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        body: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text_field(
                hint: 'productName',
                onClick: (value) {
                  _name = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text_field(
                hint: 'product Price',
                onClick: (value) {
                  _price = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text_field(
                hint: 'productDescerption',
                onClick: (value) {
                  _descerption = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text_field(
                hint: 'productCategery',
                onClick: (value) {
                  _categery = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text_field(
                hint: 'productLocation',
                onClick: (value) {
                  _location = value;
                },
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                child: Text('Add Product'),
                onPressed: () {
                  if (formkey.currentState.validate()) {
                    formkey.currentState.save();
                    store.addproduct(Producrt(
                      name: _name,
                      price: _price,
                      descerption: _descerption,
                      categery: _categery,
                      locatain: _location,
                    ));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
