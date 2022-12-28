import 'package:equatable/equatable.dart';

abstract class ProductEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class Create extends ProductEvents {
  final String songname;
  final String authorname;
  final bool favourite;
  Create(this.songname, this.authorname, this.favourite);
}

class Update extends ProductEvents {
  final String songname;
  final String authorname;
  final bool favourite;
  final String id;
  Update(this.songname, this.authorname, this.favourite, this.id);
}

class Getdata extends ProductEvents {
  Getdata();
}

class GetdataF extends ProductEvents {
  GetdataF();
}
