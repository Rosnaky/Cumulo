import 'dart:convert';

import 'package:http/http.dart' as http;

class AviationWeather {
  Future<Map<String, dynamic>?> getMetar(
      String airportCode, String apiKey) async {
    try {
      final url = Uri.parse(
          "https://avwx.rest/api/metar/CYKF?token=tAvHoOJXsDMZ5FmV-rI74RAopm2WzHgcpgozfZkPvXw");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
