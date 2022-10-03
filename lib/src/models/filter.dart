class FilterModel {
  bool screen = false;
  bool camera = false;
  bool feature = false;
  bool battery = false;
  bool design = false;
  bool storage = false;
  bool price = false;
  bool performance = false;
  FilterModel({
    screen,
    camera,
    feature,
    battery,
    design,
    storage,
    price,
    performance,
  });

  void changeScreenState() {
    this.screen = !this.screen;
  }

  void changeCameraState() {
    this.camera = !this.camera;
  }

  void changeFeatureState() {
    this.feature = !this.feature;
  }

  void changeBatteryState() {
    this.battery = !this.battery;
  }

  void changeDesignState() {
    this.design = !this.design;
  }

  void changeStorageState() {
    this.storage = !this.storage;
  }

  void changePriceState() {
    this.price = !this.price;
  }

  void changePerformanceState() {
    this.performance = !this.performance;
  }
}
