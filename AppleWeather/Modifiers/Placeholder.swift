// https://stackoverflow.com/questions/57688242/swiftui-how-to-change-the-placeholder-color-of-the-textfield

import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

extension View {
    func placeholder(
        _ text: String,
        when shouldShow: Bool,
        alignment: Alignment = .leading) -> some View {
            
        placeholder(when: shouldShow, alignment: alignment) {
            Text(text)
                .foregroundColor(.gray)
        }
    }
}
