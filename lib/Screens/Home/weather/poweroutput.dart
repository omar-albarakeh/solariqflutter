class PowerOutputCalculator {
  final double systemSize;
  final double efficiency;
  final double performanceRatio;

  PowerOutputCalculator({
    this.systemSize = 5.0,
    this.efficiency = 0.18,
    this.performanceRatio = 0.85,
  });

  double calculatePowerOutput(double shortwaveRadiation) {
    return shortwaveRadiation * systemSize * efficiency * performanceRatio;
  }
}