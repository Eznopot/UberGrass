import 'package:ubergrass/src/widget/widget/dialog/transition_dialog/transition_dialog_service.dart';

class TransitionDialogController  {
  TransitionDialogService service = TransitionDialogService();
  Future<String> getNextPage(String route) async {
    return await service.getNextPage(route);
  }
}