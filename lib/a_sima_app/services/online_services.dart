import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sima_portal/a_sima_app/moaref/nesbat_model.dart';
import 'package:sima_portal/a_sima_app/models/PersonalMessageModel.dart';
import 'package:sima_portal/a_sima_app/models/afterTakhsisModel.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/alarmModel.dart';
import 'package:sima_portal/a_sima_app/models/bankModel.dart';
import 'package:sima_portal/a_sima_app/models/brandModel.dart';
import 'package:sima_portal/a_sima_app/models/brandModelModel.dart';
import 'package:sima_portal/a_sima_app/models/changeModel.dart';
import 'package:sima_portal/a_sima_app/models/changeModel2.dart';
import 'package:sima_portal/a_sima_app/models/checkSerialModel.dart';
import 'package:sima_portal/a_sima_app/device/device-model.dart';
import 'package:sima_portal/a_sima_app/device/deviceHistoryModel.dart';
import 'package:sima_portal/a_sima_app/models/imgAddressModel.dart';
import 'package:sima_portal/a_sima_app/models/notificationModel.dart';
import 'package:sima_portal/a_sima_app/news/news-model.dart';
import 'package:sima_portal/a_sima_app/video_services/filterVideosModel.dart';
import 'package:sima_portal/a_sima_app/models/irankish-model.dart';
import 'package:sima_portal/a_sima_app/models/memberCo-model.dart';
import 'package:sima_portal/a_sima_app/models/messageModel.dart';
import 'package:sima_portal/a_sima_app/Moaref/moaref-model.dart';
import 'package:sima_portal/a_sima_app/models/ostanModel.dart';
import 'package:sima_portal/a_sima_app/models/pasargad-model.dart';
import 'package:sima_portal/a_sima_app/models/pazirande-model.dart';
import 'package:sima_portal/a_sima_app/models/pazirandeMaliyat-model.dart';
import 'package:sima_portal/a_sima_app/models/pazirandeModel2.dart';
import 'package:sima_portal/a_sima_app/models/pazirandeModel3.dart';
import 'package:sima_portal/a_sima_app/jaygozini/jaygozini-model.dart';
import 'package:sima_portal/a_sima_app/models/rizModel.dart';
import 'package:sima_portal/a_sima_app/models/rizWalletModel.dart';
import 'package:sima_portal/a_sima_app/models/senfModel.dart';
import 'package:sima_portal/a_sima_app/models/serialModel.dart';
import 'package:sima_portal/a_sima_app/Hesab/shaba-model.dart';
import 'package:sima_portal/a_sima_app/models/shobeModel.dart';
import 'package:sima_portal/a_sima_app/models/soeichModel.dart';
import 'package:sima_portal/a_sima_app/Takhsis/takhsis-model.dart';
import 'package:sima_portal/a_sima_app/Takhsis/takhsisInf1.dart';
import 'package:sima_portal/a_sima_app/Takhsis/takhsisInf2.dart';
import 'package:sima_portal/a_sima_app/models/usersModel.dart';
import '../Terminal/enable_req_model.dart';
import '../editInfo/edited-model.dart';
import '../models/PazirandeHistoryModel.dart';
import '../models/accessssssModel.dart';
import '../models/chart1Model.dart';
import '../models/checkIMElModel.dart';
import '../models/ehrazModel.dart';
import '../models/imeiModel.dart';
import '../models/infUserModel.dart';
import '../models/notifyModel.dart';
import '../models/questionModel.dart';
import '../models/rizModelll.dart';
import '../models/sarjamModel.dart';
import '../models/terminalModel.dart';
import '../models/usersModel2.dart';
import '../senfReq/reqterminal-model.dart';
import '../senfReq/sanad-model.dart';
import '../taqalob/taqalob-model.dart';
import '../taqalob/taqalob-model2.dart';
import '../video_services/viedoModel.dart';

