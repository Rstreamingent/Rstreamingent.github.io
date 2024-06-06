// api_provider.dart

import 'dart:convert';

import 'package:flutter/foundation.dart';

class ApiProvider extends ChangeNotifier {
  List<dynamic> collections = [];
  bool _isLoading = true;

  List<dynamic> get _collections => collections;
  bool get isLoading => _isLoading;

  get http => null;

  Future<void> fetchData() async {
    // Your API fetching logic here
    final response = await http.get(Uri.parse('https://appdataapi-production.up.railway.app/'));

    if (response.statusCode == 200) {
      collections = json.decode(response.body);
      _isLoading = false;
      notifyListeners(); // Notify listeners when data changes
    } else {
      throw Exception('Failed to load data');
    }
  }
}
