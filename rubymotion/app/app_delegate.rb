class AppDelegate
  attr_reader :region, :manager, :last_broadcast, :window


  def application(application, didFinishLaunchingWithOptions:launchOptions)
    # Add your token and preferred channel.

    start_monitoring

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    window.makeKeyAndVisible
    window.rootViewController = MainController.alloc.init

    true
  end


  def start_monitoring
    NSLog("starting monitoring")
    @last_broadcast = Time.now - 120
    region = beacon_region
    location_manager.startMonitoringForRegion(region)
    location_manager.startRangingBeaconsInRegion(region)
  end

  def locationManager(manager, didEnterRegion: region)
    NSLog("didEnterRegion")
    manager.startRangingBeaconsInRegion(region) if region.isKindOfClass(CLBeaconRegion)
  end

  def locationManager(manager, didExitRegion: region)
    NSLog("didExitRegion")
    if region.isKindOfClass(CLBeaconRegion)
      Broadcast.new.send("didExitRegion" )
    end
  end

  def locationManager(manager, didRangeBeacons: beacons, inRegion: region)
    #if last_broadcast < (Time.now - 120)
    #  Broadcast.new("didRangeBeacons").send
    #end
    #  if beacons.last.proximity == CLProximityNear
    #    Broadcast.new("Office Arrival: willrax" ).send
    #    @last_broadcast = Time.now
    #  end
    #end
    if beacons.length > 0
      Broadcast.new.send("didRangeBeacons")
    end
  end

  def locationManager(manager, didFailWithError: error)
    NSLog "failed with errored %@", error
  end

  def beacon_region
    #uuid = NSUUID.alloc.initWithUUIDString("1313AAAA-4D60-42D4-92C1-94667C771306")
    uuid = NSUUID.alloc.initWithUUIDString "C61652EF-D55A-41B2-8629-DA935A483365"
    beacon = CLBeaconRegion.alloc.initWithProximityUUID(uuid, identifier: "com.csexton.epic")
    beacon.notifyOnEntry = true
    beacon.notifyOnExit = true
    beacon.notifyEntryStateOnDisplay = true
    NSLog "monitoring beacon: #{beacon.inspect}"
    beacon
  end

  def location_manager
    @location_manager ||= CLLocationManager.alloc.init.tap do |manager|
      manager.delegate = self
      manager.requestAlwaysAuthorization
    end
  end

end
