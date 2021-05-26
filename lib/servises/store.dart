import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constaint.dart';
import 'package:e_commerce/models/productmodel.dart';

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  addproduct(Producrt product) {
    _firestore.collection(kproductCollection).add({
      kproductName: product.name,
      kproductPrice: product.price,
      kproductDescerption: product.descerption,
      kproductCategery: product.categery,
      kproductLocation: product.locatain,
    });
  }
}
