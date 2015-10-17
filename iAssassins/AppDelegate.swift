import FBSDKCoreKit
import FBSDKLoginKit

class AppDelegate : UIResponder, UIApplicationDelegate {
    

    
    func application(application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
            
            return FBSDKApplicationDelegate.sharedInstance()
                .application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    func application(application: UIApplication, openURL url: NSURL,
        sourceApplication: String?, annotation: AnyObject) -> Bool {
            
            return FBSDKApplicationDelegate.sharedInstance()
                .application(application, openURL: url,
                    sourceApplication: sourceApplication, annotation: annotation)
    }
    
}