//
//  Created by Pawel Scibek on 25/09/16.
//  Copyright © 2016 Pawel Scibek. All rights reserved.
//

import Foundation
import Swinject

class GeneralAssembly: Assembly {
	func assemble(container: Container) {
		registerAppLifeCycleBroadcasterInContainer(container)
	}
}

private extension GeneralAssembly {
	func registerAppLifeCycleBroadcasterInContainer(_ container: Container) {
		container.register(AppLifeCycleEventBroadcaster.self) { _ in
			return AppLifeCycleEventBroadcaster()
		}.inObjectScope(.container)
	}
}
