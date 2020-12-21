import 'dart:convert';
import 'dart:typed_data';

Map<String, dynamic> decodeResponseBytesToJson(Uint8List responseBytes) {
  return json.decode(utf8.decode(responseBytes)) as Map<String, dynamic>;
}
