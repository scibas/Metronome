import Foundation
import AVFoundation

class SequenceComposer {
	static var defaultTempoForQuaterNote: Double { return 120.0 }
    static var noteForDefaultTempo: NoteKindOf = .QuarterNote
	
	static func prepareSequenceForMetre(metre: Metre, soundSample: SoundSample, emphasisEnabled: Bool) -> MusicSequence {
		var musicSequence: MusicSequence = nil
		var result = NewMusicSequence(&musicSequence);
		assert(result == noErr, "Creating music sequence error: \(result)")
		
		var musicTrack: MusicTrack = nil
		result = MusicSequenceNewTrack(musicSequence, &musicTrack)
		assert(result == noErr, "Creating track in sequence error: \(result)")
        
        let noteDuration = noteDurationForNoteKind(metre.noteKindOf)
        
		let normalNote = midiMessageForNote(soundSample.normalMidiNote, withDuration: noteDuration)
		let emphasisNote = midiMessageForNote(soundSample.emphasedMidiNote, withDuration: noteDuration)
		
		let numberOfNotesInBar = metre.beat
		
		for noteIndex in 0 ..< numberOfNotesInBar {
			let isFirstNoteInBar = (noteIndex == 0)
			var noteToAdd = (isFirstNoteInBar && emphasisEnabled) ? emphasisNote : normalNote
			
			result = MusicTrackNewMIDINoteEvent(musicTrack, MusicTimeStamp(Float32(noteIndex) * noteDuration), &noteToAdd)
			assert(result == noErr, "Adding event to midi sequence error: \(result)")
		}
		
		CAShow(UnsafeMutablePointer<MusicSequence>(musicSequence))
		
		return musicSequence
	}
	
    private static func noteDurationForNoteKind(noteKind: NoteKindOf) -> Float32{
        return Float32(noteForDefaultTempo.rawValue) / Float32(noteKind.rawValue)
    }
    
    private static func midiMessageForNote(note: UInt8, withDuration duration: Float32) -> MIDINoteMessage {
		return MIDINoteMessage(
			channel: 0,
			note: note,
			velocity: UInt8.max,
			releaseVelocity: 0,
			duration: duration)
	}
}
