import 'package:remainder/src/models/errors.dart';
import 'package:remainder/src/models/reminer.dart';
import 'package:remainder/src/models/subject_type.dart';
import 'package:rxdart/rxdart.dart';

class NewEntryBloc {
  BehaviorSubject<SubjectTypeEnum> _selectedMedicineType$;
  BehaviorSubject<SubjectTypeEnum> get selectedMedicineType =>
      _selectedMedicineType$.stream;

  // BehaviorSubject<List<Day>> _checkedDays$;
  // BehaviorSubject<List<Day>> get checkedDays$ => _checkedDays$;

  BehaviorSubject<int> _selectedInterval$;
  BehaviorSubject<int> get selectedInterval$ => _selectedInterval$;

  BehaviorSubject<String> _selectedTimeOfDay$;
  BehaviorSubject<String> get selectedTimeOfDay$ => _selectedTimeOfDay$;

  BehaviorSubject<EntryError> _errorState$;
  BehaviorSubject<EntryError> get errorState$ => _errorState$;

  NewEntryBloc() {
    _selectedMedicineType$ =
        BehaviorSubject<SubjectTypeEnum>.seeded(SubjectTypeEnum.None);
    // _checkedDays$ = BehaviorSubject<List<Day>>.seeded([]);
    _selectedTimeOfDay$ = BehaviorSubject<String>.seeded("None");
    _selectedInterval$ = BehaviorSubject<int>.seeded(0);
    _errorState$ = BehaviorSubject<EntryError>();
  }

  void dispose() {
    _selectedMedicineType$.close();
    // _checkedDays$.close();
    _selectedTimeOfDay$.close();
    _selectedInterval$.close();
  }

  void submitError(EntryError error) {
    _errorState$.add(error);
  }

  void updateInterval(int interval) {
    _selectedInterval$.add(interval);
  }

  void updateTime(String time) {
    _selectedTimeOfDay$.add(time);
  }

  // void addtoDays(Day day) {
  //   List<Day> _updatedDayList = _checkedDays$.value;
  //   if (_updatedDayList.contains(day)) {
  //     _updatedDayList.remove(day);
  //   } else {
  //     _updatedDayList.add(day);
  //   }
  //   _checkedDays$.add(_updatedDayList);
  // }

  void updateSelectedMedicine(SubjectTypeEnum type) {
    SubjectTypeEnum _tempType = _selectedMedicineType$.value;
    if (type == _tempType) {
      _selectedMedicineType$.add(SubjectTypeEnum.None);
    } else {
      _selectedMedicineType$.add(type);
    }
  }
}
