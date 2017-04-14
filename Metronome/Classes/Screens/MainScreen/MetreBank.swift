class MetreBank {
    fileprivate var bank = [Int: Metre]()
    
    func metre(for bankIndex: Int) -> Metre? {
        return bank[bankIndex]
    }
    
    func set(_ metre: Metre, at index: Int) {
        bank[index] = metre
    }
    
    func clearMetre(at index: Int) {
        bank.removeValue(forKey: index)
    }
    
    func isEmpty(at index: Int) -> Bool {
        return bank[index] == nil
    }
}
