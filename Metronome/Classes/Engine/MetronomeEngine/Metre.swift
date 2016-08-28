import Foundation

public struct Metre {
	var beat: Int
	var noteKind: NoteKind
}

extension Metre {
	static func twoByFour() -> Metre { return Metre(beat: 2, noteKind: .QuarterNote) }
	static func threeByFour() -> Metre { return Metre(beat: 3, noteKind: .QuarterNote) }
	static func fourByFour() -> Metre { return Metre(beat: 4, noteKind: .QuarterNote) }
	static func sixByEight() -> Metre { return Metre(beat: 6, noteKind: .EighthNote) }
}

extension Metre: CustomStringConvertible {
    public var description: String {
        return "\(beat)/\(noteKind)"
    }
}