import XCTest
@testable import AcmeBank

final class LoginViewModelTests: XCTestCase {

    // MARK: - Initial State

    func test_initialState_emailIsEmpty() {
        let sut = LoginViewModel()
        XCTAssertEqual(sut.email, "", "email should be empty on init")
    }

    func test_initialState_passwordIsEmpty() {
        let sut = LoginViewModel()
        XCTAssertEqual(sut.password, "", "password should be empty on init")
    }

    func test_initialState_isLoadingIsFalse() {
        let sut = LoginViewModel()
        XCTAssertFalse(sut.isLoading, "isLoading should be false on init")
    }

    func test_initialState_isPasswordVisibleIsFalse() {
        let sut = LoginViewModel()
        XCTAssertFalse(sut.isPasswordVisible, "isPasswordVisible should be false on init")
    }

    func test_initialState_keepMeSignedInIsFalse() {
        let sut = LoginViewModel()
        XCTAssertFalse(sut.keepMeSignedIn, "keepMeSignedIn should be false on init")
    }

    // MARK: - canSignIn (derived state)

    func test_canSignIn_isFalse_whenBothFieldsEmpty() {
        let sut = LoginViewModel()
        XCTAssertFalse(sut.canSignIn)
    }

    func test_canSignIn_isFalse_whenEmailEmpty() {
        let sut = LoginViewModel()
        sut.password = "secret123"
        XCTAssertFalse(sut.canSignIn)
    }

    func test_canSignIn_isFalse_whenPasswordEmpty() {
        let sut = LoginViewModel()
        sut.email = "user@acmebank.com"
        XCTAssertFalse(sut.canSignIn)
    }

    func test_canSignIn_isFalse_whenEmailIsWhitespaceOnly() {
        let sut = LoginViewModel()
        sut.email = "   "
        sut.password = "secret123"
        XCTAssertFalse(sut.canSignIn)
    }

    func test_canSignIn_isTrue_whenBothFieldsNonEmpty() {
        let sut = LoginViewModel()
        sut.email = "user@acmebank.com"
        sut.password = "secret123"
        XCTAssertTrue(sut.canSignIn)
    }

    // MARK: - signIn() — closure invocation

    func test_signIn_withValidCredentials_callsOnSignInClosure() {
        let sut = LoginViewModel()
        sut.email = "user@acmebank.com"
        sut.password = "secret123"

        var closureCalled = false
        sut.onSignIn = { closureCalled = true }

        sut.signIn()

        XCTAssertTrue(closureCalled, "onSignIn closure should be called when credentials are valid")
    }

    func test_signIn_withEmptyEmail_doesNotCallOnSignIn() {
        let sut = LoginViewModel()
        sut.email = ""
        sut.password = "secret123"

        var closureCalled = false
        sut.onSignIn = { closureCalled = true }

        sut.signIn()

        XCTAssertFalse(closureCalled, "onSignIn must not be called when email is empty")
    }

    func test_signIn_withEmptyPassword_doesNotCallOnSignIn() {
        let sut = LoginViewModel()
        sut.email = "user@acmebank.com"
        sut.password = ""

        var closureCalled = false
        sut.onSignIn = { closureCalled = true }

        sut.signIn()

        XCTAssertFalse(closureCalled, "onSignIn must not be called when password is empty")
    }

    func test_signIn_withWhitespaceOnlyEmail_doesNotCallOnSignIn() {
        let sut = LoginViewModel()
        sut.email = "   "
        sut.password = "secret123"

        var closureCalled = false
        sut.onSignIn = { closureCalled = true }

        sut.signIn()

        XCTAssertFalse(closureCalled, "onSignIn must not be called when email is only whitespace")
    }

    // MARK: - signIn() — isLoading toggling

    func test_signIn_withValidCredentials_setsIsLoadingTrue() {
        let sut = LoginViewModel()
        sut.email = "user@acmebank.com"
        sut.password = "secret123"
        sut.onSignIn = {} // no-op stub

        sut.signIn()

        XCTAssertTrue(sut.isLoading, "isLoading should be true after signIn() is called with valid inputs")
    }

    func test_signIn_withInvalidCredentials_doesNotSetIsLoading() {
        let sut = LoginViewModel()
        sut.email = ""
        sut.password = ""

        sut.signIn()

        XCTAssertFalse(sut.isLoading, "isLoading should remain false when guard fails")
    }

    // MARK: - resetLoading()

    func test_resetLoading_setsIsLoadingToFalse() {
        let sut = LoginViewModel()
        sut.email = "user@acmebank.com"
        sut.password = "secret123"
        sut.signIn() // sets isLoading = true

        sut.resetLoading()

        XCTAssertFalse(sut.isLoading, "resetLoading() should set isLoading back to false")
    }

    func test_resetLoading_isIdempotent_whenAlreadyFalse() {
        let sut = LoginViewModel()
        sut.resetLoading()
        XCTAssertFalse(sut.isLoading, "resetLoading() should be safe to call when isLoading is already false")
    }

    // MARK: - forgotPassword()

    func test_forgotPassword_callsOnForgotPasswordClosure() {
        let sut = LoginViewModel()

        var closureCalled = false
        sut.onForgotPassword = { closureCalled = true }

        sut.forgotPassword()

        XCTAssertTrue(closureCalled, "onForgotPassword closure should be called on forgotPassword()")
    }

    // MARK: - needHelp()

    func test_needHelp_callsOnNeedHelpClosure() {
        let sut = LoginViewModel()

        var closureCalled = false
        sut.onNeedHelp = { closureCalled = true }

        sut.needHelp()

        XCTAssertTrue(closureCalled, "onNeedHelp closure should be called on needHelp()")
    }

    // MARK: - isPasswordVisible toggle

    func test_isPasswordVisible_togglesFromFalseToTrue() {
        let sut = LoginViewModel()
        XCTAssertFalse(sut.isPasswordVisible)
        sut.isPasswordVisible = true
        XCTAssertTrue(sut.isPasswordVisible)
    }
}
