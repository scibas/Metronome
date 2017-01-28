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
    
	@objc func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setupDependencyInjectionFramework()
        
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        flowController = FlowController(withWindow: window)
        flowController?.showMainScren()
        
		return true
	}
	
	private func setupDependencyInjectionFramework() {
		assembler = try! Assembler(assemblies: [
            GeneralAssembly(),
			AudioEngineAssembly(),
			ScreensAssembly()
		])
	}
    
    @objc private func applicationWillEnterForeground(application: UIApplication) {
        appLifeCycleEventBroadcaster.broadcastLifecycleEvent(.WillEnterForeground)
    }
    
    @objc private func applicationDidEnterBackground(application: UIApplication) {
        appLifeCycleEventBroadcaster.broadcastLifecycleEvent(.DidEnterBackground)
    }
}

protocol WithResolver {
    func resolver() -> Resolvable
}

extension WithResolver {
    func resolver() -> Resolvable {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).assembler!.resolver
    }
}
