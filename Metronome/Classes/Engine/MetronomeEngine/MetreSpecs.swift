import Nimble
import Quick
import AudioToolbox

@testable import Metronome

class MetreSpecs: QuickSpec {
	override func spec() {
		
		it("Should have valid conviniet initializer for 2/4 metrum") {
            let sut = Metre.twoByFour()
            expect(sut.beat).to(equal(2))
            expect(sut.noteKind.rawValue).to(equal(4))
		}
        
        it("Should have valid conviniet initializer for 3/4 metrum") {
            let sut = Metre.threeByFour()
            expect(sut.beat).to(equal(3))
            expect(sut.noteKind.rawValue).to(equal(4))
        }
        
        it("Should have valid conviniet initializer for 4/4 metrum") {
            let sut = Metre.fourByFour()
            expect(sut.beat).to(equal(4))
            expect(sut.noteKind.rawValue).to(equal(4))
        }
        
        it("Should have valid conviniet initializer for 6/8 metrum") {
            let sut = Metre.sixByEight()
            expect(sut.beat).to(equal(6))
            expect(sut.noteKind.rawValue).to(equal(8))
        }
	}
}