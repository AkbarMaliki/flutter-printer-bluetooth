import 'dart:convert';
// import 'dart:html';
import 'dart:io';
import 'package:harp_flutter/store/index.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

final LocalStorage storage = new LocalStorage('MyApp'); //

var urls1 = 'https://api.officialapp.website';

// var urls1='http://localhost/autos' ;
class autophp {
  var apitoken = "borneojs";
  var auth = false; // pake auth atau tidak
  var scrambles = false; //  laravel wajib selalu true
  var backend = "php"; //php, firebase, laravel
  var table = "";
  var id = "";
  var errCount = 0;
  var urls = urls1;
  var urlBASE = urls1 + "/apis.php";
  var urlupload = urls1 + '/upload1.php';
  collection(tables) {
    table = tables;
    return this;
  }

  doc(ids) {
    if (ids != 'false') {
      id = ids;
    }
    return this;
  }

  set(vdata) async {
    var body = {};
    body['t-bl'] = scramble(table);
    body['api-token'] = scramble(apitoken);
    body['backend'] = scramble(backend);
    body['header'] = auth ? storage.getItem('auth._token.local') : 'false';
    body['key-h'] = auth ? storage.getItem('auth._token.local') : 'false';
    body['5e19fb19a0aa66a0'] = scramble(auth.toString());
    body['scramble'] = scrambles ? scrambles : 'false';
    body['data'] =
        scrambles ? scramble(json.encode(vdata)) : json.encode(vdata);
    body['sd28(#092/sd'] = scrambles ? scramble(vdata) : json.encode(vdata);
    var keys = [];
    await vdata.forEach((i, val) {
      keys.add(i);
    });
    body['key'] = keys.join(',');
    body['key-z-token'] = scramble('set');
    if (id != "") {
      body['id'] = id;
    }

    var urlx = Uri.parse(urls + '/auth/crypt.php');
    var res = await http.post(urlx, body: {'apitoken': 'borneojs'});
    if (res.statusCode == 200) {
      body['se-token'] = res.body;
      // String encode = json.encode(body);
      // print(encode);
      var url2 = Uri.parse(urls + '/apis.php');
      var res2 = await http.post(url2, body: body);
      if (res2.statusCode == 200) {
        return res2.body;
      } else {
        print('error');
        res2.printError();
      }
    } else {
      print('error');
      res.printError();
    }
  }

  get(vdata, vdata2) async {
    var body = {};
    body['t-bl'] = scramble(table);
    body['api-token'] = scramble(apitoken);
    body['backend'] = scramble(backend);
    body['header'] = auth ? storage.getItem('auth._token.local') : 'false';
    body['key-h'] = auth ? storage.getItem('auth._token.local') : 'false';
    body['5e19fb19a0aa66a0'] = scramble(auth.toString());
    body['scramble'] = scrambles ? scrambles : 'false';
    body['sd28(#092/sd'] = scrambles ? scramble(vdata) : vdata;
    body['23*(kdj'] = scrambles ? scramble(vdata) : vdata2;
    body['key-z-token'] = scramble('get');
    body['key'] = vdata;
    if (id != "") {
      body['id'] = id;
    }
    var urlx = Uri.parse(urls + '/auth/crypt.php');
    var res = await http.post(urlx, body: {'apitoken': 'borneojs'});
    if (res.statusCode == 200) {
      // print(res.body);
      body['se-token'] = res.body;
      // print(body);
      var url2 = Uri.parse(urls + '/apis.php');
      var res2 = await http.post(url2, body: body);
      if (res2.statusCode == 200) {
        return res2.body;
      } else {
        print('error');
        res2.printError();
      }
    } else {
      print('error');
      res.printError();
    }
  }

