import '../model/user_data.dart';

class CompleteInformationService {
  void updateInformations(String email, String name) {
    UserData userData = UserData();
    userData.updateEmail(email);
    userData.updateName(name);
  }
}