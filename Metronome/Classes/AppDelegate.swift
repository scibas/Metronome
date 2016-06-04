//
//  Created by Pawel Scibek on 04/06/16.
//  Copyright © 2016 Pawel Scibek. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
    var metronomeEngine: MetronomeEngine?
    
    
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		
		let audioEngine = AudioEngine()
        metronomeEngine = MetronomeEngine(withAudioEngine: audioEngine, andSoundBank: SoundsBank())
    
        let maiViewController = MainScreenViewController(metronomeEngine: metronomeEngine!, ae: audioEngine)
		
		let window = UIWindow(frame: UIScreen.mainScreen().bounds)
		window.rootViewController = maiViewController
		window.makeKeyAndVisible()
		self.window = window
		
		return true
	}
}