class OnlineServices {
  // static const API = "185.208.79.96:8080";
  // static const API = "194.33.125.128";
  Future<String> checkEnablePortal() async {
    final response2 = await http
        .post(Uri.parse('http://185.208.79.96:8080/Portal/pos/fix.php'));
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  static Future<Map> getSanadList(Map body) async {
    final response = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/reqterminal-sanad-get-m.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("no")) {
      List<SanadModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(SanadModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  Future<String> getPazirandeInfo2(Map body) async {
    final response2 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/reqterminal-sanad-get-inf-m.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  Future<String> getPayaneSave(Map body) async {
    print(body);
    final response2 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/reqterminal-save-m.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  Future<String> getlastChanges(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/noskhe-details.php'),
        body: body);
    // print(response2.body)
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
    // return "اپلیکیشنی جامع که از صفر تا صد ارتباط با نمایندگان شرکت را پوشش میدهد، اعم از :ثبت پذیرنده، معرف، حساب، بارگذاری مدارک، ثبت انبار، تخصیص، جایگزینی، پشتیبانی، ترمینال ها، ثبت رجیستری، کشف تقلب و کلیه امور مربوط به نمایندگان و پذیرندگان شرکت";
  }

  static Future<String> sendBasket(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/product-save.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  Future<String> sendDataForRead(Map body) async {
    // print(body);
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/news-read-m.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  static Future<Map> getDeviceHistory(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/device-history.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("no")) {
      List<DeviceHistoryModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(DeviceHistoryModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getPazirandeHistory(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/pazirande-history.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("no")) {
      List<PazirandeHistoryModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(PazirandeHistoryModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getNotify(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/notify-get.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("no")) {
      List<NotifyModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(NotifyModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  Future<String> addUser(String type, Map body) async {
    String url = "";
    type == "نماینده"
        ? url = 'http://185.208.79.96:8080/Portal/pos/agent-user-add-m.php'
        : url = 'http://185.208.79.96:8080/Portal/pos/agent-userzero-add-m.php';
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return "null";
  }

  Future<String> checkUser(String type, Map body) async {
    String url = "";
    type == "نماینده"
        ? url = 'http://185.208.79.96:8080/Portal/pos/agent-user-add-m.php'
        : url = 'http://185.208.79.96:8080/Portal/pos/agent-userzero-add-m.php';
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return "null";
  }

  Future<String> changePass(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/agent-pass-change.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return "null";
  }

  Future<String> changeUsername(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/agent-user-change.php'),
        body: body);
    // print(response.body);

    if (response.statusCode == 200) {
      return response.body;
    } else
      return "no";
  }

  // Future<String> getPrivacyPolicy() async {
  //   final response = await http.post(Uri.parse('http://185.208.79.96:8080/Portal/pos/harim.php'));
  //   if (response.statusCode == 200) {return response.body;}else return "null";
  // }

  static sendLoginInfo(Map body) async {
    await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/login-inf.php'),
        body: body);
  }

  static Future<String> checkQuestionare(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/nazarsanji-check.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  static Future<String> sendQuestionaire(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/nazarsanji.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  static Future<String> simaPayAllow(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/simapay-req-check.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  static Future<Map> getChangeHesabList(Map body) async {
    final response = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/reqchange-shaba-list.php'),
        body: body);
    print(response.body);
    if (response.statusCode == 200 && !response.body.contains("free")) {
      List<ChangeModel2> data = [];
      json.decode(response.body).forEach((item) {
        data.add(ChangeModel2.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getVideoFilters() async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/amozesh-search.php'));
    if (response.statusCode == 200 && !response.body.contains("free")) {
      List<VideoFilterModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(VideoFilterModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getProFilters() async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/product-search.php'));
    if (response.statusCode == 200 && !response.body.contains("free")) {
      List<VideoFilterModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(VideoFilterModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getVideoList() async {
    final response = await http
        .post(Uri.parse('http://185.208.79.96:8080/Portal/pos/amozesh.php'));
    if (response.statusCode == 200 && !response.body.contains("no")) {
      List<VideoModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(VideoModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getProList() async {
    final response = await http
        .post(Uri.parse('http://185.208.79.96:8080/Portal/pos/product.php'));
    if (response.statusCode == 200 && !response.body.contains("no")) {
      List<VideoModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(VideoModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<String> sendChangeHesabReq(Map body) async {
    final response2 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/reqchange-shaba-save.php'),
        body: body);

    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  static Future<String> changeHesabReq(Map body) async {
    final response2 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/reqchange-shaba-inf.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  static Future eqdam(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/maliyat-eqdam.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<Map> getMaliyatList(Map body, int i) async {
    String url;
    url = i == 1
        ? "http://185.208.79.96:8080/Portal/pos/maliyat-list-f.php"
        : "http://185.208.79.96:8080/Portal/pos/maliyat-list-kf.php";
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200 && !response.body.contains("free")) {
      List<PazirandeMaliyatModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(PazirandeMaliyatModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<String> ebtalRequest(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/ebtal-req.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  static Future<String> shekayatRequest(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/enteqad-save-m.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  static Future<String> setTargetRequest(Map body) async {
    final response = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/agent-target-save-m.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  static Future<String> simaPayRequest(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/simapay-req.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  static Future<String> deleteDevice(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/device-delete.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  static Future<String> getImg(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/agent-img.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "-";
  }

  static Future<String> estelam_mobile(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/mobile-estelam.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "-";
  }

  static Future<String> sheba_estelam(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/shaba-estelam.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "-";
  }

  static Future<String> sheba_estelam2(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/shaba-estelam-rec.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "-";
  }

  static Future<String> estelam_mobile2(Map body) async {
    final response2 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/mobile-estelam-rec.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "-";
  }

  static Future<String> getImgBank(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/bank-img.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "-";
  }

  static Future<String> getDeviceImg(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/device-img.php'),
        body: body);
    // print(response2.body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "-";
  }

  static Future<Map> getChangeList(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/reqchange-list.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("free")) {
      List<ChangeModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(ChangeModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<String> sendNewInfo(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/reqchange-save.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  static Future<String> getOldInfo(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/reqchange-inf.php'),
        body: body);

    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  static Future<String> transfer(Map body) async {
    final response2 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/wallet-money-transfer.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  static Future<String> checkSupportRec(Map body) async {
    final response2 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/terminal-support-check.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  static Future<String> terminalLock(Map body) async {
    final response2 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/terminal-lock-check.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  static Future<String> getPSP3(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/pazirande-psp.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  static Future<String> getPSP2(Map body) async {
    print(body);
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/shaba-psp.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  static Future<String> getSenf(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/pazirande-senf-m.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  static Future<String> getType(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/pazirande-noe.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  static Future<Map> getUserList(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/agent-user-list.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("free")) {
      List<UserModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(UserModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getUserList2(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/agent-user-list-m.php'),
        body: body);
    if (response.statusCode == 200) {
      List<UserModel2> data = [];
      json.decode(response.body).forEach((item) {
        data.add(UserModel2.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getQuestions() async {
    final response = await http
        .post(Uri.parse('http://185.208.79.96:8080/Portal/pos/question-m.php'));
    if (response.statusCode == 200 && !response.body.contains("free")) {
      List<QuestionModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(QuestionModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getPazirandeInfo(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/pazirande-check.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("noo")) {
      List<PazirandeModel3> data = [];
      json.decode(response.body).forEach((item) {
        data.add(PazirandeModel3.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<String> maliyat_rec(Map body) async {
    final response2 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/maliyat-estelam-rec.php'),
        body: body);

    if (response2.statusCode == 200) {
      return response2.body.replaceAll("\n", "").replaceAll("\t", "");
    } else
      return "null";
  }

  static Future<String> maliyat_req(Map body) async {
    final response2 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/maliyat-estelam-req.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  static void reduce_money(Map body) async {
    await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/wallet-pay-estelam-save.php'),
        body: body);
  }

  static void reduce_money2(Map body) async {
    await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/wallet-pay-mobile-save.php'),
        body: body);
  }

  static void shebs_reduce_money(Map body) async {
    await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/wallet-pay-shaba-save.php'),
        body: body);
  }

  static Future<Map> getInfoTakhsis1(Map body) async {
    final response = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/takhsis-parvande-inf.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("free")) {
      List<InfoTakhsisModel1> data = [];
      json.decode(response.body).forEach((item) {
        data.add(InfoTakhsisModel1.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getInfoAfterTakhsis(Map body) async {
    // print(body);
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/takhsis-wait.php'),
        body: body);
    // print(response.body);
    if (response.statusCode == 200 && !response.body.contains("wait")) {
      List<AfterTakhsisModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(AfterTakhsisModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "wait"};
    }
  }

  static Future<Map> getInfoTakhsis2(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/takhsis-bank-inf.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("free")) {
      List<InfoTakhsisModel2> data = [];
      json.decode(response.body).forEach((item) {
        data.add(InfoTakhsisModel2.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<String> getInformation(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/getinformation.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body.replaceAll("\n", "").replaceAll("\t", "");
    } else
      return "null";
  }

  static Future<String> getNumberSubUser(Map body) async {
    final response2 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/agent-user-parvande-count.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body.replaceAll("\n", "").replaceAll("\t", "");
    } else
      return "null";
  }

  static Future<String> getAPIToken() async {
    final response2 = await http
        .get(Uri.parse('http://185.208.79.96:8080/Portal/pos/apikey.php'));
    if (response2.statusCode == 200) {
      return response2.body.replaceAll("\n", "").replaceAll("\t", "");
    } else
      return "null";
  }

  static Future<String> getBestSum(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/wallet-bes-sum.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body.replaceAll("\n", "").replaceAll("\t", "");
    } else
      return "null";
  }

  static Future<String> getBedSum(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/wallet-bed-sum.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body.replaceAll("\n", "").replaceAll("\t", "");
    } else
      return "null";
  }

  static Future<Map> getRizWallet(Map body) async {
    final response = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/wallet-transaction.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("free")) {
      List<RizWalletModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(RizWalletModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<String> getBalance(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/wallet-balance.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body.replaceAll("\n", "").replaceAll("\t", "");
    } else
      return "null";
  }

  static Future<String> getBalance2(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/wallet-balancee.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body.replaceAll("\n", "").replaceAll("\t", "");
    } else
      return "null";
  }

  static Future<String> getIMG(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/agent-img_______.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  static Future<String> getName(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/main/agent-name.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  static Future<Map> getName2(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/agent-inf-m.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("free")) {
      List<UserInfModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(UserInfModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<String> sendUpload(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/madarek-save-db.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  static Future<String> sendUpload_memberCo(Map body) async {
    final response = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/madarek-emza-save-db.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  static Future<String> sendUpload_IranKish(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/nasb-save-ir-db.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  Future<String> sendToken(Map body) async {
    print(body);
    final response = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/firebase-token-save-m.php'),
        body: body);
    print(response.body);

    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  static Future<Map> getRizList(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/tarakonesh.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("free")) {
      List<RizModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(RizModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getRizList2(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/tarakonesh.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("free")) {
      List<RizModel2> data = [];
      json.decode(response.body).forEach((item) {
        data.add(RizModel2.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  Future<String> sendDataForPasargad(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/em-pasargad-anjam.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  Future<String> sendDataForIranKish(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/em-irankish-anjam.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  static Future<Map> pasargad(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/em-pasargad-list.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("free")) {
      List<PasargadModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(PasargadModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> iranKish(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/em-irankish-list.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("free")) {
      List<IranKishModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(IranKishModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  Future<String> sendDataForReplace(Map body) async {
    //  print(b)
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/jaygozini-save.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  Future<String> sendDataForIMEI(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/imei-save.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  Future<String> checkSerial2(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/jaygozini-check.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  static Future<Map> checkSerial22(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/jaygozini-check.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("free")) {
      List<CheckSerialModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(CheckSerialModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> checkSarjam(Map body) async {
    final response = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/tarakonesh-sarjam-m.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("free")) {
      List<SarjamModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(SarjamModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> checkTerminal(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/imei-check.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("free")) {
      List<CheckIMEIModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(CheckIMEIModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> checkSerial2_1(Map body) async {
    print(body);
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/jaygozini-check-m.php'),
        body: body);
    print(response.body);
    if (response.statusCode == 200 && !response.body.contains("free")) {
      List<CheckSerialModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(CheckSerialModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getIMEIList(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/imei-list.php'),
        body: body);
    print(response.body);
    if (response.statusCode == 200 && !response.body.contains("no")) {
      List<IMEIModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(IMEIModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "no"};
    }
  }

  static Future<Map> getNewsList(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/news-m.php'),
        body: body);
    // print(response.body);
    if (response.statusCode == 200 && !response.body.contains("no")) {
      List<NewsModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(NewsModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getReplaceList(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/jaygozini-list.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("free")) {
      List<JaygoziniModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(JaygoziniModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getTaqalobList(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/taqalob-list-m.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("no")) {
      List<TaqalobModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(TaqalobModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getTaqalobInfo(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/taqalob-details-m.php'),
        body: body);
    // print(response.body);
    if (response.statusCode == 200 && !response.body.contains("no")) {
      List<TaqalobModel2> data = [];
      json.decode(response.body).forEach((item) {
        data.add(TaqalobModel2.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getEnableReqList(Map body) async {
    final response = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/terminal-active-list.php'),
        body: body);

    if (response.statusCode == 200 && !response.body.contains("no")) {
      List<EnableReqModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(EnableReqModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> checkCodeMeli(Map body) async {
    final response = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/pazirande-takmil-inf-m.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("no")) {
      List<BankModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(BankModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getEditedList(Map body) async {
    final response = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/pazirande-takmil-list-m.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("no")) {
      List<EditedModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(EditedModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  Future<String> checkCodeMeliSave(Map body) async {
    final response = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/pazirande-takmil-m.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body.replaceAll("\n", "").replaceAll("\t", "");
    }
    return response.body;
  }

  static Future<Map> getSliderList(String agentcode) async {
    String url = "";
    agentcode == "10070"
        ? url = 'http://185.208.79.96:8080/Portal/pos/slider-baya.php'
        : agentcode == "10145"
            ? url = 'http://185.208.79.96:8080/Portal/pos/slider-ava.php'
            : url = 'http://185.208.79.96:8080/Portal/pos/slider-sima.php';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      List<ImgAddressModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(ImgAddressModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  Future<String> checkSerial(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/device-check.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body.replaceAll("\n", "").replaceAll("\t", "");
    }
    return response.body;
  }

  Future<String> send_newMemberCo(Map body) async {
    final response = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/pazirande-emza-save.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  Future<String> send_editPazirande(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/pazirande-update.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  Future<String> send_editPazirandeH(Map body) async {
    final response = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/pazirande-update-h.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  static Future<String> get_editPazirandeH(Map body) async {
    final response = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/pazirandeinf-edit-h.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  static Future<String> get_editPazirande(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/pazirandeinf-edit.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  static Future<Map> get_ehrazInfo(Map body) async {
    final response = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/moaref-check-list-m.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("free")) {
      List<EhrazModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(EhrazModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  Future<String> khata(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/khata.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  Future<String> enableTerminal(Map body) async {
    final response = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/terminal-active-req.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  Future<String> hesab(Map body) async {
    final response = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/pazirande-hesab-inf.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  Future<String> terminal(Map body) async {
    final response = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/pazirande-takhsis-inf.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  Future<String> getTerminal(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/device-terminal.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  Future<String> getPayesh(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/payesh.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  Future<String> transferDevice(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/device-havale.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  Future<String> checkNewVersion() async {
    final response = await http
        .post(Uri.parse('http://185.208.79.96:8080/Portal/pos/version-n.php'));
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  Future<String> sendForUpload(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/madarek-save.php'),
        body: body);
    //print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  Future<String> sendForUploadProfile(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/agent-img-save.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  Future<String> sendError(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/error.php'),
        body: body);
    //print(response.body);
    if (response.statusCode == 200) {
      // return response.body ;
      return "----";
    }
    return response.body;
  }

  Future<String> sendForUploadCo(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/madarek-emza-save.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  Future<String> sendForUploadIranKish(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/nasb-save-ir.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return response.body;
  }

  Future<String> sendRequestForSupport(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/support.php'),
        body: body);
    return response.statusCode.toString();
  }

  static Future<String> getDeviceAllCount(Map body) async {
    final response2 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/main/agent-em-pasargad-kol.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body;
    } else
      return "null";
  }

  static Future<String> getDeviceNewCount(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/main/devicejadid.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body;
    } else
      return "null";
  }

  static Future<String> getDeviceFreeCount(Map body) async {
    final response1 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/main/agent-em-pasargad-baz.php'),
        body: body);
    if (response1.statusCode == 200) {
      return response1.body;
    } else
      return "null";
  }

  static Future<String> getTakhsisAllCount(Map body) async {
    final response2 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/main/agent-takhsis-kol.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body;
    } else
      return "null";
  }

  static Future<String> getTakhsisNasbCount(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/main/takhsisnasb.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body;
    } else
      return "null";
  }

  static Future<String> getParvandeAll(Map body) async {
    final response2 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/agent-parvande-kol-m.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body;
    } else
      return "null";
  }

  static Future<String> getParvandeEslah(Map body) async {
    final response2 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/agent-parvande-eslah-m.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body;
    } else
      return "null";
  }

  static Future<String> getParvandeTakhsis(Map body) async {
    final response2 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/agent-parvande-takhsis-m.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body;
    } else
      return "null";
  }

  static Future<String> getLawsAndAbout() async {
    final response2 = await http
        .post(Uri.parse('http://185.208.79.96:8080/Portal/pos/about-m.php'));
    if (response2.statusCode == 200) {
      return response2.body;
    } else
      return "null";
  }

  static Future<String> getEM_P_Baz(Map body) async {
    final response2 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/agent-em-pasargad-baz'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body;
    } else
      return "null";
  }

  static Future<String> getEM_P_All(Map body) async {
    final response2 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/agent-em-pasargad-all.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body;
    } else
      return "null";
  }

  static Future<String> getTakhsisReadyCount(Map body) async {
    final response1 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/main/agent-takhsis-montazer.php'),
        body: body);
    if (response1.statusCode == 200) {
      return response1.body;
    } else
      return "null";
  }

  static Future<String> getPazirandeLaghvCount(Map body) async {
    //pri  nt(body);
    final response2 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/main/agent-parvande-faal.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body;
    } else
      return "null";
  }

  static Future<String> getCountOfPSP(Map body) async {
    final response2 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/agent-psp-darsad-m.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  static Future<String> getPazirandeEslahCount(Map body) async {
    final response2 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/main/agent-parvande-eslah.php'),
        body: body);
    if (response2.statusCode == 200) {
      return response2.body;
    } else
      return "null";
  }

  static Future<String> getPazirandeAllCount(Map body) async {
    final response1 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/main/agent-parvande-kol.php'),
        body: body);
    if (response1.statusCode == 200) {
      return response1.body;
    } else
      return "null";
  }

  static Future<String> getTarget(Map body) async {
    final response1 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/agent-target-m.php'),
        body: body);
    if (response1.statusCode == 200) {
      return response1.body;
    } else
      return "null";
  }

  static Future<String> getEmBazCount(Map body) async {
    final response1 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/agent-em-darsad-m.php'),
        body: body);
    if (response1.statusCode == 200) {
      return response1.body;
    } else
      return "free";
  }

  Future<String> sendDataForReadMessages(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/message-read.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return "null";
  }

  static Future<Map> getPersonalMessagee(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/popup.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("no")) {
      List<PersonalMessageModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(PersonalMessageModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getAccess1(Map body) async {
    print(body);
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/agent-access.php'),
        body: body);
    print("_______________");
    print(response.body);
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      List<AccessModel1> data = [];
      responseBody.forEach((item) {
        data.add(AccessModel1.fromJson(item));
      });
      return {"data": data};
    } else
      return {"data": "free"};
  }

  static Future<Map> getAccess(Map body) async {
    // print(body);

    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/agent-access.php'),
        body: body);
    // print(response.body);
    if (response.statusCode == 200 && !response.body.contains("no")) {
      List<AccessModel1> data = [];
      json.decode(response.body).forEach((item) {
        data.add(AccessModel1.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getNotification(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/agent-elanat-m.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("no")) {
      List<NotificationModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(NotificationModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<String> clearNotification(Map body) async {
    final response1 = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/agent-elanat-read-m.php'),
        body: body);
    if (response1.statusCode == 200) {
      return response1.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "free";
  }

  static Future<String> isAllowStore(Map body) async {
    final response1 = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/product-access-m.php'),
        body: body);
    if (response1.statusCode == 200) {
      return response1.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "free";
  }

  static Future<Map> getChart1(Map body) async {
    final response = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/chart-month-pazirande-m.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("no")) {
      List<Chart1Model> data = [];
      json.decode(response.body).forEach((item) {
        data.add(Chart1Model.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getChart2(Map body) async {
    final response = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/chart-month-takhsis-m.php'),
        body: body);
    print(response.body);

    if (response.statusCode == 200 && !response.body.contains("no")) {
      List<Chart1Model> data = [];
      json.decode(response.body).forEach((item) {
        data.add(Chart1Model.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  Future<String> sendDataForTakhsis3(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/takhsis-save-su.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return "null";
  }

  Future<String> sendDataForTakhsis2(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/takhsis-save-pu.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return "null";
  }

  Future<String> sendDataForTakhsis(Map body) async {
    // print(body);
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/takhsis-save.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return "null";
  }

  Future<String> sendDataForSaveTaqalob(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/taqolob-save-m.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return "null";
  }

  static Future<Map> getSerialList(Map body) async {
    // print(body);
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/takhsis-serial.php'),
        body: body);
    // print(response.body);
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      List<SerialModel> data = [];
      responseBody.forEach((item) {
        data.add(SerialModel.fromJson(item));
      });
      return {"data": data};
    } else
      return {"data": "free"};
  }

  Future<String> sendDataForSabtMoaref(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/moaref-save.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return "null";
  }

  Future<String> sendDataForSabtSheba2(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/shaba-save-pu.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return "null";
  }

  Future<String> sendDataForSabtSheba(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/shaba-save.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return "null";
  }

  Future<String> sendDataForSabtPazirandeH(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/pazirande-save-h.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return "null";
  }

  Future<String> checkSenf(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/senf-javaz-m.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body
          .replaceAll("\n", "")
          .replaceAll("\t", "")
          .replaceAll("\r", "");
    } else
      return "null";
  }

  Future<String> sendDataForSabtPazirande(Map body) async {
    // final response1 = await http.post(Uri.parse('http://185.208.79.96:8080/Portal/pos/pazirande-save.php'));
    // print(body);
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/pazirande-save.php'),
        body: body);
    // print(response.body);

    if (response.statusCode == 200) {
      return response.body;
    } else
      return "null";
  }

  Future<String> deviceRegister(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/device-save.php'),
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return "null";
  }

  static Future<Map> getSoeichList(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/soeich.php'),
        body: body);
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      List<SoeichModel> data = [];
      responseBody.forEach((item) {
        data.add(SoeichModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getSenfTList(Map body) async {
    //pri  nt(body);
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/senftakmili.php'),
        body: body);
    // pprint(response.body);
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      List<SenfModel> data = [];
      responseBody.forEach((item) {
        data.add(SenfModel.fromJson(item));
      });

      return {"data": data};
    } else
      return {"data": "free"};
  }

  static Future<Map> getSenfListMojavez() async {
    //pri  nt(body);
    //final response = await http.get(Uri.parse('http://185.208.79.96:8080/Portal/pos/senf-d.php'));
    final response;
    response = await http.get(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/senf-mojavez.php'));
    //var  responseBody = json.decode(response.body);
    //  print(response.body[2]);
    final parsed = json.decode(response.body);
    return {"data": parsed};
  }

  static Future<Map> getSenfListEsteshhad() async {
    final response = await http.get(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/senf-esteshhad.php'));
    final parsed = json.decode(response.body);
    return {"data": parsed};
  }

  static Future<Map> getSenfList() async {
    //pri  nt(body);
    final response = await http
        .get(Uri.parse('http://185.208.79.96:8080/Portal/pos/senf.php'));
    //  pprint(response.body);
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      List<SenfModel> data = [];
      responseBody.forEach((item) {
        data.add(SenfModel.fromJson(item));
      });

      return {"data": data};
    } else
      return {"data": "free"};
  }

  static Future<Map> getShahrList(Map body) async {
    //pri  nt(body);
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/ostanshahr.php'),
        body: body);
    // pprint(response.body);
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      List<OstanModel> data = [];
      responseBody.forEach((item) {
        data.add(OstanModel.fromJson(item));
      });

      return {"data": data};
    } else
      return {"data": "free"};
  }

  static Future<Map> getOstanList() async {
    //pri  nt(body);
    final response = await http
        .get(Uri.parse('http://185.208.79.96:8080/Portal/pos/ostan.php'));
    //  pprint(response.body);
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      List<OstanModel> data = [];
      responseBody.forEach((item) {
        data.add(OstanModel.fromJson(item));
      });

      return {"data": data};
    } else
      return {"data": "free"};
  }

  static Future<Map> getBrandModelList(Map body) async {
    //pri  nt(body);
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/brandmodel.php'),
        body: body);
    // pprint(response.body);
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      List<BrandModelModel> data = [];
      responseBody.forEach((item) {
        data.add(BrandModelModel.fromJson(item));
      });

      return {"data": data};
    } else
      return {"data": "free"};
  }

  static Future<Map> getBrandModelList2(Map body) async {
    //pri  nt(body);
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/device-model-m.php'),
        body: body);
    // pprint(response.body);
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      List<BrandModelModel> data = [];
      responseBody.forEach((item) {
        data.add(BrandModelModel.fromJson(item));
      });

      return {"data": data};
    } else
      return {"data": "free"};
  }

  static Future<Map> getBrandList() async {
    //pri  nt(body);
    final response = await http
        .post(Uri.parse('http://185.208.79.96:8080/Portal/pos/brand.php'));
    // pprint(response.body);
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      List<BrandModel> data = [];
      responseBody.forEach((item) {
        data.add(BrandModel.fromJson(item));
      });

      return {"data": data};
    } else
      return {"data": "free"};
  }

  static Future<Map> getBrandList2(Map body) async {
    //pri  nt(body);
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/device-brand-m.php'),
        body: body);
    // pprint(response.body);
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      List<BrandModel> data = [];
      responseBody.forEach((item) {
        data.add(BrandModel.fromJson(item));
      });

      return {"data": data};
    } else
      return {"data": "free"};
  }

  static Future<Map> getPazirandeList3(Map body) async {
    //pri  nt(body);
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/takhsis-pazirande.php'),
        body: body);
    //  pprint(response.body);
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      List<PazirandeModel2> data = [];
      responseBody.forEach((item) {
        data.add(PazirandeModel2.fromJson(item));
      });

      return {"data": data};
    } else
      return {"data": "free"};
  }

  static Future<Map> getPazirandeList5(Map body) async {
    //pri  nt(body);
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/madarek-pazirande.php'),
        body: body);
    //pprint(response.body);
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      List<PazirandeModel2> data = [];
      responseBody.forEach((item) {
        data.add(PazirandeModel2.fromJson(item));
      });

      return {"data": data};
    } else
      return {"data": "free"};
  }

  static Future<Map> getPazirandeList4(Map body) async {
    //pri  nt(body);
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/moaref-pazirande.php'),
        body: body);
    // pprint(response.body);
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      List<PazirandeModel2> data = [];
      responseBody.forEach((item) {
        data.add(PazirandeModel2.fromJson(item));
      });

      return {"data": data};
    } else
      return {"data": "free"};
  }

  static Future<Map> getNesbatList() async {
    //print(body);
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/moaref-nesbat-m.php'));
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      List<NesbatMoarefModel> data = [];
      responseBody.forEach((item) {
        data.add(NesbatMoarefModel.fromJson(item));
      });
      List ddd = [];
      for (int i = 0; i < data.length; i++) {
        ddd.add(data[i].name);
      }
      return {"data": ddd};
    } else
      return {"data": "free"};
  }

  static Future<Map> getPazirandeList2(Map body) async {
    //pri  nt(body);
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/shaba-pazirande.php'),
        body: body);
    // pprint(response.body);
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      List<PazirandeModel2> data = [];
      responseBody.forEach((item) {
        data.add(PazirandeModel2.fromJson(item));
      });

      return {"data": data};
    } else
      return {"data": "free"};
  }

  static Future<Map> getShobeList(Map body) async {
    //pprint(body);
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/shobe.php'),
        body: body);
    //   pprint(response.body);
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      List<ShobeModel> data = [];
      responseBody.forEach((item) {
        data.add(ShobeModel.fromJson(item));
      });
      return {"data": data};
    } else
      return {"data": "free"};
  }

  static Future<Map> getBankList(Map body) async {
//    pprint(body);
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/bank-m.php'),
        body: body);
    //   pprint(response.body);
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      List<BankModel> data = [];
      responseBody.forEach((item) {
        data.add(BankModel.fromJson(item));
      });
      //  pprint(response.body);
      return {"data": data};
    } else
      return {"data": "free"};
  }

  static Future<Map> getAlarm(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/alarm.php'),
        body: body);
    print(response.body);
    if (response.statusCode == 200) {
      List<AlarmModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(AlarmModel.fromJson(item));
      });
      return {"data": data};
    } else
      return {"data": "free"};
  }

  static Future<Map> getMessages(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/message.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("null")) {
      List<MessageModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(MessageModel.fromJson(item));
      });
      return {"data": data};
    } else
      return {"data": "free"};
  }

  static Future<Map> getDeviceList(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/devicelist.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("no")) {
      List<DeviceModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(DeviceModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getReqTeminal_list(Map body) async {
    final response = await http.post(
        Uri.parse(
            'http://185.208.79.96:8080/Portal/pos/reqterminal-list-m.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("no")) {
      List<ReqTerminalModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(ReqTerminalModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getMoarefList(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/moareflist.php'),
        body: body);
    //  pprint(response.body);
    if (response.statusCode == 200 && !response.body.contains("no")) {
      List<MoarefModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(MoarefModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getTakhsisList(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/takhsislist.php'),
        body: body);
    // pprint(response.body);
    if (response.statusCode == 200 && !response.body.contains("free")) {
      List<TakhsisModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(TakhsisModel.fromJson(item));
      });

      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getSenfList2() async {
    //pri  nt(body);
    //final response = await http.get(Uri.parse('http://185.208.79.96:8080/Portal/pos/senf-d.php'));
    final response = await http
        .get(Uri.parse('http://185.208.79.96:8080/Portal/pos/senf-m.php'));
    //var  responseBody = json.decode(response.body);
    //  print(response.body[2]);
    final parsed = json.decode(response.body);

    return {"data": parsed};
  }

  static Future<Map> getShebaList(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/shabalist.php'),
        body: body);
    print(response.body);
    if (response.statusCode == 200 && !response.body.contains("no")) {
      List<ShebaModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(ShebaModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getPazirandeList(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/pazirandelist.php'),
        body: body);
    // pprint(response.body);
    if (response.statusCode == 200 && !response.body.contains("noo")) {
      List<PazirandeModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(PazirandeModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getTerminalList(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/terminal-list.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("no")) {
      List<TerminalModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(TerminalModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  static Future<Map> getMemberCoList(Map body) async {
    final response = await http.post(
        Uri.parse('http://185.208.79.96:8080/Portal/pos/pazirandelistemza.php'),
        body: body);
    if (response.statusCode == 200 && !response.body.contains("noo")) {
      List<MemberCoModel> data = [];
      json.decode(response.body).forEach((item) {
        data.add(MemberCoModel.fromJson(item));
      });
      return {"data": data};
    } else {
      return {"data": "free"};
    }
  }

  Future<Map> sendDataForLogin(Map body) async {
    dev.log(body.toString());
    final response = await http.post(
        Uri.parse("http://185.208.79.96:8080/Portal/pos/login-m.php"),
        body: body);

    // Uri.http("http://185.208.79.96:8080/Portal/pos/login-m.php");

    // print(response.body);
    if (!response.body.toString().contains("no")) {
      var responseBody = json.decode(response.body);
      List<AgentModel> data = [];
      responseBody.forEach((item) {
        data.add(AgentModel.fromJson(item));
      });
      return {"data": data};
    } else
      return {"data": "free"};
  }
}
