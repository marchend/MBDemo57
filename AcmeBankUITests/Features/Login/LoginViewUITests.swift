import XCTest

final class LoginViewUITests: XCTestCase {

    private var app: XCUIApplication!

    // MARK: - Setup / Teardown

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        // Signal to the app that it is running under UI-test mode so it can
        // substitute mock dependencies (hook point for future auth stubbing).
        app.launchArguments = ["-UITestMode", "YES"]
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    // MARK: - Element Presence

    func test_loginScreen_emailField_exists() {
        let emailField = app.textFields["login_email_field"]
        XCTAssertTrue(emailField.waitForExistence(timeout: 5), "Email text field must be present on launch")
    }

    func test_loginScreen_passwordField_exists() {
        let passwordField = app.secureTextFields["login_password_field"]
        XCTAssertTrue(passwordField.waitForExistence(timeout: 5), "Password secure field must be present on launch")
    }

    func test_loginScreen_signInButton_exists() {
        let signInButton = app.buttons["login_sign_in_button"]
        XCTAssertTrue(signInButton.waitForExistence(timeout: 5), "Sign-in button must be present on launch")
    }

    func test_loginScreen_forgotPasswordButton_exists() {
        let forgotButton = app.buttons["login_forgot_password_button"]
        XCTAssertTrue(forgotButton.waitForExistence(timeout: 5), "Forgot-password button must be present on launch")
    }

    // MARK: - Hittability

    func test_loginScreen_emailField_isHittable() {
        let emailField = app.textFields["login_email_field"]
        XCTAssertTrue(emailField.waitForExistence(timeout: 5))
        XCTAssertTrue(emailField.isHittable, "Email field should be hittable (not obscured or off-screen)")
    }

    func test_loginScreen_passwordField_isHittable() {
        let passwordField = app.secureTextFields["login_password_field"]
        XCTAssertTrue(passwordField.waitForExistence(timeout: 5))
        XCTAssertTrue(passwordField.isHittable, "Password field should be hittable")
    }

    func test_loginScreen_signInButton_isHittable() {
        let signInButton = app.buttons["login_sign_in_button"]
        XCTAssertTrue(signInButton.waitForExistence(timeout: 5))
        XCTAssertTrue(signInButton.isHittable, "Sign-in button should be hittable")
    }

    // MARK: - Interaction

    func test_loginScreen_typeInEmailField_doesNotCrash() {
        let emailField = app.textFields["login_email_field"]
        XCTAssertTrue(emailField.waitForExistence(timeout: 5))
        emailField.tap()
        emailField.typeText("testuser@acmebank.com")
        // Assert the field reflects typed text
        XCTAssertEqual(emailField.value as? String, "testuser@acmebank.com")
    }

    func test_loginScreen_typeInPasswordField_doesNotCrash() {
        let passwordField = app.secureTextFields["login_password_field"]
        XCTAssertTrue(passwordField.waitForExistence(timeout: 5))
        passwordField.tap()
        passwordField.typeText("Secret1234!")
        // SecureField value is masked — just assert the field is still present
        XCTAssertTrue(passwordField.exists)
    }

    func test_loginScreen_tapSignIn_withCredentials_doesNotCrash() {
        // Fill in both fields
        let emailField = app.textFields["login_email_field"]
        XCTAssertTrue(emailField.waitForExistence(timeout: 5))
        emailField.tap()
        emailField.typeText("testuser@acmebank.com")

        let passwordField = app.secureTextFields["login_password_field"]
        passwordField.tap()
        passwordField.typeText("Secret1234!")

        // Dismiss keyboard so the button is hittable
        app.keyboards.buttons["Return"].tapIfExists()

        let signInButton = app.buttons["login_sign_in_button"]
        XCTAssertTrue(signInButton.waitForExistence(timeout: 5))
        signInButton.tap()

        // Stub path: onSignIn is a no-op; app should remain stable (no crash)
        XCTAssertTrue(app.exists, "App should remain running after tapping Sign in (stub path)")
    }
}

// MARK: - Convenience extension

private extension XCUIElement {
    /// Taps the element only if it exists, to handle optional UI elements gracefully.
    func tapIfExists() {
        if exists { tap() }
    }
}
