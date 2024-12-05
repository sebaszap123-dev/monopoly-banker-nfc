import 'package:monopoly_banker/config/utils/extensions.dart';
import 'package:monopoly_banker/data/model/record.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NdefRecordInfo {
  const NdefRecordInfo(
      {required this.record, required this.text, required this.nfcInfo});

  final Record record;

  final String text;

  final String nfcInfo;

  static NdefRecordInfo fromNdef(NdefRecord record) {
    final record0 = Record.fromNdef(record);
    if (record0 is WellknownTextRecord) {
      return NdefRecordInfo(
        record: record0,
        text: record0.text,
        nfcInfo:
            'language: ${record0.languageCode}, identifier: ${record0.identifier}',
      );
    }
    if (record0 is UnsupportedRecord) {
      // more custom info from NdefRecord.
      if (record.typeNameFormat == NdefTypeNameFormat.empty) {
        return NdefRecordInfo(
          record: record0,
          text: _typeNameFormatToString(record0.record.typeNameFormat),
          nfcInfo: '-',
        );
      }
      return NdefRecordInfo(
        record: record0,
        text: _typeNameFormatToString(record0.record.typeNameFormat),
        nfcInfo:
            '(${record0.record.type.toHexString()}) ${record0.record.payload.toHexString()}',
      );
    }
    throw UnimplementedError("NFC");
  }
}

String _typeNameFormatToString(NdefTypeNameFormat format) {
  switch (format) {
    case NdefTypeNameFormat.empty:
      return 'Empty';
    case NdefTypeNameFormat.nfcWellknown:
      return 'NFC Wellknown';
    case NdefTypeNameFormat.media:
      return 'Media';
    case NdefTypeNameFormat.absoluteUri:
      return 'Absolute Uri';
    case NdefTypeNameFormat.nfcExternal:
      return 'NFC External';
    case NdefTypeNameFormat.unknown:
      return 'Unknown';
    case NdefTypeNameFormat.unchanged:
      return 'Unchanged';
  }
}
