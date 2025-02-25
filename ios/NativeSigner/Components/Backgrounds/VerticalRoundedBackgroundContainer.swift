//
//  VerticalRoundedBackgroundContainer.swift
//  NativeSigner
//
//  Created by Krzysztof Rodak on 21/12/2022.
//

import SwiftUI

struct VerticalRoundedBackgroundContainer: ViewModifier {
    let cornerRadius: CGFloat
    let alignment: HorizontalAlignment

    func body(content: Content) -> some View {
        VStack(alignment: alignment) {
            content
                .padding(Spacing.medium)
        }
        .background(Asset.fill6Solid.swiftUIColor)
        .cornerRadius(cornerRadius)
    }
}

extension View {
    func verticalRoundedBackgroundContainer(
        _ cornerRadius: CGFloat = CornerRadius.medium,
        alignment: HorizontalAlignment = .center
    ) -> some View {
        modifier(VerticalRoundedBackgroundContainer(cornerRadius: cornerRadius, alignment: alignment))
    }
}
