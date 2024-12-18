import 'dart:io';

String jsonReader(String name) => File('test/helper/$name').readAsStringSync();