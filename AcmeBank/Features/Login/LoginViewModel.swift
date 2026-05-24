import Foundation

/// ViewModel for the login screen.
///
/// Owns the form state (`email`, `password`, `isLoading`, `isPasswordVisible`,
/// `keepMeSignedIn`) and exposes actions that validate inputs and invoke
/// injectable closures. The real async auth flow is wired in the auth story;
/// this PR establishes the UI contract and state machine.
final class LoginViewModel: ObservableObject {

    // MARK: - Published State

    /// Email address entered by the user.
    @Published var email: String = ""

    /// Password entered by the user (masked in the UI via `SecureField` unless
    /// `isPasswordVisible` is `true`).
    @Published var password: String = ""

    /// `true` while a sign-in attempt is in progress; disables the button.
    @Published var isLoading: Bool = false

    /// Toggles between masked (`SecureField`) and plain-text (`TextField`)
    /// password display when the eye-icon button is tapped.
    @Published var isPasswordVisible: Bool = false

    /// Whether the user has opted into persistent sign-in (unchecked by default).
    @Published var keepMeSignedIn: Bool = false

    // MARK: - Derived State

    /// `true` when both email and password fields contain non-empty text.
    var canSignIn: Bool {
        !email.trimmingCharacters(in: .whitespaces).isEmpty && !password.isEmpty
    }

    // MARK: - Injectable Callbacks

    /// Called when the user taps "Sign in" and inputs are valid.
    /// Defaults to a no-op; replaced by the coordinator / auth layer.
    var onSignIn: () -> Void = {}

    /// Called when the user taps "Forgot password?".
    /// Defaults to a no-op; replaced by the coordinator.
    var onForgotPassword: () -> Void = {}

    /// Called when the user taps "Need help?".
    /// Defaults to a no-op; replaced by the coordinator.
    var onNeedHelp: () -> Void = {}

    // MARK: - Actions

    /// Validates the form, sets `isLoading`, and invokes `onSignIn`.
    ///
    /// Guards against empty email or password — does nothing when either
    /// field is blank so the user must correct the form before proceeding.
    func signIn() {
        guard canSignIn else { return }

        isLoading = true
        onSignIn()
    }

    /// Resets `isLoading` to `false`.
    ///
    /// Called by the coordinator / auth layer on both success and failure so
    /// the sign-in button and form are re-enabled after every attempt.
    func resetLoading() {
        isLoading = false
    }

    /// Invokes the forgot-password callback.
    func forgotPassword() {
        onForgotPassword()
    }

    /// Invokes the need-help callback.
    func needHelp() {
        onNeedHelp()
    }
}
