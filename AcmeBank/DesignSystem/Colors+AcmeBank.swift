import SwiftUI

extension Color {
    // MARK: - Brand Colours

    /// Deep navy used for primary UI elements, navigation bar, and headers.
    /// Replace with `Color("AcmeNavy")` once the asset catalogue entry is added.
    static let acmeNavy = Color(red: 0.07, green: 0.13, blue: 0.30)

    /// Bright teal used for primary action buttons and interactive highlights.
    /// Replace with `Color("AcmeTeal")` once the asset catalogue entry is added.
    static let acmeTeal = Color(red: 0.00, green: 0.60, blue: 0.70)

    // MARK: - Semantic Colours

    /// App-wide background — adapts to light / dark mode.
    static let acmeBackground = Color(.systemBackground)

    /// Primary label colour — adapts to light / dark mode.
    static let acmeLabel = Color(.label)

    /// Secondary label colour (placeholder text, captions).
    static let acmeSecondaryLabel = Color(.secondaryLabel)

    /// Border / separator colour used on text fields.
    static let acmeSeparator = Color(.separator)

    // MARK: - Login Screen Specific

    /// Background gradient top colour for the login screen header.
    static let acmeLoginHeaderTop = Color.acmeNavy

    /// Primary button fill — uses teal brand token.
    static let acmePrimaryButtonFill = Color.acmeTeal

    /// Primary button label colour (always white for contrast).
    static let acmePrimaryButtonLabel = Color.white
}
