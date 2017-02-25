import Foundation
import CoreText
import UIKit

final class MetreAttributedTextFormater {
    class func attributedText(for metre: Metre, with font: UIFont? = nil, and color: UIColor? = nil) -> NSAttributedString {
        let beat = "\(metre.beat)"
        let noteKind = "\(metre.noteKind.rawValue)"
        
        let metreAttributedString = NSMutableAttributedString(string: "\(beat)/\(noteKind)")
        
        let beatCharactersRange = NSRange(location: 0, length: beat.characters.count)
        let byCharacterRange = NSRange(location: beatCharactersRange.location + beatCharactersRange.length, length: 1)
        let noteKindCharactersRange = NSRange(location: byCharacterRange.location + byCharacterRange.length, length: noteKind.characters.count)
        
        metreAttributedString.setAttributes(attributes(forSuperscript: 1, font: font, color: color), range: beatCharactersRange)
        metreAttributedString.setAttributes(attributes(forSuperscript: 0, font: font, color: color), range: byCharacterRange)
        metreAttributedString.setAttributes(attributes(forSuperscript:-1, font: font, color: color), range: noteKindCharactersRange)
        
        return metreAttributedString
    }
    
    private class func attributes(forSuperscript superscript: Int, font: UIFont? = nil, color: UIColor? = nil) -> [String: Any] {
        var attributes = [String : Any]()
            
        attributes[kCTSuperscriptAttributeName as String] = superscript
        
        if let font = font {
            attributes[NSFontAttributeName] = font
        }
        
        if let color = color {
            attributes[NSForegroundColorAttributeName] = color
        }
        
        return attributes
    }
}
