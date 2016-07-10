protocol CustomMetreViewModelDelegateProtocol: class {
	func customMetreViewModel(viewModel: CustomMetreViewModel, didChangeMetre newMetre: Metre)
}

class CustomMetreViewModel {
	weak var delegate: CustomMetreViewModelDelegateProtocol?
	private let model: CustomMetreModel
	
	private(set) var currentMetre: Metre {
		didSet { delegate?.customMetreViewModel(self, didChangeMetre: currentMetre) }
	}
	
	init(withModel model: CustomMetreModel) {
		currentMetre = Metre.fourByFour() // FixMe:
		self.model = model
	}
	
	func increaseMetre() {
		currentMetre = Metre(beat: currentMetre.beat + 1, noteKindOf: currentMetre.noteKindOf)
	}
	
	func decreaseMetre() {
		currentMetre = Metre(beat: currentMetre.beat - 1, noteKindOf: currentMetre.noteKindOf)
	}
	
	func increaseNoteKind() {
		if let nextNoteKind = currentMetre.noteKindOf.successor() {
			currentMetre = Metre(beat: currentMetre.beat, noteKindOf: nextNoteKind)
		}
	}
	
	func decreaseNoteKind() {
		if let previousNoteKind = currentMetre.noteKindOf.predecessor() {
			currentMetre = Metre(beat: currentMetre.beat, noteKindOf: previousNoteKind)
		}
	}
	
	func canDecreaseMetre() -> Bool {
        return currentMetre.beat > 1 //FixMe: extract to constants
    }
    
	func canIncreaseMetre() -> Bool {
        return currentMetre.beat < 12 //FixMe: extract to constants
    }
	
	func canDecreaseNoteKing() -> Bool {
		return currentMetre.noteKindOf.hasPredecessor()
	}
	
	func canIncreaseNoteKing() -> Bool {
		return currentMetre.noteKindOf.hasSuccessor()
	}
    
    func applyNewMetrum() {
        model.applyMetreToMetronomeEngine(currentMetre)
    }
}

extension NoteKindOf {
	func successor() -> NoteKindOf? {
		let curentIndex = NoteKindOf.allValues().indexOf(self)
		guard self.hasSuccessor() else { return nil }
		return NoteKindOf.allValues()[curentIndex! + 1]
	}
	
	func predecessor() -> NoteKindOf? {
		let curentIndex = NoteKindOf.allValues().indexOf(self)
		guard self.hasPredecessor() else { return nil }
		return NoteKindOf.allValues()[curentIndex! - 1]
	}
	
	func hasSuccessor() -> Bool {
		let curentIndex = NoteKindOf.allValues().indexOf(self)
		return curentIndex < NoteKindOf.allValues().count - 1
	}
	
	func hasPredecessor() -> Bool {
		let curentIndex = NoteKindOf.allValues().indexOf(self)
		return curentIndex > 0
	}
}
