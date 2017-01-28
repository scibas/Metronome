import Foundation

public struct Metre {
	var beat: Int
	var noteKind: NoteKind
}

extension Metre {
	static func twoByFour() -> Metre { return Metre(beat: 2, noteKind: .quarterNote) }
	static func threeByFour() -> Metre { return Metre(beat: 3, noteKind: .quarterNote) }
	static func fourByFour() -> Metre { return Metre(beat: 4, noteKind: .quarterNote) }
	static func sixByEight() -> Metre { return Metre(beat: 6, noteKind: .eighthNote) }
}

extension Metre: CustomStringConvertible {
    public var description: String {
        return "\(beat)/\(noteKind)"
    }
}
