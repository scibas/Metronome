// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  typealias Image = UIImage
#elseif os(OSX)
  import AppKit.NSImage
  typealias Image = NSImage
#endif

enum Asset: String {
  case Autobpm_btn_off = "autobpm_btn_off"
  case Autobpm_btn_on = "autobpm_btn_on"
  case Display_bkg = "display_bkg"
  case Jog = "jog"
  case Jog_bkg = "jog_bkg"
  case Metre_btn = "metre_btn"
  case Settings_btn = "settings_btn"
  case Tempo_minus_btn = "tempo_minus_btn"
  case Tempo_plus_btn = "tempo_plus_btn"

  var image: Image {
    return Image(asset: self)
  }
}

extension Image {
  convenience init!(asset: Asset) {
    self.init(named: asset.rawValue)
  }
}
