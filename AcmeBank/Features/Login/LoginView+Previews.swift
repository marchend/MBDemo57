import SwiftUI

// MARK: - Previews

#Preview("Default — Light Mode") {
    LoginView(viewModel: LoginViewModel())
}

#Preview("Dark Mode") {
    LoginView(viewModel: LoginViewModel())
        .preferredColorScheme(.dark)
}

#Preview("Accessibility — Large Dynamic Type") {
    LoginView(viewModel: LoginViewModel())
        .dynamicTypeSize(.accessibility3)
}

#Preview("Loading State") {
    let vm = LoginViewModel()
    vm.isLoading = true
    return LoginView(viewModel: vm)
}
