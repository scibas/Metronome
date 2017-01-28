class CustomMetreModel {
    var metronomeEngine: MetronomeEngineProtocol
    
    init(withMetronomeEngine metronomeEngine: MetronomeEngineProtocol) {
        self.metronomeEngine = metronomeEngine
    }
    
    func applyMetreToMetronomeEngine(_ metre: Metre) {
        metronomeEngine.metre = metre
    }

}
