//
//  TodoRouter.swift
//  SwiftUIVIPER
//
//  Created by Yoshinori Kobayashi on 2023/04/05.
//

import SwiftUI

// Routerは、VIPERの中心的な役割を担い、画面遷移を制御します。
// SwiftUIでは、RouterはSwiftUIのNavigationLinkを使用して実装されます。
struct TodoRouter {
    static func makeView() -> some View {
        let interactor = TodoInteractor()
        let presenter = TodoPresenter(interactor: interactor)
        let view = TodoView(presenter: presenter)
        return view
    }
}
