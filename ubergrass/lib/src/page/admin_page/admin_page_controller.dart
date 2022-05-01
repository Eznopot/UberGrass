import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'admin_page_service.dart';

class AdminPageController extends ChangeNotifier {
  AdminPageService service = AdminPageService();

  List<dynamic>? _AllCollections;
  List<dynamic>? _AllDocuments;
  Map<String, dynamic>? _AllData;
  dynamic? _Collection;
  dynamic? _Document;

  List<dynamic>? get AllCollections => _AllCollections;
  dynamic? get Collection => _Collection;
  List<dynamic>? get AllDocuments => _AllDocuments;
  dynamic? get Document => _Document;
  Map<String, dynamic>? get AllData => _AllData;

  set AllCollections (data) {
    _AllCollections = data;
  }
  set Collection (data) {
    _Collection = data;
  }
  set AllDocuments (data) {
    _AllDocuments = data;
  }
  set Document (data) {
    _Document = data;
  }
  set AllData (data) {
    _AllData = data;
  }

  Future<void> GetAllCollections() async {
  _AllCollections = await service.GetAllCollections();
  notifyListeners();
  }

  Future<void> GetRefDocOfCollections(String DocName) async {
     _AllDocuments = await service.GetRefDocOfCollections(DocName);
     notifyListeners();
}

  Future<void> GetDocFromCall(String callName, String docName) async {
    _AllData = await service.GetDocFromCall(callName, docName);

    notifyListeners();
  }
}