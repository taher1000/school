
enum UserType { student, teacher, superVisor, admin, superAdmin }

class UserRole {
  /// The underlying value of this enum member.
  int value = 0;

  UserRole._internal(this.value);

  static UserRole superAdmin = UserRole._internal(1);
  static UserRole admin = UserRole._internal(2);
  static UserRole supervisor = UserRole._internal(3);
  static UserRole teacher = UserRole._internal(4);
  static UserRole student = UserRole._internal(5);

  UserType get userType {
    switch (value) {
      case 1:
        return UserType.superAdmin;
      case 2:
        return UserType.admin;
      case 3:
        return UserType.superVisor;
      case 4:
        return UserType.teacher;
      case 5:
        return UserType.student;

      default:
        return UserType.student;
    }
  }

  UserRole.fromJson(dynamic data) {
    switch (data) {
      case 0:
        value = data;
        break;
      case 1:
        value = data;
        break;
      case 2:
        value = data;
        break;
      case 3:
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
