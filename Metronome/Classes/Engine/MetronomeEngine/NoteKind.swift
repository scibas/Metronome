public enum NoteKind: Int {
    case wholeNote = 1
    case halfNote = 2
    case quarterNote = 4
    case eighthNote = 8
    case sixteenthNotes = 16
}

extension NoteKind: CustomStringConvertible {
    public var description: String {
        return "\(rawValue)"
    }
}
