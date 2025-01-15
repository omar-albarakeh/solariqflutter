import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

class WeatherAnimationManager {
  static Widget getCloudIcon(String cloudSituation) {
    switch (cloudSituation.toLowerCase()) {
      case 'clear sky':
        return WeatherScene.scorchingSun.sceneWidget;
      case 'few clouds':
        return WeatherScene.scorchingSun.sceneWidget;
      case 'scattered clouds':
        return WeatherScene.frosty.sceneWidget;
      case 'broken clouds':
        return WeatherScene.weatherEvery.sceneWidget;
      case 'overcast clouds':
        return WeatherScene.frosty.sceneWidget;
      case 'light rain':
        return WeatherScene.weatherEvery.sceneWidget;
      case 'moderate rain':
        return WeatherScene.showerSleet.sceneWidget;
      case 'heavy intensity rain':
        return WeatherScene.stormy.sceneWidget;
      default:
        return WeatherScene.snowfall.sceneWidget;
    }
  }
}