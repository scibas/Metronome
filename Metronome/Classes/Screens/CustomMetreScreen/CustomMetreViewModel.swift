protocol CustomMetreViewModelDelegateProtocol: class {
	func customMetreViewModel(viewModel: CustomMetreViewModel, didChangeMetre newMetre: Metre)
}

class CustomMetreViewModel {
	weak var delegate: CustomMetreViewModelDelegateProtocol?
	private let model: CustomMetreModel
	
    struct Defaults {
        static let defaultMatre = Metre.threeByFour()
        static let minimumMetre = 1
        static let maximumMetre = 12
    }
    
	private(set) var currentMetre: Metre {
		didSet { delegate?.customMetreViewModel(self, didChangeMetre: currentMetre) }
	}
	
    init(withModel model: CustomMetreModel, currentMetre: Metre?) {
		self.currentMetre = currentMetre ?? Defaults.defaultMatre
		self.model = model
	}
	
	func increaseMetre() {
		currentMetre = Metre(beat: currentMetre.beat + 1, noteKind: currentMetre.noteKind)
	}
	
	func decreaseMetre() {
		currentMetre = Metre(beat: currentMetre.beat - 1, noteKind: currentMetre.noteKind)
	}
	
	func increaseNoteKind() {
		if let nextNoteKind = currentMetre.noteKind.successor() {
			currentMetre = Metre(beat: currentMetre.beat, noteKind: nextNoteKind)
		}
	}
	
	func decreaseNoteKind() {
		if let previousNoteKind = currentMetre.noteKind.predecessor() {
			currentMetre = Metre(beat: currentMetre.beat, noteKind: previousNoteKind)
		}
	}
	
	func canDecreaseMetre() -> Bool {
        return currentMetre.beat > Defaults.minimumMetre
    }
    
	func canIncreaseMetre() -> Bool {
        return currentMetre.beat < Defaults.maximumMetre
    }
	
	func canDecreaseNoteKind() -> Bool {
		return currentMetre.noteKind.hasPredecessor()
	}
	
	func canIncreaseNoteKind() -> Bool {
		return currentMetre.noteKind.hasSuccessor()
	}
    
    func applyNewMetrum() {
        model.applyMetreToMetronomeEngine(currentMetre)
    }
}

private extension NoteKind{
	func successor() -> NoteKind? {
		let curentIndex = NoteKind.allValues().indexOf(self)
		guard self.hasSuccessor() else { return nil }
		return NoteKind.allValues()[curentIndex! + 1]
	}
	
	func predecessor() -> NoteKind? {
		let curentIndex = NoteKind.allValues().indexOf(self)
		guard self.hasPredecessor() else { return nil }
		return NoteKind.allValues()[curentIndex! - 1]
	}
	
	func hasSuccessor() -> Bool {
		let curentIndex = NoteKind.allValues().indexOf(self)
		return curentIndex < NoteKind.allValues().count - 1
	}
	
	func hasPredecessor() -> Bool {
		let curentIndex = NoteKind.allValues().indexOf(self)
		return curentIndex > 0
	}
}
