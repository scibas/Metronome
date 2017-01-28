//
//  Created by Pawel Scibek on 24/09/16.
//  Copyright © 2016 Pawel Scibek. All rights reserved.
//

import UIKit

class SelectSoundViewModel {
	fileprivate let model: SelectSoundModel
	
	init(withModel model: SelectSoundModel) {
		self.model = model
	}
	
	func numberOfItemsForSection(_ section: Int) -> Int {
		return model.soundBank.count
	}
    
    func soundSampleForIndexPath(_ indexPath: IndexPath) -> SoundSample {
        return model.soundBank[indexPath.item]
    }
    
    func isSoundSampleCurentlySelected(_ soundSample: SoundSample) -> Bool {
        guard (model.currentSoundSample != nil) else {
            return false
        }
        
        return model.currentSoundSample! == soundSample
    }
    
    func setSoundSampleToAudioEngine(_ soundSample: SoundSample) {
        model.setSoundSample(soundSample)
    }
}
