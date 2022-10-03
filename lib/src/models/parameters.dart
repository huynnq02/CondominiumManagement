import 'dart:convert';

class Parameters {
  String? screen;
  String? operationSystem;
  String? afterCamera;
  String? beforeCamera;
  String? chip;
  String? ram;
  String? internalMemory;
  String? sim;
  String? battery;

  Parameters(
      {this.screen,
      this.afterCamera,
      this.battery,
      this.beforeCamera,
      this.chip,
      this.internalMemory,
      this.operationSystem,
      this.ram,
      this.sim});

  Map<String, dynamic> toMap() {
    return {
      'screen': screen,
      'operationSystem': operationSystem,
      'afterCamera': afterCamera,
      'beforeCamera': beforeCamera,
      'chip': chip,
      'ram': ram,
      'battery': battery,
      'internalMemory': internalMemory,
      'sim': sim,
    };
  }

  factory Parameters.fromMap(Map<String, dynamic> map) {
    return Parameters(
        screen: map['screen'],
        operationSystem: map['oparationSystem'],
        afterCamera: map['afterCamera'],
        beforeCamera: map['beforeCamera'],
        chip: map['chip'],
        ram: map['ram'],
        internalMemory: map['internalMemory'],
        battery: map['battery'],
        sim: map['sim']);
  }

  String toJson() => json.encode(toMap());

  factory Parameters.fromJson(String source) =>
      Parameters.fromMap(json.decode(source));
}
