import Foundation

typealias BPM = Double

protocol MetronomeEngineProtocol {
	func start() throws
	func stop()
	
	var metre: Metre? { set get }
	var emphasisEnabled: Bool? { set get }
	var soundSample: SoundSample? { set get }
    var tempo: BPM? { set get }
    
    var isPlaying: Bool { get }
}
