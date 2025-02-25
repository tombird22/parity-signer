//
//  DerivationMethodsInfoView.swift
//  NativeSigner
//
//  Created by Krzysztof Rodak on 11/01/2023.
//

import SwiftUI

struct DerivationMethodsInfoView: View {
    @StateObject var viewModel: ViewModel
    @EnvironmentObject private var appState: AppState

    var body: some View {
        FullScreenRoundedModal(
            backgroundTapAction: viewModel.animateDismissal,
            animateBackground: $viewModel.animateBackground,
            ignoredEdges: .bottom,
            content: {
                VStack(spacing: 0) {
                    // Header with X button
                    HStack {
                        Localizable.CreateDerivedKey.InfoModal.DerivationMethods.title.text
                            .foregroundColor(Asset.textAndIconsPrimary.swiftUIColor)
                            .font(PrimaryFont.titleS.font)
                        Spacer()
                        CloseModalButton(action: viewModel.animateDismissal)
                    }
                    .padding(.leading, Spacing.large)
                    .padding(.trailing, Spacing.medium)
                    .padding(.bottom, Spacing.medium)
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: Spacing.small) {
                            Localizable.CreateDerivedKey.InfoModal.DerivationMethods.Soft.title.text
                                .foregroundColor(Asset.textAndIconsPrimary.swiftUIColor)
                                .font(PrimaryFont.titleS.font)
                            Localizable.CreateDerivedKey.InfoModal.DerivationMethods.Soft.content.text
                                .foregroundColor(Asset.textAndIconsSecondary.swiftUIColor)
                                .font(PrimaryFont.bodyM.font)
                            Localizable.CreateDerivedKey.InfoModal.DerivationMethods.Hard.title.text
                                .foregroundColor(Asset.textAndIconsPrimary.swiftUIColor)
                                .font(PrimaryFont.titleS.font)
                            Localizable.CreateDerivedKey.InfoModal.DerivationMethods.Hard.content.text
                                .foregroundColor(Asset.textAndIconsSecondary.swiftUIColor)
                                .font(PrimaryFont.bodyM.font)
                            Localizable.CreateDerivedKey.InfoModal.DerivationMethods.Password.title.text
                                .foregroundColor(Asset.textAndIconsPrimary.swiftUIColor)
                                .font(PrimaryFont.titleS.font)
                            Localizable.CreateDerivedKey.InfoModal.DerivationMethods.Password.content.text
                                .foregroundColor(Asset.textAndIconsSecondary.swiftUIColor)
                                .font(PrimaryFont.bodyM.font)
                            SecondaryButton(
                                action: viewModel.animateDismissal(),
                                text: Localizable.CreateDerivedKey.InfoModal.DerivationMethods.action.key
                            )
                        }
                        .padding(.horizontal, Spacing.large)
                        .padding(.bottom, Spacing.large)
                        .padding(.top, Spacing.medium)
                    }
                }
            }
        )
    }
}

extension DerivationMethodsInfoView {
    final class ViewModel: ObservableObject {
        @Published var animateBackground: Bool = false
        @Binding var isPresented: Bool

        init(
            isPresented: Binding<Bool>
        ) {
            _isPresented = isPresented
        }

        func animateDismissal() {
            Animations.chainAnimation(
                animateBackground.toggle(),
                // swiftformat:disable all
                delayedAnimationClosure: self.hide()
            )
        }

        private func hide() {
            isPresented = false
        }
    }
}

#if DEBUG
struct DerivationMethodsInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DerivationMethodsInfoView(
            viewModel: .init(
                isPresented: .constant(true)
            )
        )
    }
}
#endif
