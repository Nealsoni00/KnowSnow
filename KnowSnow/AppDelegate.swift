//
//  AppDelegate.swift
//  KnowSnow
//
//  Created by Jack Sharkey on 2/17/17.
//  Copyright © 2017 Jack Sharkey. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import AirshipKit
import GoogleMobileAds

@UIApplicationMain


class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    

    

    var window: UIWindow?
    var tabBarController: UITabBarController?
    

    let defaults = UserDefaults.standard

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        //        RetrieveMapInfo().initFunc(date: Date().tomorrow, completion: );
        GADMobileAds.configure(withApplicationID: "ca-app-pub-6421137549100021~9702408169")

        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        FirebaseApp.configure()

        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
  
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loader = storyboard.instantiateViewController(withIdentifier: "SplashScreenViewController") as! LaunchScreenViewController
        self.window?.rootViewController = loader
        let config: UAConfig = UAConfig.default()

        UAirship.takeOff(config)


      return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        ConnectToFCM()
    }
    

    
    
  
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        Messaging.messaging().shouldEstablishDirectChannel = false

        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        ConnectToFCM()

        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func applicationDidFinishLaunching(_ application: UIApplication) {
     
        
    }
    
    // The callback to handle data message received via FCM for devices running iOS 10 or above.
    func application(received remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    
    func ConnectToFCM() {
        Messaging.messaging().shouldEstablishDirectChannel = true
        
        if let token = InstanceID.instanceID().token() {
            print("DCS: " + token)
        }
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "com.DouglasDevlops.BadgeWasUpdated"), object: nil)
    }
    

  
    


}

extension Date {
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
}

