class MetreBank {
    private var bank = [Int: Metre]()
    
    func metreForIndex(index: Int) -> Metre? {
        return bank[index]
    }
    
    func setMetre(metre: Metre, forIndex index: Int) {
        bank[index] = metre
    }
    
    func clearMetreAtIndex(index: Int) {
        bank.removeValueForKey(index)
    }
}
