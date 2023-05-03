import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:io' as io;

FileOutput fileOutPut = FileOutput();
ConsoleOutput consoleOutput = ConsoleOutput();
List<LogOutput> multiOutput = [fileOutPut, consoleOutput];

final logger = Logger(output: MultiOutput(multiOutput));

class FileOutput extends LogOutput {
  late File file;
  late bool overrideExisting = false;
  late Encoding encoding = utf8;
  late IOSink sinkIO;

  FileOutput();

  @override
  void init() {
    getDirectoryForLogRecord().then((response) {
      sinkIO = file.openWrite(
        mode: overrideExisting ? FileMode.writeOnly : FileMode.writeOnlyAppend,
        encoding: encoding,
      );
    });
  }

  @override
  void output(OutputEvent event) {
    sinkIO.writeAll(event.lines, '\n');
  }

  @override
  void destroy() async {
    await sinkIO.flush();
    await sinkIO.close();
  }

  Future<void> getDirectoryForLogRecord() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    file = File('${directory.path}/SORFWMS_log.txt');
  }
}
