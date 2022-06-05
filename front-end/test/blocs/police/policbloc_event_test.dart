import 'package:crime_reporter/application/police/bloc/policebloc_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('userblocevent', () {
    group('Userbloc', () {
      test('supports value equality', () {
        expect(GetOngoing("id"), GetOngoing("id"));
      });
      test('supports value equality', () {
        expect(GetSolved("id"), GetSolved("id"));
      });
      test('another value equality', () {
        expect(GetReported("id"), GetReported("id"));
      });
    });
  });
}
