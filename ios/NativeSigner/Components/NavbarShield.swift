//
//  NavbarShield.swift
//  NativeSigner
//
//  Created by Alexander Slesarev on 27.7.2021.
//

import Network
import SwiftUI

struct NavbarShield: View {
    let canaryDead: Bool
    let alert: Bool
    let pushButton: (Action) -> Void
    var body: some View {
        Button(
            action: {
                pushButton(.shield)
            },
            label: {
                if canaryDead /* bluetooth detector: `|| data.bsDetector.canaryDead` */ {
                    Image(systemName: "shield.slash")
                        .imageScale(.large)
                        .foregroundColor(Color("SignalDanger"))
                } else {
                    if alert {
                        Image(systemName: "exclamationmark.shield")
                            .imageScale(.large)
                            .foregroundColor(Color("SignalWarning"))
                    } else {
                        Image(systemName: "lock.shield.fill")
                            .imageScale(.large)
                            .foregroundColor(Color("Crypto400"))
                    }
                }
            }
        )
    }
}

// struct NavbarShield_Previews: PreviewProvider {
// static var previews: some View {
// NavbarShield().previewLayout(.sizeThatFits)
// }
// }
