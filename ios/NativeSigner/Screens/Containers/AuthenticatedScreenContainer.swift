//
//  AuthenticatedScreenContainer.swift
//  NativeSigner
//
//  Created by Krzysztof Rodak on 05/08/2022.
//

import SwiftUI

struct AuthenticatedScreenContainer: View {
    @EnvironmentObject private var data: SignerDataModel
    @EnvironmentObject private var connectivityMediator: ConnectivityMediator
    @EnvironmentObject private var navigation: NavigationCoordinator

    @StateObject var snackBarPresentation = ServiceLocator.bottomSnackbarPresentation
    @GestureState private var dragOffset = CGSize.zero
    @State private var isShowingQRScanner: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            if !navigation.shouldSkipInjectedViews {
                NavigationBarView(
                    viewModel: .init(
                        title: navigation.actionResult.screenLabel,
                        leftButtons: [
                            .init(
                                type: navigation.actionResult.back ? .arrow : .empty,
                                action: { navigation.perform(navigation: .init(action: .goBack)) }
                            )
                        ],
                        rightButtons: [
                            .init(
                                type: [.none, .multiSelect]
                                    .contains(navigation.actionResult.rightButton) ? .empty : .more,
                                action: { self.navigation.perform(navigation: .init(action: .rightButtonAction)) }
                            )
                        ]
                    )
                )
            }
            ZStack {
                VStack(spacing: 0) {
                    ScreenSelector()
                }
                ModalSelector()
            }
            .gesture(
                DragGesture().updating($dragOffset, body: { value, _, _ in
                    if value.startLocation.x < 20, value.translation.width > 100, !navigation.disableSwipeToBack {
                        navigation.perform(navigation: .init(action: .goBack))
                    }
                })
            )
            if navigation.actionResult.footer, navigation.selectedTab != .keys {
                TabBarView(
                    selectedTab: $navigation.selectedTab
                )
            }
        }
        .bottomEdgeOverlay(
            overlayView: CameraView(
                viewModel: .init(
                    isPresented: $navigation.shouldPresentQRScanner
                )
            ),
            isPresented: $isShowingQRScanner
        )
        .onReceive(navigation.$shouldPresentQRScanner) { shouldPresent in
            withAnimation {
                if shouldPresent {
                    // Pretend to go to QR Scanner tab, to be able to display transaction later
                    navigation.performFake(navigation: .init(action: .navbarScan))
                    isShowingQRScanner = true
                } else {
                    if let overrideNavigation = navigation.overrideQRScannerDismissalNavigation {
                        // Override default tab navigation when we want to end on specific screen after camera
                        // dismissal
                        navigation.perform(navigation: overrideNavigation)
                        navigation.overrideQRScannerDismissalNavigation = nil
                    } else if let action = navigation.selectedTab.action {
                        // "Pretend" to go back to previous tab (as we don't change `selectedTab` when showing QR screen
                        // now), but do
                        // it for real before dismissing QR code scanner to have dataset to display as we might have
                        // ventured
                        // into transaction details
                        navigation.perform(navigation: .init(action: action))
                    }
                    isShowingQRScanner = false
                }
            }
        }
        .gesture(
            DragGesture().onEnded { drag in
                if drag.translation.width < -20 {
                    navigation.perform(navigation: .init(action: .goBack))
                }
            }
        )
        .environmentObject(snackBarPresentation)
        .bottomSnackbar(snackBarPresentation.viewModel, isPresented: $snackBarPresentation.isSnackbarPresented)
        .fullScreenCover(
            isPresented: $navigation.genericError.isPresented
        ) {
            ErrorBottomModal(
                viewModel: .alertError(message: navigation.genericError.errorMessage),
                dismissAction: navigation.perform(navigation: .init(action: .goBack)),
                isShowingBottomAlert: $navigation.genericError.isPresented
            )
            .clearModalBackground()
        }
    }
}
