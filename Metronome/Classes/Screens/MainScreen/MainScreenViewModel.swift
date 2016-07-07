import Foundation

class MainScreenViewModel {
	private var metronomeEngine: MetronomeEngineProtocol
	private var userSettingsStorage: UserSettingsStorage
    private var metreBank = MetreBank()
    
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
        
        metreBank.setMetre(.twoByFour(), forIndex: 0)
        metreBank.setMetre(.threeByFour(), forIndex: 1)
        metreBank.setMetre(.fourByFour(), forIndex: 2)
        metreBank.setMetre(.sixByEight(), forIndex: 4)
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
	
    func setMetreFromBankIndex(bankIndex: Int) {
        let metre = metreBank.metreForIndex(bankIndex)
        metronomeEngine.metre = metre
    }
    
    func storeMetre(metre: Metre, forBankIndex bankIndex: Int) {
        metreBank.setMetre(metre, forIndex: bankIndex)
    }
	
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
