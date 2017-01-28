//
//  Created by Pawel Scibek on 25/09/16.
//  Copyright © 2016 Pawel Scibek. All rights reserved.
//

import Foundation

protocol AppLifeCycleEventObserver: class {
    func didReciveAppLifeCycleEvent(_ event: AppLifeCycleEvents)
}

enum AppLifeCycleEvents {
    case willEnterForeground
    case didEnterBackground
}

class AppLifeCycleEventBroadcaster {
    fileprivate var observers = NSHashTable<AnyObject>(options: NSPointerFunctions.Options.weakMemory)
    
    func registerObserver(_ observer: AppLifeCycleEventObserver) {
        observers.add(observer)
    }
    
    func removeObserver(_ observer: AppLifeCycleEventObserver) {
        observers.remove(observer)
    }
    
    func broadcastLifecycleEvent(_ lifeCycleEvent: AppLifeCycleEvents) {
        for observer in observers.allObjects {
            let appLifecycleEventObserver = observer as! AppLifeCycleEventObserver
            appLifecycleEventObserver.didReciveAppLifeCycleEvent(lifeCycleEvent)
        }
    }
}
