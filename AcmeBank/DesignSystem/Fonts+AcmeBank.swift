import SwiftUI

extension Font {
    // MARK: - Heading Styles

    /// Large display title — used for app name / hero text on login screen.
    static let acmeDisplayTitle: Font = .system(size: 34, weight: .bold, design: .rounded)

    /// Section heading — used for screen titles.
    static let acmeHeading: Font = .system(size: 24, weight: .semibold, design: .rounded)

    /// Sub-heading — used for card titles and section labels.
    static let acmeSubheading: Font = .system(size: 17, weight: .semibold, design: .default)

    // MARK: - Body Styles

    /// Standard body text.
    static let acmeBody: Font = .system(size: 16, weight: .regular, design: .default)

    /// Caption / footnote text.
    static let acmeCaption: Font = .system(size: 13, weight: .regular, design: .default)

    // MARK: - Interactive Styles

    /// Primary button label font.
    static let acmePrimaryButton: Font = .system(size: 17, weight: .semibold, design: .default)

    /// Secondary / link text.
    static let acmeLink: Font = .system(size: 15, weight: .medium, design: .default)

    // MARK: - Field Styles

    /// Text field input font.
    static let acmeField: Font = .system(size: 16, weight: .regular, design: .default)
}
