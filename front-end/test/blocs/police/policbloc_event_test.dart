import 'package:crime_reporter/bloc/policeBloc/policebloc_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('userblocevent', () {
    group('Userbloc', () {
      test('supports value equality', () {
        expect(GetOngoing(Path()), GetOngoing(Path()));
      });
       test('supports value equality', () {
        expect(GetSolved(Path()), GetSolved(Path()));
      });
       test('supports value equality', () {
        expect(GetReported(Path()), GetReported(Path()));
      });
    });
  });
}
