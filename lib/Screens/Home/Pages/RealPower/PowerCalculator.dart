import 'devices.dart';

class PowerCalculator {
  static double calculateTotalConsumption(List<Device> devices) {
    return devices
        .where((device) => device.isOn)
        .fold(0.0, (sum, device) => sum + device.power);
  }

  static double calculatePowerDifference(double availablePower, double totalConsumption) {
    return availablePower - totalConsumption;
  }
}