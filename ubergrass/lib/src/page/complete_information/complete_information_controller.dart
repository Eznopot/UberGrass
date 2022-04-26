import 'complete_information_service.dart';

class CompleteInformationController {
  CompleteInformationService service = CompleteInformationService();

  void updateInformations(String email, String Name) {
    service.updateInformations(email, Name);
  }
}