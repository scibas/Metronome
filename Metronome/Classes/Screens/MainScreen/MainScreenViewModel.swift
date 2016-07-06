import Foundation

class MainScreenViewModel {
	private var metronomeEngine: MetronomeEngineProtocol
	private var userSettingsStorage: UserSettingsStorage
	
	var isPlaying: Bool { return metronomeEngine.isPlaying }
	
	struct DefaultSettings {
		static let metre = Metre.twoByFour()
		static let tempo = BPM(120)
		static let emphasisEnabled = true
	}
	
	init(metronomeEngine: MetronomeEngineProtocol, userSettingsStorage: UserSettingsStorage) {
		self.metronomeEngine = metronomeEngine
		self.userSettingsStorage = userSettingsStorage
		
		restoreUserSettingsFromStorage(userSettingsStorage)
	}
	
	func restoreUserSettingsFromStorage(storage: UserSettingsStorage) {
		tempo = storage.tempo ?? DefaultSettings.tempo
		emphasisEnabled = DefaultSettings.emphasisEnabled
	}
	
	func startMetronome() throws {
		try metronomeEngine.start()
	}
	
	func stopMetronome() {
		metronomeEngine.stop()
	}
    
    func toggleStartStop() throws {
        if isPlaying {
            stopMetronome()
        } else {
            try startMetronome()
        }
    }
	
	var metreBank: [Metre]?
	
	var tempo: BPM? {
		set(newBpmValue) {
			metronomeEngine.tempo = newBpmValue
			userSettingsStorage.tempo = newBpmValue
		}
		
		get {
			return metronomeEngine.tempo
		}
	}
	
	var emphasisEnabled: Bool? {
		set(newEmphasisEnabledValue) {
			metronomeEngine.emphasisEnabled = newEmphasisEnabledValue
			userSettingsStorage.emphasisEnabled = newEmphasisEnabledValue
		}
		
		get {
			return metronomeEngine.emphasisEnabled
		}
	}
}
