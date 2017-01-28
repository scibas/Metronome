//
//  Created by Pawel Scibek on 25/09/16.
//  Copyright © 2016 Pawel Scibek. All rights reserved.
//

import Foundation

protocol AppLifeCycleEventObserver: class {
    func didReciveAppLifeCycleEvent(event: AppLifeCycleEvents)
}

enum AppLifeCycleEvents {
    case WillEnterForeground
    case DidEnterBackground
}

class AppLifeCycleEventBroadcaster {
    private var observers = NSHashTable(options: .WeakMemory)
    
    func registerObserver(observer: AppLifeCycleEventObserver) {
        observers.addObject(observer)
    }
    
    func removeObserver(observer: AppLifeCycleEventObserver) {
        observers.removeObject(observer)
    }
    
    func broadcastLifecycleEvent(lifeCycleEvent: AppLifeCycleEvents) {
        for observer in observers.allObjects {
            let appLifecycleEventObserver = observer as! AppLifeCycleEventObserver
            appLifecycleEventObserver.didReciveAppLifeCycleEvent(lifeCycleEvent)
        }
    }
}