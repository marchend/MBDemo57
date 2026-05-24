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

    // MARK: - forgotPassword()

    func test_forgotPassword_callsOnForgotPasswordClosure() {
        let sut = LoginViewModel()

        var closureCalled = false
        sut.onForgotPassword = { closureCalled = true }

        sut.forgotPassword()

        XCTAssertTrue(closureCalled, "onForgotPassword closure should be called on forgotPassword()")
    }
}
