class Device {
  final String name;
  final int power;
  bool isOn;

  Device({required this.name, required this.power, this.isOn = false});
}