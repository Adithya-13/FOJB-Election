import 'package:fojb_election/data/entities/entities.dart';

class CandidateEntity extends BaseEntity {
  final List<CandidateItemEntity> candidates;

  CandidateEntity({List<CandidateItemEntity>? candidates})
      : candidates = candidates ?? List<CandidateItemEntity>.empty();
}

class CandidateItemEntity extends BaseEntity {
  final String name;
  final String origin;
  final String school;
  final String vision;
  final List<String> mission;
  final String urlVideo;

  CandidateItemEntity({
    String? name,
    String? origin,
    String? school,
    String? vision,
    List<String>? mission,
    String? urlVideo,
  })  : name = name ?? '',
        origin = origin ?? '',
        school = school ?? '',
        vision = vision ?? '',
        mission = mission ?? List<String>.empty(),
        urlVideo = urlVideo ?? '';
}
