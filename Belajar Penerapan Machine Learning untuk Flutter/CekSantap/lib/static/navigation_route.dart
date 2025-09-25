enum NavigationRoute {
  splashRoute("/splash"),
  mainRoute("/home"),
  settingsRoute("/settings"),
  pickerCameraRoute("/picker_camera"),
  liveCameraRoute("/live_camera");

  const NavigationRoute(this.name);
  final String name;
}
