public enum NoteKind: Int {
    case WholeNote = 1
    case HalfNote = 2
    case QuarterNote = 4
    case EighthNote = 8
    case SixteenthNotes = 16
    
    static func allValues() -> [NoteKind] {
        return [WholeNote, HalfNote, QuarterNote, EighthNote, SixteenthNotes]
    }
}

extension NoteKind: CustomStringConvertible {
    public var description: String {
        return "\(rawValue)"
    }
}
