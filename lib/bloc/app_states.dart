import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:musicstation/models/model_class.dart';

@immutable
abstract class ProductState extends Equatable {}

class InitialState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductAdding extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductAdded extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductError extends ProductState {
  final String error;
  ProductError(this.error);
  @override
  List<Object?> get props => [error];
}

class ProductLoading extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoaded extends ProductState {
  List<Song> data;
  ProductLoaded(this.data);
  @override
  List<Object?> get props => [data];
}

class ProductLoadedF extends ProductState {
  List<Song> data;
  ProductLoadedF(this.data);
  @override
  List<Object?> get props => [data];
}
