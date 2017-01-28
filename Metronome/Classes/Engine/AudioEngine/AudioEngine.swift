import AudioToolbox
import AVFoundation
import CocoaLumberjack

class AudioEngine: AudioEngineProtocol {
	fileprivate let audioEngine: AVAudioEngine
	fileprivate var sampler: AVAudioUnitSampler!
	fileprivate var sequencer: AVAudioSequencer!
	
	init() { //FixMe: inject audion session
		audioEngine = AVAudioEngine()
		setupCoreAudioEngine(audioEngine)
		
		let url = Bundle.main.url(forResource: "metronome", withExtension: "aupreset")!
		try! sampler.loadInstrument(at: url)
		
		let audioSession = AVAudioSession.sharedInstance()
		AudioSessionConfigurator.configureAudioSession(audioSession)
        
        try! audioEngine.start()  //FixMe: extract to separate method that can trows, same with `try!` above
	}
	
	func playMusicSequence(_ musicSequence: MusicSequence) throws {
        sequencer.currentPositionInBeats = 0
        
		var data: Unmanaged<CFData>?
		MusicSequenceFileCreateData(musicSequence, .midiType, .eraseFile, 480, &data)
		
        if let midiData = data?.takeRetainedValue() as Data? {
			try sequencer.load(from: midiData, options: AVMusicSequenceLoadOptions())
		}
		
		for track in sequencer.tracks {
			track.isLoopingEnabled = true
			track.numberOfLoops = AVMusicTrackLoopCount.forever.rawValue
		}
		
		try sequencer.start()
	}
	
	func stopMusicSequence() {
		sequencer.stop()
	}
	
	var isPlaying: Bool { return sequencer!.isPlaying }
	
	var playbackRate: Double {
		set {
			sequencer.rate = Float(newValue)
		}
		
		get {
			return Double(sequencer.rate)
		}
	}
	
	fileprivate func setupCoreAudioEngine(_ engine: AVAudioEngine) {
		let mixer = engine.mainMixerNode
		
		sampler = AVAudioUnitSampler()
		engine.attach(sampler)
		engine.connect(sampler, to: mixer, format: mixer.outputFormat(forBus: 0))
		
		sequencer = AVAudioSequencer(audioEngine: engine)
	}
}
