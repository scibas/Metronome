//
//  Created by Pawel Scibek on 24/09/16.
//  Copyright © 2016 Pawel Scibek. All rights reserved.
//

final class SelectSoundModel {
    let soundBank: [SoundSample]
    fileprivate let metronomeEngine: MetronomeEngine

    init(withSoundBank soundBank: SoundsBank, andMetronomeEngine metronomeEngine: MetronomeEngine) {
        self.soundBank = soundBank.bank
        self.metronomeEngine = metronomeEngine
    }
    
    var currentSoundSample: SoundSample? {
        get {
            return metronomeEngine.soundSample
        }
    }
    
    func setSoundSample(_ soundSample: SoundSample) {
        metronomeEngine.soundSample = soundSample
    }
}
