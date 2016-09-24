//
//  Created by Pawel Scibek on 24/09/16.
//  Copyright © 2016 Pawel Scibek. All rights reserved.
//

import UIKit

class SelectSoundViewModel {
	private let model: SelectSoundModel
	
	init(withModel model: SelectSoundModel) {
		self.model = model
	}
	
	func numberOfItemsForSection(section: Int) -> Int {
		return model.soundBank.count
	}
    
    func soundSampleForIndexPath(indexPath: NSIndexPath) -> SoundSample {
        return model.soundBank[indexPath.item]
    }
    
    func isSoundSampleCurentlySelected(soundSample: SoundSample) -> Bool {
        guard (model.currentSoundSample != nil) else {
            return false
        }
        
        return model.currentSoundSample! == soundSample
    }
    
    func setSoundSampleToAudioEngine(soundSample: SoundSample) {
        model.setSoundSample(soundSample)
    }
}
