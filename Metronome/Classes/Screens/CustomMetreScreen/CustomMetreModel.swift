class CustomMetreModel {
    var metronomeEngine: MetronomeEngineProtocol
    
    init(withMetronomeEngine metronomeEngine: MetronomeEngineProtocol) {
        self.metronomeEngine = metronomeEngine
    }
    
    func applyMetreToMetronomeEngine(metre: Metre) {
        metronomeEngine.metre = metre
    }

}
