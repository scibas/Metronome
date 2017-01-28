public struct SoundSample: Equatable {
	var name: String
	var normalMidiNote: UInt8
	var emphasedMidiNote: UInt8
}

public func ==(lhs: SoundSample, rhs: SoundSample) -> Bool {
	return lhs.name == rhs.name
    && lhs.normalMidiNote == rhs.normalMidiNote
    && lhs.emphasedMidiNote == lhs.emphasedMidiNote
}

struct SoundsBank {
	var bank: [SoundSample] = {
		return [
			SoundSample(name: "Rimshot", normalMidiNote: 48, emphasedMidiNote: 49),
			SoundSample(name: "Hi-Hat", normalMidiNote: 50, emphasedMidiNote: 51),
			SoundSample(name: "Old clock", normalMidiNote: 52, emphasedMidiNote: 53),
			SoundSample(name: "Cow bell", normalMidiNote: 54, emphasedMidiNote: 55),
			SoundSample(name: "Beep", normalMidiNote: 56, emphasedMidiNote: 57),
			SoundSample(name: "Fingersnap", normalMidiNote: 58, emphasedMidiNote: 59),
			SoundSample(name: "Clasic", normalMidiNote: 60, emphasedMidiNote: 61),
			SoundSample(name: "Triangle", normalMidiNote: 62, emphasedMidiNote: 63),
			SoundSample(name: "Woodstick 1", normalMidiNote: 64, emphasedMidiNote: 65),
			SoundSample(name: "Woodstick 2", normalMidiNote: 66, emphasedMidiNote: 67),
			SoundSample(name: "Tone 1", normalMidiNote: 68, emphasedMidiNote: 69),
			SoundSample(name: "Tone 2", normalMidiNote: 70, emphasedMidiNote: 71),
		]
	}()
}