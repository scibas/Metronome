import Foundation

class CustomMetreModel {
    private let metreBank: MetreBank
    
    init(with metreBank: MetreBank) {
        self.metreBank = metreBank
    }
    
    func set(metre: Metre, for bankIndex: Int) {
        metreBank.set(metre, at: bankIndex)
    }
    
    func metre(for bankIndex: Int) -> Metre? {
        return metreBank.metre(for: bankIndex)
    }
}
