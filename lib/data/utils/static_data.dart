import 'package:fojb_election/data/entities/entities.dart';

class StaticData {
  static CandidateEntity getCandidates() => CandidateEntity(
        candidates: [
          CandidateItemEntity(
            name: 'Fauzan Maulana',
            origin: 'Kota Bandung',
            school: 'SMAN 16 Kota Bandung',
          ),
          CandidateItemEntity(
            name: 'Razinah Saleh Washingthon Azward',
            origin: 'Kabupaten Bogor',
            school: 'SMK MEKANIK Cibinong',
          ),
          CandidateItemEntity(
            name: 'Muhammad Azzikri Fadillah Anwar',
            origin: 'Kota Bekasi',
            school: 'SMK Tinta Emas Indonesia',
          ),
          CandidateItemEntity(
            name: 'Bintang Muhammad Surya Al-Farisy',
            origin: 'Kota Sukabumi',
            school: 'SMAN 3 Kota Sukabumi',
          ),
          CandidateItemEntity(
            name: 'Nola Septiani Pramita',
            origin: 'Kota Cimahi',
            school: 'SMAN 6 Cimahi',
          ),
          CandidateItemEntity(
            name: 'Farah Fauziah Danopa',
            origin: 'Kabupaten Majalengka',
            school: 'SMAN 1 Majalengka',
          ),
        ],
      );

  static CandidateItemEntity getCandidateByIndex(int index) =>
      getCandidates().candidates[index];
}
