//
//  AppDelegate.swift
//  MapText
//
//  Created by Ronald Chan on 7/23/18.
//  Copyright © 2018 Ronald Chan. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import Firebase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager: CLLocationManager!
    var currentLoc:CLLocation?
    var prevLoc:CLLocation?
    var locs:[NotificationLocation]=[]
    var appActive:Bool=true
    static var updated=false
    static var loggedIn=false
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        
        configureInitialRootViewController(for: window)
        initLocationManager()
        return true
    }
    
    func initLocationManager() {
       
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter=30
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways {
            locationManager.allowsBackgroundLocationUpdates=true
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if AppDelegate.loggedIn {
            if appActive && !AppDelegate.updated{
                UserService.locs(for: User.current) { (locs) in
                    self.locs = locs
                }
                AppDelegate.updated=true
            }
            currentLoc=CLLocation(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
            if let prev=prevLoc {
                print(prev.distance(from: currentLoc!) )
                for loc in locs {
                    print(loc.name)
                    if loc.locationActive {
                        let formatted=CLLocation(latitude: loc.latitude, longitude: loc.longitude)
                        if !loc.recentlyTriggered && formatted.distance(from: currentLoc!)<100 {
                            SMSHelper.sendMessage(loc: loc)
                            LocationService.updateValue(locKey: loc.key!, key: "recentlyTriggered", val: true)
                            loc.recentlyTriggered=true
                        }
                        if formatted.distance(from: currentLoc!)>300 {
                            LocationService.updateValue(locKey: loc.key!, key: "recentlyTriggered", val: false)
                            loc.recentlyTriggered=false
                        }
                    }
                }
            }
            prevLoc=currentLoc
        }
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        appActive=false
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        appActive=true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "MapText")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
extension AppDelegate {
    func configureInitialRootViewController(for window: UIWindow?) {
        let defaults = UserDefaults.standard
        let initialViewController: UIViewController
        
        if let _ = Auth.auth().currentUser,
            let userData = defaults.object(forKey: Constants.UserDefaults.currentUser) as? Data,
            let user = try? JSONDecoder().decode(User.self, from: userData) {
            User.setCurrent(user)
            AppDelegate.loggedIn=true
            initialViewController = UIStoryboard.initialViewController(for: .main)
        } else {
            initialViewController = UIStoryboard.initialViewController(for: .login)
        }
        
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }
}

