import Foundation

protocol MainScreenViewModelDelegate: class {
	func viewModel(viewModel: MainScreenViewModel, didChangeTemp newTempo: BPM)
	func viewModel(viewModel: MainScreenViewModel, didChangeSelectedBank bankIndex: Int)
	func viewModel(viewModel: MainScreenViewModel, didChangeMetre metre: Metre, forBank bankIndex: Int)
}

class MainScreenViewModel {
	weak var delegate: MainScreenViewModelDelegate?

    var metronomeEngine: MetronomeEngineProtocol // fixMe: meke private again
	private var userSettingsStorage: UserSettingsStorage
    let metreBank = MetreBank()

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
		metreBank.setMetre(.sixByEight(), forIndex: 3)
	}

	func restoreUserSettingsFromStorage(storage: UserSettingsStorage) {
		tempo = storage.tempo ?? DefaultSettings.tempo
	}

	func toggleStartStop() throws {
		if metronomeEngine.isPlaying {
			metronomeEngine.stop()
		} else {
			try metronomeEngine.start()
		}
	}

	func setMetreFromBankIndex(bankIndex: Int) {
		let metre = metreBank.metreForIndex(bankIndex)
		metronomeEngine.metre = metre

		delegate?.viewModel(self, didChangeSelectedBank: bankIndex)
	}

	func storeMetre(metre: Metre, forBankIndex bankIndex: Int) {
		metreBank.setMetre(metre, forIndex: bankIndex)

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
