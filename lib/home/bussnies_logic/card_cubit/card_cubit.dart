

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_devices/models/product_model.dart';

part 'card_state.dart';

class CardCubit extends Cubit<CardState> {
  CardCubit() : super(CardInitial());
  List<ProductModel> products = [];

  void addProduct(ProductModel product) {
    products.add(product);
    emit(CardLoadedData());
  }

  void removeProduct(ProductModel product) {
    products.remove(product);
    if(products.isEmpty){
      emit(CardLoadedEmptyData());
    }else{
      emit(CardLoadedData());
    }
  }

  void getProducts() {
     if(products.isEmpty){
      emit(CardLoadedEmptyData());
    }else{
      emit(CardLoadedData());
    }
  }
}
