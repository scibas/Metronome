//
//  Created by Pawel Scibek on 04/06/16.
//  Copyright © 2016 Pawel Scibek. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
private final class AppDelegate: UIResponder, UIApplicationDelegate, WithResolver {
    var assembler: Assembler?
    lazy var appLifeCycleEventBroadcaster: AppLifeCycleEventBroadcaster = self.resolver().resolve(AppLifeCycleEventBroadcaster.self)!

    @objc var window: UIWindow?
    var flowController: FlowController?
    
	@objc func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configureAppApperance()
        
        setupDependencyInjectionFramework()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        flowController = FlowController(withWindow: window)
        flowController?.showMainScren()
        
		return true
	}
	
	fileprivate func setupDependencyInjectionFramework() {
		assembler = try! Assembler(assemblies: [
            GeneralAssembly(),
			AudioEngineAssembly(),
			ScreensAssembly()
		])
	}
    
    @objc fileprivate func applicationWillEnterForeground(_ application: UIApplication) {
        appLifeCycleEventBroadcaster.broadcastLifecycleEvent(.willEnterForeground)
    }
    
    @objc fileprivate func applicationDidEnterBackground(_ application: UIApplication) {
        appLifeCycleEventBroadcaster.broadcastLifecycleEvent(.didEnterBackground)
    }
    
    private func configureAppApperance() {
        UIView.appearance().tintColor = UIColor.metreButtonNormalStateColor() //FixMe: rename to more generic color name
    }
}

protocol WithResolver {
    func resolver() -> Resolver
}

extension WithResolver {
    func resolver() -> Resolver {
        return (UIApplication.shared.delegate as! AppDelegate).assembler!.resolver
    }
}
