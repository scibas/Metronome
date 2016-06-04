import Foundation

struct Metre {
    var beat: Int
    var noteKindOf: NoteKindOf
    
    static func twoByFour() -> Metre { return Metre(beat: 2, noteKindOf: .QuarterNote) }
    static func threeByFour() -> Metre { return Metre(beat: 3, noteKindOf: .QuarterNote) }
    static func fourByFour() -> Metre { return Metre(beat: 4, noteKindOf: .QuarterNote) }
    static func sixByEight() -> Metre { return Metre(beat: 6, noteKindOf: .EighthNote) }
}

enum NoteKindOf: Int {
    case WholeNote = 1
    case HalfNote = 2
    case QuarterNote = 4
    case EighthNote = 8
    case SixteenthNotes = 16
}

