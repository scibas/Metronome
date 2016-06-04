import AVFoundation
import CocoaLumberjack

class AudioSessionConfigurator {
	static func configureAudioSession(audioSession: AVAudioSession) {
		
		do {
			try audioSession.setCategory(AVAudioSessionCategoryPlayback, withOptions: AVAudioSessionCategoryOptions.MixWithOthers)
		} catch {
			DDLogError("Could not set audio session category: \(error)")
			return
		}
		
		do {
			try audioSession.setActive(true)
		} catch {
			DDLogError("Could not set audio session active: \(error)")
			return
		}
	}
}