import 'package:crime_reporter/bloc/policeBloc/policebloc_bloc.dart';
import 'package:crime_reporter/repositories/police_repositories.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PoliceRepository policRepository;
  group('userbloc', () {
    test('supports value comparisons', () {
      expect(PoliceblocInitial(), PoliceblocInitial());
    });

    test("returns same object when no properties are passed", () {
      expect(PoliceblocInitial().props, []);
    });

      test("returns same object when no properties are passed", () {
      expect(GetReportedSucessful(), GetReportedSucessful());
    });
  });
}
