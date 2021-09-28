
import 'package:fojb_election/data/entities/entities.dart';

class CountEntity extends BaseEntity {
  final int total;
  final List<int> countCandidates;

  CountEntity({
    int? total,
    List<int>? countCandidates,
  })  : total = total ?? 0,
        countCandidates = countCandidates ?? List<int>.empty();
}
