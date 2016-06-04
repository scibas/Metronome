import AudioToolbox
import AVFoundation
import CocoaLumberjack

class AudioEngine: AudioEngineProtocol {
	private let audioEngine: AVAudioEngine
	private var sampler: AVAudioUnitSampler!
	private var sequencer: AVAudioSequencer!
	
	init() {
		audioEngine = AVAudioEngine()
		setupCoreAudioEngine(audioEngine)
		
		let url = NSBundle.mainBundle().URLForResource("metronome", withExtension: "aupreset")!
		try! sampler.loadInstrumentAtURL(url)
		
		let audioSession = AVAudioSession.sharedInstance()
		AudioSessionConfigurator.configureAudioSession(audioSession)
	}
	
	func playMusicSequence(musicSequence: MusicSequence) throws {
		
		var data: Unmanaged<CFData>?
		MusicSequenceFileCreateData(musicSequence, .MIDIType, .EraseFile, 480, &data)
		
		if let midiData = data?.takeRetainedValue() {
			try sequencer.loadFromData(midiData, options: .SMF_PreserveTracks)
		}
		
		for track in sequencer.tracks {
			track.loopingEnabled = true
			track.numberOfLoops = AVMusicTrackLoopCount.Forever.rawValue
		}
		
		try audioEngine.start()
		try sequencer.start()
	}
	
	func stopMusicSequence() {
		sequencer.stop()
		audioEngine.stop()
	}
	
	var isPlaying: Bool { return sequencer!.playing }
	
	var playbackRate: Double {
		set {
			sequencer.rate = Float(newValue)
		}
		
		get {
			return Double(sequencer.rate)
		}
	}
	
	private func setupCoreAudioEngine(engine: AVAudioEngine) {
		let mixer = engine.mainMixerNode
		
		sampler = AVAudioUnitSampler()
		engine.attachNode(sampler)
		engine.connect(sampler, to: mixer, format: mixer.outputFormatForBus(0))
		
		sequencer = AVAudioSequencer(audioEngine: engine)
	}
}
