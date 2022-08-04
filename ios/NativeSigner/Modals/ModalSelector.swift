//
//  ModalSelector.swift
//  NativeSigner
//
//  Created by Alexander Slesarev on 7.12.2021.
//

import SwiftUI

struct ModalSelector: View {
    let modalData: ModalData?
    let alert: Bool
    let alertShow: () -> Void
    let pushButton: (Action, String?) -> Void
    let removeSeed: (String) -> Void
    let restoreSeed: (String, String, Bool) -> Void
    let createAddress: (String, String) -> Void
    let getSeedForBackup: (String) -> String
    let sign: (String, String) -> Void

    var body: some View {
        switch modalData {
        case .newSeedMenu:
            NewSeedMenu(
                alert: alert,
                alertShow: alertShow,
                pushButton: { self.pushButton($0, nil) }
            )
        case let .networkSelector(value):
            NetworkManager(
                content: value,
                pushButton: pushButton
            )
        case let .seedMenu(value):
            SeedMenu(
                content: value,
                alert: alert,
                alertShow: alertShow,
                removeSeed: removeSeed,
                pushButton: { self.pushButton($0, nil) }
            )
        case let .backup(value):
            Backup(
                content: value,
                alert: alert,
                getSeedForBackup: getSeedForBackup,
                pushButton: { self.pushButton($0, nil) }
            )
        case let .passwordConfirm(value):
            PasswordConfirm(
                content: value,
                createAddress: createAddress
            )
        case let .signatureReady(value):
            SignatureReady(
                content: value,
                pushButton: { self.pushButton($0, nil) }
            )
        case let .enterPassword(value):
            EnterPassword(
                content: value,
                pushButton: pushButton
            )
        case let .logRight(value):
            LogMenu(
                content: value,
                pushButton: { self.pushButton($0, nil) }
            )
        case .networkDetailsMenu:
            NetworkDetailsMenu(
                pushButton: { self.pushButton($0, nil) }
            )
        case let .manageMetadata(value):
            ManageMetadata(
                content: value,
                pushButton: { self.pushButton($0, nil) }
            )
        case let .sufficientCryptoReady(value):
            SufficientCryptoReady(content: value)
        case .keyDetailsAction:
            KeyMenu(
                pushButton: { self.pushButton($0, nil) }
            )
        case let .typesInfo(value):
            TypesMenu(
                content: value,
                pushButton: { self.pushButton($0, nil) }
            )
        case let .newSeedBackup(value):
            NewSeedBackupModal(
                content: value,
                restoreSeed: restoreSeed,
                pushButton: { self.pushButton($0, nil) }
            )
        case .logComment:
            LogComment(
                pushButton: pushButton
            )
        case let .selectSeed(value):
            SelectSeed(
                content: value,
                sign: sign,
                pushButton: { self.pushButton($0, nil) }
            )
        case nil:
            EmptyView()
        }
    }
}

// struct ModalSelector_Previews: PreviewProvider {
// static var previews: some View {
// ModalSelector()
// }
// }
