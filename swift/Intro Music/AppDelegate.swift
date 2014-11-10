//
//  AppDelegate.swift
//  Intro Music
//
//  Created by Christopher Sexton on 9/21/14.
//  Copyright (c) 2014 Radius Networks. All rights reserved.
//

import UIKit
import CoreLocation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

  var window: UIWindow?
  var locationManager: CLLocationManager?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.



    //let uuidString = "DEADBEEF-DEAD-4444-BEEF-DEADBEEFDEAD"
    //let uuidString = "AA003D12-0FFC-4D5F-836A-4FB3306ED6BD"
    let uuidString = "1313AAAA-4D60-42D4-92C1-94667C771306"
    let beaconIdentifier = "com.radiusnetworks.intro-music"
    let beaconUUID:NSUUID = NSUUID(UUIDString: uuidString)
    let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID,
      identifier: beaconIdentifier)

    locationManager = CLLocationManager()
    if(locationManager!.respondsToSelector("requestAlwaysAuthorization")) {
      locationManager!.requestAlwaysAuthorization()
    }
    locationManager!.delegate = self
    locationManager!.pausesLocationUpdatesAutomatically = false

    locationManager!.startMonitoringForRegion(beaconRegion)
    locationManager!.startRangingBeaconsInRegion(beaconRegion)
    locationManager!.startUpdatingLocation()


    if(application.respondsToSelector("registerUserNotificationSettings:")) {
      application.registerUserNotificationSettings(
        UIUserNotificationSettings(
          forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Sound,
          categories: nil
        )
      )
    }

    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }

  //  MARK: Beacon Stuff
  func sendLocalNotificationWithMessage(message: String!) {
    let notification:UILocalNotification = UILocalNotification()
    notification.alertBody = message
    UIApplication.sharedApplication().scheduleLocalNotification(notification)
  }

  func locationManager(manager: CLLocationManager!,
    didRangeBeacons beacons: [AnyObject]!,
    inRegion region: CLBeaconRegion!) {
      NSLog("didRangeBeacons");
      var message:String = ""

      if(beacons.count > 0) {

        post()


        let nearestBeacon:CLBeacon = beacons[0] as CLBeacon

        switch nearestBeacon.proximity {
        case CLProximity.Far:
          message = "You are far away from the beacon"
        case CLProximity.Near:
          message = "You are near the beacon"
        case CLProximity.Immediate:
          message = "You are in the immediate proximity of the beacon"
        case CLProximity.Unknown:
          return
        }
      } else {
        message = "No beacons are nearby"
      }

      NSLog("%@", message)
      sendLocalNotificationWithMessage(message)
  }

  func locationManager(manager: CLLocationManager!,
    didEnterRegion region: CLRegion!) {
      manager.startRangingBeaconsInRegion(region as CLBeaconRegion)
      manager.startUpdatingLocation()

      NSLog("You entered the region")
      sendLocalNotificationWithMessage("You entered the region")
  }

  func locationManager(manager: CLLocationManager!,
    didExitRegion region: CLRegion!) {
      manager.stopRangingBeaconsInRegion(region as CLBeaconRegion)
      manager.stopUpdatingLocation()

      NSLog("You exited the region")
      sendLocalNotificationWithMessage("You exited the region")
  }

  // MARK: Post to API
  func post(){

    var name: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("name")

    let url = NSURL(string:"http://48584cca.ngrok.com")
    let cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
    var request = NSMutableURLRequest(URL: url, cachePolicy: cachePolicy, timeoutInterval: 2.0)
    request.HTTPMethod = "POST"

    //NSURLProtocol.setProperty("application/json", forKey: "Content-Type", inRequest: request)
    // set data
    var dataString = "name=\(name!)"
    let requestBodyData = (dataString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
    request.HTTPBody = requestBodyData

    // set content length
    NSURLProtocol.setProperty(requestBodyData!.length, forKey: "Content-Length", inRequest: request)

    var response: NSURLResponse? = nil
    var error: NSError? = nil
    let reply = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&error)

    if (error == nil) {
      let results = NSString(data:reply!, encoding:NSUTF8StringEncoding)
      println("API Response: \(results)")
    }
  }





}
