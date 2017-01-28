public enum NoteKind: Int {
    case wholeNote = 1
    case halfNote = 2
    case quarterNote = 4
    case eighthNote = 8
    case sixteenthNotes = 16
    
    static func allValues() -> [NoteKind] {
        return [wholeNote, halfNote, quarterNote, eighthNote, sixteenthNotes]
    }
}

extension NoteKind: CustomStringConvertible {
    public var description: String {
        return "\(rawValue)"
    }
}