  select(vdata) async {
    var body = {};
    body['t-bl'] = scramble(table);
    body['api-token'] = scramble(apitoken);
    body['backend'] = scramble(backend);
    body['header'] = auth ? storage.getItem('auth._token.local') : 'false';
    body['key-h'] = auth ? storage.getItem('auth._token.local') : 'false';
    body['5e19fb19a0aa66a0'] = scramble(auth.toString());
    body['scramble'] = scrambles ? scrambles : 'false';
    body['sd28(#092/sd'] = scrambles ? scramble(vdata) : vdata;
    // body['23*(kdj']=scrambles?scramble(vdata):vdata2;
    body['key-z-token'] = scramble('select');
    body['key'] = vdata;
    print(vdata);
    print(urls + '/apis.php');
    if (id != "") {
      body['id'] = id;
    }
    var urlx = Uri.parse(urls + '/auth/crypt.php');
    var res = await http.post(urlx, body: {'apitoken': 'borneojs'});
    if (res.statusCode == 200) {
      // print(res.body);
      body['se-token'] = res.body;
      // print(body);
      var url2 = Uri.parse(urls + '/apis.php');
      var res2 = await http.post(url2, body: body);
      if (res2.statusCode == 200) {
        return res2.body;
      } else {
        print('error');
        res2.printError();
      }
    } else {
      print('error');
      res.printError();
    }
  }

  delete() async {
    var body = {};
    body['t-bl'] = scramble(table);
    body['api-token'] = scramble(apitoken);
    body['backend'] = scramble(backend);
    body['header'] = auth ? storage.getItem('auth._token.local') : 'false';
    body['key-h'] = auth ? storage.getItem('auth._token.local') : 'false';
    body['5e19fb19a0aa66a0'] = scramble(auth.toString());
    body['scramble'] = scrambles ? scrambles : 'false';
    // body['23*(kdj']=scrambles?scramble(vdata):vdata2;
    body['key-z-token'] = scramble('delete');
    if (id != "") {
      body['id'] = id;
    }
    var urlx = Uri.parse(urls + '/auth/crypt.php');
    var res = await http.post(urlx, body: {'apitoken': 'borneojs'});
    if (res.statusCode == 200) {
      // print(res.body);
      body['se-token'] = res.body;
      // print(body);
      var url2 = Uri.parse(urls + '/apis.php');
      var res2 = await http.post(url2, body: body);
      if (res2.statusCode == 200) {
        return res2.body;
      } else {
        print('error');
        res2.printError();
      }
    } else {
      print('error');
      res.printError();
    }
  }

  upload(file) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://api.officialapp.website/upload1.php'));
    request.fields['secret'] = "dsdxxoi4#\$(*#sdsaaada@#";
    request.files.add(http.MultipartFile.fromBytes(
        'file', file.readAsBytesSync(),
        filename: file.path.split("/").last));
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    return respStr;
  }

  register(vdata) async {
    var body = {};
    body['api-token'] = scramble(apitoken);
    body['token-u'] = scramble(vdata['username']);
    body['token-p'] = scramble(vdata['password']);
    var urlx = Uri.parse(urls + '/auth/crypt.php');
    var res = await http.post(urlx, body: {'apitoken': 'borneojs'});
    if (res.statusCode == 200) {
      body['se-token'] = res.body;
      var url2 = Uri.parse(urls + '/auth/register.php');
      var res2 = await http.post(url2, body: body);
      if (res2.statusCode == 200) {
        return res2.body;
      } else {
        print('error');
        res2.printError();
      }
    } else {
      print('error');
      res.printError();
    }
  }

  ceklogin() async {
    var body = {};
    var urlx = Uri.parse(urls + '/auth/crypt.php');
    var res = await http.post(urlx, body: {'apitoken': 'borneojs'});
    if (res.statusCode == 200) {
      body['api-token'] = scramble(apitoken);
      body['se-token'] = res.body;
      body['key-h'] = storage.getItem('auth._token.local');
      body['key-z-token'] = scramble('getuser');
      var url3 = Uri.parse(urls + '/apis.php');
      var res3 = await http.post(url3, body: body);
      if (res3.statusCode == 200) {
        storage.setItem('users', res3.body);
        return res3.body;
      } else {
        print('error');
        res3.printError();
      }
    }
  }

  login2(vdata) async {
    var body = {};
    body['api-token'] = scramble(apitoken);
    body['token-u'] = scramble(vdata['username']);
    body['token-p'] = scramble(vdata['password']);
    var urlx = Uri.parse(urls + '/auth/crypt.php');
    var res = await http.post(urlx, body: {'apitoken': 'borneojs'});
    if (res.statusCode == 200) {
      body['se-token'] = res.body;
      var url2 = Uri.parse(urls + '/auth/login.php');
      var res2 = await http.post(url2, body: body);
      if (res2.statusCode == 200) {
        body['key-h'] = res2.body;
        storage.setItem('auth._token.local', res2.body);
        body['key-z-token'] = scramble('getuser');
        var url3 = Uri.parse(urls + '/apis.php');
        var res3 = await http.post(url3, body: body);
        if (res3.statusCode == 200) {
          storage.setItem('users', res3.body);
          return res3.body;
        } else {
          print('error');
          res3.printError();
        }
      } else {
        print('error');
        res2.printError();
      }
    } else {
      print('error');
      res.printError();
    }
  }
}

