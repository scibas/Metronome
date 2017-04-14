import Foundation

protocol MainScreenViewModelDelegate: class {
	func viewModel(_ viewModel: MainScreenViewModel, didChangeTemp newTempo: BPM)
	func viewModel(_ viewModel: MainScreenViewModel, didChangeSelectedBank bankIndex: Int)
	func viewModel(_ viewModel: MainScreenViewModel, didChangeMetre metre: Metre, forBank bankIndex: Int)
}

class MainScreenViewModel {
	weak var delegate: MainScreenViewModelDelegate?

    var metronomeEngine: MetronomeEngineProtocol // fixMe: make private again
	fileprivate var userSettingsStorage: UserSettingsStorage
    let metreBank: MetreBank
    
	struct DefaultSettings {
		static let metre = Metre.twoByFour()
		static let tempo = BPM(120)
		static let emphasisEnabled = true
	}

    init(metronomeEngine: MetronomeEngineProtocol, metreBank: MetreBank, userSettingsStorage: UserSettingsStorage) {
		self.metronomeEngine = metronomeEngine
        self.metreBank = metreBank
		self.userSettingsStorage = userSettingsStorage

		restoreUserSettingsFromStorage(userSettingsStorage)

		metreBank.set(.twoByFour(), at: 0)
		metreBank.set(.threeByFour(), at: 1)
		metreBank.set(.fourByFour(), at: 2)
		metreBank.set(.sixByEight(), at: 3)
	}

	func restoreUserSettingsFromStorage(_ storage: UserSettingsStorage) {
		tempo = storage.tempo ?? DefaultSettings.tempo
	}

	func toggleStartStop() throws {
		if metronomeEngine.isPlaying {
			metronomeEngine.stop()
		} else {
			try metronomeEngine.start()
		}
	}

	func setMetreFromBankIndex(_ bankIndex: Int) {
        let metre = metreBank.metre(for: bankIndex)
		metronomeEngine.metre = metre

		delegate?.viewModel(self, didChangeSelectedBank: bankIndex)
	}

	func storeMetre(_ metre: Metre, forBankIndex bankIndex: Int) {
		metreBank.set(metre, at: bankIndex)

		delegate?.viewModel(self, didChangeMetre: metre, forBank: bankIndex)
	}

	var tempo: BPM {
		set(newBpmValue) {
			metronomeEngine.tempo = newBpmValue
			userSettingsStorage.tempo = newBpmValue

			delegate?.viewModel(self, didChangeTemp: newBpmValue)
		}

		get {
			return metronomeEngine.tempo! // FixMe: find out if can resign of optional in metronome engine
		}
	}
}
