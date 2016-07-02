// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  typealias Image = UIImage
#elseif os(OSX)
  import AppKit.NSImage
  typealias Image = NSImage
#endif

enum Asset: String {
  case Display_bkg = "display_bkg"
  case Jog = "jog"
  case Jog_bkg = "jog_bkg"
  case Metre_btn = "metre_btn"

  var image: Image {
    return Image(asset: self)
  }
}

extension Image {
  convenience init!(asset: Asset) {
    self.init(named: asset.rawValue)
  }
}
