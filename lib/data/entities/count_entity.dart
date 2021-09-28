import 'package:fojb_election/data/entities/entities.dart';

class CountEntity extends BaseEntity {
  final String total;
  final String first;
  final String second;
  final String third;
  final String fourth;
  final String fifth;
  final String sixth;

  CountEntity({
    String? total,
    String? first,
    String? second,
    String? third,
    String? fourth,
    String? fifth,
    String? sixth,
  })  : total = total ?? '0',
        first = first ?? '0',
        second = second ?? '0',
        third = third ?? '0',
        fourth = fourth ?? '0',
        fifth = fifth ?? '0',
        sixth = sixth ?? '0';
}
