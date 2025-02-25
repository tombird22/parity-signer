//
//  NavbarActionButton.swift
//  NativeSigner
//
//  Created by Krzysztof Rodak on 11/09/2022.
//

import SwiftUI

struct NavbarActionButtonStyle: ButtonStyle {
    @Binding var isDisabled: Bool

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(Spacing.medium)
            .background($isDisabled.wrappedValue ? Asset.fill18.swiftUIColor : Asset.accentPink500.swiftUIColor)
            .foregroundColor(Asset.accentForegroundText.swiftUIColor)
            .font(PrimaryFont.labelM.font)
            .frame(
                height: Heights.navigationButton,
                alignment: .center
            )
            .cornerRadius(CornerRadius.large)
    }
}

struct NavbarActionButton: View {
    private let action: () -> Void
    private let title: LocalizedStringKey
    @Binding private var isDisabled: Bool

    init(
        action: @escaping () -> Void,
        title: LocalizedStringKey,
        isDisabled: Binding<Bool> = .constant(false)
    ) {
        self.action = action
        self.title = title
        _isDisabled = isDisabled
    }

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
            }
        }
        .buttonStyle(NavbarActionButtonStyle(isDisabled: $isDisabled))
        .disabled(isDisabled)
    }
}

struct NavbarActionButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading, spacing: 10) {
            NavbarActionButton(
                action: {},
                title: Localizable.done.key
            )
            NavbarActionButton(
                action: {},
                title: Localizable.done.key,
                isDisabled: .constant(true)
            )
        }
        .padding()
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
    }
}
