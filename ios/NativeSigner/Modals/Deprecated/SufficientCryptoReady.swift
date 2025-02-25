//
//  SufficientCryptoReady.swift
//  NativeSigner
//
//  Created by Alexander Slesarev on 21.12.2021.
//

import SwiftUI

struct SufficientCryptoReady: View {
    @GestureState private var dragOffset = CGSize.zero
    @State private var offset: CGFloat = 0
    @State private var oldOffset: CGFloat = 0
    var content: MSufficientCryptoReady
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8).foregroundColor(Asset.backgroundPrimary.swiftUIColor)
            VStack {
                VStack(alignment: .leading, spacing: 2) {
                    Localizable.yourSignature.text
                        .foregroundColor(Asset.textAndIconsPrimary.swiftUIColor)
                        .font(PrimaryFont.labelS.font)
                        .tracking(0.5)
                        .textCase(.uppercase)
                    Localizable.scanItIntoYourApplication.text
                        .foregroundColor(Asset.textAndIconsTertiary.swiftUIColor)
                        .font(PrimaryFont.bodyM.font)
                    Divider()
                        .padding(.top, 6)
                }
                .font(PrimaryFont.captionM.font)
                AnimatedQRCodeView(
                    viewModel: Binding<AnimatedQRCodeViewModel>.constant(
                        .init(
                            qrCodes: [content.sufficient]
                        )
                    )
                )
                .padding(Spacing.small)
                AddressCard(card: content.authorInfo)
                switch content.content {
                case let .addSpecs(network):
                    Localizable.signatureForNetworkSpecs.text
                    NetworkCard(title: network.networkTitle, logo: network.networkLogo)
                case .loadTypes:
                    Localizable.signatureForTypes.text
                case let .loadMetadata(name: name, version: version):
                    Localizable.signatureForMetadataUpdate.text
                    Text(Localizable.Signature.metadata(name, String(version)))
                }
            }
        }
    }
}

// struct SufficientCryptoReady_Previews: PreviewProvider {
// static var previews: some View {
// SufficientCryptoReady()
// }
// }
