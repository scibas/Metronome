import Nimble
import Quick
import AudioToolbox

@testable import Metronome

class MetreBankSpecs: QuickSpec {
    override func spec() {
        
        it("Should store metre") {
            let metreToStore = Metre.fourByFour()
            
            let sut = MetreBank()
            sut.setMetre(metreToStore, forIndex: 0)
            
            expect(sut.metreForIndex(0)?.beat).to(equal(metreToStore.beat))
            expect(sut.metreForIndex(0)?.noteKindOf).to(equal(metreToStore.noteKindOf))
        }
        
        it("Should overwrite metre") {
            let metreToStore = Metre.fourByFour()
            
            let sut = MetreBank()
            sut.setMetre(Metre.sixByEight(), forIndex: 0)
            sut.setMetre(Metre.twoByFour(), forIndex: 1)
            sut.setMetre(metreToStore, forIndex: 0)
            
            expect(sut.metreForIndex(0)?.beat).to(equal(metreToStore.beat))
            expect(sut.metreForIndex(0)?.noteKindOf).to(equal(metreToStore.noteKindOf))
        }
        
        it("Should clear metre") {
            let sut = MetreBank()
            sut.setMetre(Metre.sixByEight(), forIndex: 0)
            sut.setMetre(Metre.twoByFour(), forIndex: 1)
            sut.clearMetreAtIndex(0)
            
            expect(sut.metreForIndex(0)).to(beNil())
            expect(sut.metreForIndex(1)).toNot(beNil())
        }
    }
}