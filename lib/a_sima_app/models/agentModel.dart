class AgentModel {
  late String agentCode;
  late String userCode;
  late String name;
  late String agentModel;
  late String userModel;

  AgentModel.fromJson(Map<String, dynamic> parsedJson) {
    agentCode = parsedJson['agentcode'];
    userCode = parsedJson['usercode'];
    name = parsedJson['name'];
    agentModel = parsedJson['agentmodel'].toString();
    userModel = parsedJson['usermodel'].toString();
  }
}
