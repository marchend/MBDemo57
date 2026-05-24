import Foundation
import Combine

/// ViewModel for the login screen.
///
/// Owns the form state (`email`, `password`, `isLoading`) and exposes a
/// `signIn()` action that validates the inputs and invokes the injectable
/// `onSignIn` closure. The real async auth flow is wired in the auth story;
/// this PR establishes the UI contract and state machine.
final class LoginViewModel: ObservableObject {

    // MARK: - Published State

    /// Email address entered by the user.
    @Published var email: String = ""

    /// Password entered by the user (masked in the UI via `SecureField`).
    @Published var password: String = ""

    /// `true` while a sign-in attempt is in progress; disables the button.
    @Published var isLoading: Bool = false

    // MARK: - Injectable Callbacks

    /// Called when the user taps "Sign in" and inputs are valid.
    /// Defaults to a no-op; replaced by the coordinator / auth layer.
    var onSignIn: () -> Void = {}

    /// Called when the user taps "Forgot password?".
    /// Defaults to a no-op; replaced by the coordinator.
    var onForgotPassword: () -> Void = {}

    // MARK: - Actions

    /// Validates the form, sets `isLoading`, and invokes `onSignIn`.
    ///
    /// Guards against empty email or password — does nothing when either
    /// field is blank so the user must correct the form before proceeding.
    func signIn() {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.isEmpty else { return }

        isLoading = true
        onSignIn()
    }

    /// Invokes the forgot-password callback.
    func forgotPassword() {
        onForgotPassword()
    }
}
