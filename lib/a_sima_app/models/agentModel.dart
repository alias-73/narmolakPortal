class AgentModel {
  late String agentCode;
  late String userCode;
  late String name;

  AgentModel.fromJson(Map < String , dynamic> parsedJson) {
    agentCode = parsedJson['agentcode'];
    userCode = parsedJson['usercode'];
    name = parsedJson['name'];
  }

}