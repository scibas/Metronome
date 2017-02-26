// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  typealias Image = UIImage
#elseif os(OSX)
  import AppKit.NSImage
  typealias Image = NSImage
#endif

// swiftlint:disable file_length
// swiftlint:disable line_length

// swiftlint:disable type_body_length
enum Asset: String {
  case autobpmBtnOff = "autobpm_btn_off"
  case autobpmBtnOn = "autobpm_btn_on"
  case displayBkg = "display_bkg"
  case eightNote = "eight_note"
  case halfNote = "half_note"
  case jogBkg = "jog_bkg"
  case jog = "jog"
  case metreBtn = "metre_btn"
  case quaterNote = "quater_note"
  case settingsBtn = "settings_btn"
  case sixteenthNote = "sixteenth_note"
  case tempoMinusBtn = "tempo_minus_btn"
  case tempoPlusBtn = "tempo_plus_btn"

  var image: Image {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS) || os(watchOS)
    let image = Image(named: rawValue, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: rawValue)
    #endif
    guard let result = image else { fatalError("Unable to load image \(rawValue).") }
    return result
  }
}
// swiftlint:enable type_body_length

extension Image {
  convenience init!(asset: Asset) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.rawValue, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: asset.rawValue)
    #endif
  }
}

private final class BundleToken {}
