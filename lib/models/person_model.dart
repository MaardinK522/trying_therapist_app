import 'package:objectbox/objectbox.dart';

@Entity()
class PersonModel {
  @Id(assignable: true)
  int id = 0;

  /// person's full name as a String.
  String personName;

  /// person's full age as a Int.
  int personAge;

  /// person's gender. If male returns true, else false
  bool personGender;

  /// Location of the user as a string.
  String personLocation;

  /// Constructor to Person's.
  PersonModel({
    required this.personName,
    required this.personAge,
    required this.personGender,
    required this.personLocation,
  });
}
