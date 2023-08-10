class UserRole {
  /// The underlying value of this enum member.
  int value = 0;

  UserRole._internal(this.value);

  static UserRole superAdmin = UserRole._internal(1);
  static UserRole admin = UserRole._internal(2);
  static UserRole supervisor = UserRole._internal(3);
  static UserRole teacher = UserRole._internal(4);
  static UserRole student = UserRole._internal(5);

  static final List<UserRole> availableValues = [
    superAdmin,
    admin,
    supervisor,
    teacher,
    student
  ];

  String get name {
    switch (value) {
      case 1:
        return 'SuperAdmin';
      case 2:
        return 'Admin';
      case 3:
        return 'Supervisor';
      case 4:
        return 'Teacher';
      case 5:
        return 'Student';
      default:
        throw ('Unknown enum value to decode UserRole $value');
    }
  }

  UserRole.fromJson(dynamic data) {
    switch (data) {
      case 1:
        value = data;
        break;
      case 2:
        value = data;
        break;
      case 3:
        value = data;
        break;
      case 4:
        value = data;
        break;
      case 5:
        value = data;
        break;
      default:
        throw ('Unknown enum value to decode UserRole : $data');
    }
  }

  static dynamic encode(UserRole data) {
    return data.value;
  }
}
