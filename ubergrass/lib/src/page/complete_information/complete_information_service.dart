import 'package:ubergrass/src/model/user_data.dart';


class CompleteInformationService {
  void updateInformations(String email, String name) {
    UserData userData = UserData();
    userData.addUserToGroup();
  }

  Future<List<String>?> getCity() async {
    return await getCity();
  }
}