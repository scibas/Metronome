import AVFoundation
import CocoaLumberjack

class AudioSessionConfigurator {
	static func configureAudioSession(_ audioSession: AVAudioSession) {
		
		do {
			try audioSession.setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.mixWithOthers)
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
