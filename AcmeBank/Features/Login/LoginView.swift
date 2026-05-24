import SwiftUI

/// The login screen.
///
/// Presents the AcmeBank brand header, an email text field, a password field
/// with a reveal toggle, a "Keep me signed in" toggle, a primary "Sign in"
/// button (disabled until both fields are non-empty), a "Forgot password?"
/// link, and a "Need help?" link. All interactive elements carry accessibility
/// identifiers so `XCUITest` can locate them reliably without coupling to
/// display copy.
struct LoginView: View {

    // MARK: - Dependencies

    @ObservedObject var viewModel: LoginViewModel

    // MARK: - Body

    var body: some View {
        ZStack {
            // Page background
            Color.acmeBackground
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    headerSection
                    formSection
                }
            }

            // Loading overlay — blocks interaction while sign-in is in-flight
            if viewModel.isLoading {
                loadingOverlay
            }
        }
    }

    // MARK: - Sub-views

    private var headerSection: some View {
        VStack(spacing: 12) {
            // Brand monogram — swapped for a real asset in the design-handoff story
            Text("A")
                .font(.acmeDisplayTitle)
                .foregroundColor(.acmePrimaryButtonLabel)
                .frame(width: 80, height: 80)
                .background(Color.acmePrimaryButtonFill)
                .clipShape(Circle())
                .accessibilityLabel("AcmeBank logo")

            Text("AcmeBank")
                .font(.acmeDisplayTitle)
                .foregroundColor(.acmePrimaryButtonLabel)

            Text("Secure banking at your fingertips")
                .font(.acmeBody)
                .foregroundColor(.acmePrimaryButtonLabel.opacity(0.85))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 48)
        .background(
            LinearGradient(
                colors: [.acmeLoginHeaderTop, .acmeLoginHeaderTop.opacity(0.8)],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }

    private var formSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Email field
            VStack(alignment: .leading, spacing: 6) {
                Text("Email")
                    .font(.acmeCaption)
                    .foregroundColor(.acmeSecondaryLabel)

                TextField("name@acmebank.com", text: $viewModel.email)
                    .font(.acmeField)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(12)
                    .background(Color.acmeBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.acmeSeparator, lineWidth: 1)
                    )
                    .accessibilityIdentifier("login_email_field")
            }

            // Password field with reveal toggle
            VStack(alignment: .leading, spacing: 6) {
                Text("Password")
                    .font(.acmeCaption)
                    .foregroundColor(.acmeSecondaryLabel)

                HStack {
                    Group {
                        if viewModel.isPasswordVisible {
                            TextField("Enter your password", text: $viewModel.password)
                                .textContentType(.password)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        } else {
                            SecureField("Enter your password", text: $viewModel.password)
                                .textContentType(.password)
                        }
                    }
                    .font(.acmeField)

                    Button {
                        viewModel.isPasswordVisible.toggle()
                    } label: {
                        Image(systemName: viewModel.isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.acmeSecondaryLabel)
                    }
                    .accessibilityLabel(viewModel.isPasswordVisible ? "Hide password" : "Show password")
                    .accessibilityIdentifier("login_password_reveal_button")
                }
                .padding(12)
                .background(Color.acmeBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.acmeSeparator, lineWidth: 1)
                )
                .accessibilityIdentifier("login_password_field")
            }

            // Keep me signed in toggle
            Toggle(isOn: $viewModel.keepMeSignedIn) {
                Text("Keep me signed in")
                    .font(.acmeBody)
                    .foregroundColor(.acmeSecondaryLabel)
            }
            .tint(.acmePrimaryButtonFill)
            .accessibilityIdentifier("login_keep_signed_in_toggle")

            // Forgot password link
            HStack {
                Spacer()
                Button("Forgot password?") {
                    viewModel.forgotPassword()
                }
                .font(.acmeLink)
                .foregroundColor(.acmePrimaryButtonFill)
                .accessibilityIdentifier("login_forgot_password_button")
            }

            // Sign in button — disabled until both fields are non-empty or loading
            let isDisabled = !viewModel.canSignIn || viewModel.isLoading
            Button {
                viewModel.signIn()
            } label: {
                HStack(spacing: 8) {
                    Text("Sign in")
                        .font(.acmePrimaryButton)
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(.acmePrimaryButtonLabel)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    isDisabled
                        ? Color.acmePrimaryButtonFill.opacity(0.4)
                        : Color.acmePrimaryButtonFill
                )
                .foregroundColor(.acmePrimaryButtonLabel)
                .cornerRadius(10)
            }
            .disabled(isDisabled)
            .accessibilityIdentifier("login_sign_in_button")

            // Need help? link
            HStack {
                Spacer()
                Button("Need help?") {
                    viewModel.needHelp()
                }
                .font(.acmeLink)
                .foregroundColor(.acmePrimaryButtonFill)
                .accessibilityIdentifier("login_need_help_button")
                Spacer()
            }
        }
        .padding(24)
    }

    private var loadingOverlay: some View {
        Color.black.opacity(0.15)
            .ignoresSafeArea()
            .allowsHitTesting(true)
    }
}
