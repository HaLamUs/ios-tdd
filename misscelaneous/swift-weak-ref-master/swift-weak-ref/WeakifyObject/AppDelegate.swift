//
//  Copyright © 2018 Essential Developer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let vc = window?.rootViewController as? WeatherViewController {
            let presenter = WeatherDataPresenter(output: WeakRef(vc))
            let weatherFetcher = FetchWeatherUseCase(output: presenter)
            vc.reloadData = weatherFetcher.fetch
        }
        
        return true
    }
}


final class WeakRef<T: AnyObject> {
    weak var object: T?
    
    init(_ object: T?) {
        self.object = object
    }
}

extension WeakRef: WeatherDataPresenterOutput where T: WeatherDataPresenterOutput {
    func present(_ weather: WeatherViewModel) {
        object?.present(weather)
    }
    
}
