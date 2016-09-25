//
//  Created by Pawel Scibek on 25/09/16.
//  Copyright © 2016 Pawel Scibek. All rights reserved.
//

import Foundation
import Swinject

class GeneralAssembly: AssemblyType {
	func assemble(container: Container) {
		registerAppLifeCycleBroadcasterInContainer(container)
	}
}

private extension GeneralAssembly {
	private func registerAppLifeCycleBroadcasterInContainer(container: Container) {
		container.register(AppLifeCycleEventBroadcaster.self) { _ in
			return AppLifeCycleEventBroadcaster()
		}.inObjectScope(.Container)
	}
}
