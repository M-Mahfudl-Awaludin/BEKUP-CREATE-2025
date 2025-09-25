enum NavigationRoute {
  splashRoute("/splash"),
  mainRoute("/main"),
  detailRoute("/detail"),
  bookmarkRoute("/bookmark");

  const NavigationRoute(this.name);
  final String name;
}
