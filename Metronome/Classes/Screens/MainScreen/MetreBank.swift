class MetreBank {
    fileprivate var bank = [Int: Metre]()
    
    func metreForIndex(_ index: Int) -> Metre? {
        return bank[index]
    }
    
    func setMetre(_ metre: Metre, forIndex index: Int) {
        bank[index] = metre
    }
    
    func clearMetreAtIndex(_ index: Int) {
        bank.removeValue(forKey: index)
    }
}