scramble(teks) {
  var char = "";
  var hasil = "";
  for (var i = 0; i < teks.length; i++) {
    char = "";
    char = teks[i];
    if (char == "a") {
      char = char.replaceAll("a", "x");
    } else if (char == "b") {
      char = char.replaceAll("b", "v");
    } else if (char == "c") {
      char = char.replaceAll("c", "u");
    } else if (char == "d") {
      char = char.replaceAll("d", "w");
    } else if (char == "e") {
      char = char.replaceAll("e", "y");
    } else if (char == "f") {
      char = char.replaceAll("f", "z");
    } else if (char == "g") {
      char = char.replaceAll("g", "t");
    } else if (char == "h") {
      char = char.replaceAll("h", "s");
    } else if (char == "i") {
      char = char.replaceAll("i", "r");
    } else if (char == "j") {
      char = char.replaceAll("j", "q");
    } else if (char == "k") {
      char = char.replaceAll("k", "p");
    } else if (char == "l") {
      char = char.replaceAll("l", "o");
    } else if (char == "m") {
      char = char.replaceAll("m", "n");
    } else if (char == "z") {
      char = char.replaceAll("z", "f");
    } else if (char == "y") {
      char = char.replaceAll("y", "e");
    } else if (char == "x") {
      char = char.replaceAll("x", "a");
    } else if (char == "w") {
      char = char.replaceAll("w", "d");
    } else if (char == "v") {
      char = char.replaceAll("v", "b");
    } else if (char == "u") {
      char = char.replaceAll("u", "c");
    } else if (char == "t") {
      char = char.replaceAll("t", "g");
    } else if (char == "s") {
      char = char.replaceAll("s", "h");
    } else if (char == "r") {
      char = char.replaceAll("r", "i");
    } else if (char == "q") {
      char = char.replaceAll("q", "j");
    } else if (char == "p") {
      char = char.replaceAll("p", "k");
    } else if (char == "o") {
      char = char.replaceAll("o", "l");
    } else if (char == "n") {
      char = char.replaceAll("n", "m");
    } else if (char == "1") {
      char = char.replaceAll("1", "0");
    } else if (char == "2") {
      char = char.replaceAll("2", "8");
    } else if (char == "3") {
      char = char.replaceAll("3", "9");
    } else if (char == "4") {
      char = char.replaceAll("4", "7");
    } else if (char == "5") {
      char = char.replaceAll("5", "6");
    } else if (char == "0") {
      char = char.replaceAll("0", "1");
    } else if (char == "8") {
      char = char.replaceAll("8", "2");
    } else if (char == "9") {
      char = char.replaceAll("9", "3");
    } else if (char == "7") {
      char = char.replaceAll("7", "4");
    } else if (char == "6") {
      char = char.replaceAll("6", "5");
    } else if (char == " ") {
      char = char.replaceAll(" ", "_");
    } else if (char == "_") {
      char = char.replaceAll("_", " ");
    } else if (char == "*") {
      char = char.replaceAll("*", "/");
    } else if (char == "/") {
      char = char.replaceAll("/", "*");
    } else if (char == ",") {
      char = char.replaceAll(",", "^");
    } else if (char == "^") {
      char = char.replaceAll("^", ",");
    }
    hasil = hasil + char;
  }
  return hasil;
}
