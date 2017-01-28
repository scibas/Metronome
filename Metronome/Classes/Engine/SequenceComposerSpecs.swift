import Nimble
import Quick
import AudioToolbox

@testable
import Metronome

class SequenceComposerSpecs: QuickSpec {
	override func spec() {
		describe("sould compose sequence with valid timing") {
			it("should have valid length sequense for variant metres") {
				
				let differentMetresForTesting: [Metre] = [.fourByFour(), Metre.sixByEight()]
				
				for metre in differentMetresForTesting {
					let soundSample = SoundSample(name: "", normalMidiNote: 50, emphasedMidiNote: 50)
					let sequence = SequenceComposer.prepareSequenceForMetre(metre, soundSample: soundSample, emphasisEnabled: false)
					
					var longestTrackLength: MusicTimeStamp = 0
					self.enumerateTracksInSequence(sequence, withClosure: { (index, track) in
						var trackLength: MusicTimeStamp = 0
						MusicTrackGetProperty(track, kSequenceTrackProperty_TrackLength, &trackLength, nil)
						
						longestTrackLength = max(longestTrackLength, trackLength)
					})
					
					let expectedLenght = Double(NoteKind.QuarterNote.rawValue) / Double(metre.noteKind.rawValue) * Double(metre.beat)
					
					expect(longestTrackLength).to(equal(expectedLenght))
				}
			}
		}
		
		describe("sould compose sequence with valid timing") {
			let metre = Metre.fourByFour()
			let soundSample = SoundSample(name: "Rimshot", normalMidiNote: 50, emphasedMidiNote: 50)
			let sequence = SequenceComposer.prepareSequenceForMetre(metre, soundSample: soundSample, emphasisEnabled: false)
			
			it("should have exactly one MIDI track") {
				var numberOfTracks = 0
				self.enumerateTracksInSequence(sequence, withClosure: { _ in
					numberOfTracks += 1
				})
				
				expect(numberOfTracks).to(equal(1))
			}
			
			it("should have correct number of MIDI_NOTE events in track") {
				var musicTrack: MusicTrack = nil
				MusicSequenceGetIndTrack(sequence, 0, &musicTrack)
				
				var numberOfEvents: Int = 0
				self.enumerateMidiEventsInTrack(musicTrack, withClosure: { _, eventType, _ in
					if (eventType == kMusicEventType_MIDINoteMessage) {
						numberOfEvents += 1
					}
				})
				
				expect(numberOfEvents).to(equal(metre.beat))
			}
		}
		
		describe("should compose sequence with valid emphasis state") {
			let metre = Metre.fourByFour()
			let normalMidiNote: UInt8 = 40
			let emphasedMidiNote: UInt8 = 50
			let soundSample = SoundSample(name: "Rimshot", normalMidiNote: normalMidiNote, emphasedMidiNote: emphasedMidiNote)
			
			it("shoud have first note emphased if emphasis enabled") {
				let sequence = SequenceComposer.prepareSequenceForMetre(metre, soundSample: soundSample, emphasisEnabled: true)
				
				var musicTrack: MusicTrack = nil
				MusicSequenceGetIndTrack(sequence, 0, &musicTrack)
				
				self.enumerateMidiEventsInTrack(musicTrack, withClosure: { (eventIndex, eventType, eventData) in
					if eventType == kMusicEventType_MIDINoteMessage {
						let data = UnsafePointer<MIDINoteMessage>(eventData)
						let midiMessage = data.memory
						
						let expectedMidiNote = eventIndex == 0 ? emphasedMidiNote : normalMidiNote
						
						expect(midiMessage.note).to(equal(expectedMidiNote))
					}
				})
			}
			
			it("shoud have all note normal if emphasis disabled") {
				let sequence = SequenceComposer.prepareSequenceForMetre(metre, soundSample: soundSample, emphasisEnabled: false)
				
				var musicTrack: MusicTrack = nil
				MusicSequenceGetIndTrack(sequence, 0, &musicTrack)
				
				self.enumerateMidiEventsInTrack(musicTrack, withClosure: { (eventIndex, eventType, eventData) in
					if eventType == kMusicEventType_MIDINoteMessage {
						let data = UnsafePointer<MIDINoteMessage>(eventData)
						let midiMessage = data.memory
						
						expect(midiMessage.note).to(equal(normalMidiNote))
					}
				})
			}
		}
	}
}

extension SequenceComposerSpecs {
	func enumerateTracksInSequence(_ sequence: MusicSequence, withClosure closure: (_ index: Int, _ track: MusicTrack) -> Void) {
		var numberOfTracks: UInt32 = 0
		MusicSequenceGetTrackCount(sequence, &numberOfTracks)
		
		for trackIndex in 0 ..< numberOfTracks {
			var musicTrack: MusicTrack? = nil
			MusicSequenceGetIndTrack(sequence, trackIndex, &musicTrack)
			
			closure(Int(trackIndex), musicTrack!)
		}
	}
	
	func enumerateMidiEventsInTrack(_ track: MusicTrack, withClosure closure: (_ eventIndex: Int, _ eventType: MusicEventType, _ eventData: UnsafeRawPointer) -> Void) {
		var musicEventIterator: MusicEventIterator? = nil
		NewMusicEventIterator(track, &musicEventIterator)
		
		var eventIndex = 0
		
		var hasCurrentEvent: DarwinBoolean = false
		MusicEventIteratorHasCurrentEvent(musicEventIterator!, &hasCurrentEvent)
		
		while (hasCurrentEvent).boolValue {
			var eventData: UnsafeRawPointer? = nil
			var eventType: MusicEventType = 0
			
			MusicEventIteratorGetEventInfo(musicEventIterator!, nil, &eventType, &eventData, nil)
			closure(eventIndex, eventType, eventData!)
			eventIndex += 1
			
			MusicEventIteratorNextEvent(musicEventIterator!)
			MusicEventIteratorHasCurrentEvent(musicEventIterator!, &hasCurrentEvent)
		}
	}
}
