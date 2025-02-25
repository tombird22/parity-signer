//
//  FullScreenRoundedModal.swift
//  NativeSigner
//
//  Created by Krzysztof Rodak on 05/09/2022.
//

import SwiftUI

struct FullScreenRoundedModal<Content: View>: View {
    enum BottomSafeInsets {
        case full
        case partial
        case none

        func inset(_ value: CGFloat) -> CGFloat {
            switch self {
            case .full:
                return value
            case .partial:
                return value / 2.0
            case .none:
                return 0.0
            }
        }
    }

    @Binding private var animateBackground: Bool
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    private let safeAreaInsetsMode: BottomSafeInsets
    private let backgroundTapAction: () -> Void
    private let content: () -> Content
    private let ignoredEdges: Edge.Set

    init(
        backgroundTapAction: @escaping () -> Void = {},
        animateBackground: Binding<Bool> = Binding<Bool>.constant(false),
        ignoredEdges: Edge.Set = .all,
        safeAreaInsetsMode: BottomSafeInsets = .partial,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.backgroundTapAction = backgroundTapAction
        self.ignoredEdges = ignoredEdges
        _animateBackground = animateBackground
        self.safeAreaInsetsMode = safeAreaInsetsMode
        self.content = content
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            // Semi transparent background
            Spacer()
                .frame(idealHeight: .infinity)
                .background(animateBackground ? Color.black.opacity(0.5) : .clear)
                .onTapGesture(perform: backgroundTapAction)
                .onAppear {
                    withAnimation(
                        Animation.easeIn(duration: AnimationDuration.standard)
                            .delay(AnimationDuration.standard)
                    ) {
                        animateBackground.toggle()
                    }
                }
            // Modal content
            VStack(alignment: .leading, spacing: 0) {
                Spacer().frame(height: Spacing.topSafeAreaSpacing)
                    .background(animateBackground ? Color.black.opacity(0.5) : .clear)
                    .onTapGesture(perform: backgroundTapAction)
                VStack(alignment: .leading, spacing: Spacing.medium, content: content)
                    .padding(.top, Spacing.medium)
                    .padding([.leading, .trailing], 0)
                    .padding(.bottom, safeAreaInsetsMode.inset(safeAreaInsets.bottom))
                    .background(Asset.backgroundTertiary.swiftUIColor)
                    .cornerRadius(radius: CornerRadius.medium, corners: [.topLeft, .topRight])
            }
        }
        .ignoresSafeArea(edges: ignoredEdges)
    }
}

//
// struct FullScreenRoundedModal_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            FullScreenRoundedModal {
//                Text("Test label")
//                    .padding()
//                Text("Test label")
//                    .padding()
//            }
//        }
//        .preferredColorScheme(.dark)
//        .previewLayout(.sizeThatFits)
//        VStack {
//            FullScreenRoundedModal {
//                Text("Test label")
//                    .padding()
//                Text("Test label")
//                    .padding()
//            }
//        }
//        .preferredColorScheme(.light)
//        .previewLayout(.sizeThatFits)
//    }
// }
