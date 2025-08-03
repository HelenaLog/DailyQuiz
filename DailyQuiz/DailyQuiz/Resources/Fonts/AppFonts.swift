import SwiftUI

enum AppFont: String {
    case interRegular = "Inter-Regular"
    case interRegularBold = "Inter-Regular_Bold"
    case interRegularSemibold = "Inter-Regular_SemiBold"
    case interRegularMedium = "Inter-Regular_Medium"
    case interRegularBlack = "Inter-Regular_Black"
}

extension Font {
    static func custom(_ font: AppFont, size: CGFloat) -> Font {
        Font.custom(font.rawValue, size: size)
    }
}
