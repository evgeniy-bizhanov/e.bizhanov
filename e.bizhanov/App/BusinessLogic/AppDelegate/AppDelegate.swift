import Crashlytics
import Fabric
import Swinject
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupDIContainer()
        
        Fabric.with([Crashlytics.self])
        
        return true
    }
}
