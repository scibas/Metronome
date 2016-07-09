import Foundation
import AVFoundation
import CocoaLumberjack

class MetronomeEngine: MetronomeEngineProtocol {
	var currentMusicSequence: MusicSequence?
	
	var audioEngine: AudioEngineProtocol
	let soundBank: SoundsBank
	
	init(withAudioEngine audioEngine: AudioEngineProtocol, andSoundBank soundBank: SoundsBank) {
		self.audioEngine = audioEngine
		self.soundBank = soundBank
	}
	
	func start() throws {
		let musicSequence = musicSequenceForMetre(metre, soundSample: soundSample, emphasisEnabled: emphasisEnabled)
		try start(withSequence: musicSequence)
	}
	
	func start(withSequence musicSequence: MusicSequence) throws {
		self.currentMusicSequence = musicSequence
		try audioEngine.playMusicSequence(musicSequence)
	}
	
	func stop() {
		audioEngine.stopMusicSequence()
	}
	
	var isPlaying: Bool {
		return audioEngine.isPlaying
	}
	
	var metre: Metre? {
		didSet {
			let newMusicSequence = musicSequenceForMetre(metre, soundSample: soundSample, emphasisEnabled: emphasisEnabled)
			try! reloadSequenceAndPlayIfWasPlayingBefore(newMusicSequence)
		}
	}
	
	var emphasisEnabled: Bool? {
		didSet {
			let newMusicSequence = musicSequenceForMetre(metre, soundSample: soundSample, emphasisEnabled: emphasisEnabled)
			try! reloadSequenceAndPlayIfWasPlayingBefore(newMusicSequence)
		}
	}
	
	var soundSample: SoundSample? {
		didSet {
			let newMusicSequence = musicSequenceForMetre(metre, soundSample: soundSample, emphasisEnabled: emphasisEnabled)
			try! reloadSequenceAndPlayIfWasPlayingBefore(newMusicSequence)
		}
	}
	
	var tempo: BPM? {
		didSet {
			if let tempo = tempo {
				let playbackRate = tempo / SequenceComposer.defaultTempoForQuaterNote
				self.audioEngine.playbackRate = playbackRate
			}
		}
	}
	
	func reloadSequenceAndPlayIfWasPlayingBefore(musicSequence: MusicSequence) throws {
		let wasPlaying = self.isPlaying
		
		if wasPlaying {
			stop()
			try start(withSequence: musicSequence)
		}
	}
	
	func musicSequenceForMetre(metre: Metre?, soundSample: SoundSample?, emphasisEnabled: Bool?) -> MusicSequence {
		let metre = metre ?? Metre.fourByFour()
		let soundSample = soundSample ?? soundBank.bank[0]
		let emphasisEnabled = emphasisEnabled ?? true
		
		return SequenceComposer.prepareSequenceForMetre(metre, soundSample: soundSample, emphasisEnabled: emphasisEnabled)
	}
}
