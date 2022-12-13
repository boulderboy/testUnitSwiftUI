//
//  CustomTabView.swift
//  TestUnit
//
//  Created by Mac on 12.12.2022.
//

import SwiftUI

struct CustomTabView<Content: View>: View {
    
    let tabs: [TabItemData]
    @Binding var selectedIndex: Int
    @ViewBuilder let content: (Int) -> Content
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedIndex) {
                ForEach(tabs.indices) { index in
                    content(index)
                        .tag(index)
                }
            }
            VStack {
                Spacer()
                TabBarView(tabItems: tabs, selectedIndex: $selectedIndex)
            }
            .padding(.bottom, 3)
        }
    }
}

enum TabType: Int, CaseIterable {
    case explorer = 0
    case cart
    case favorite
    case profile
    
    var tabItem: TabItemData {
        switch self {
        case .explorer:
            return TabItemData(image: "folder", title: "Explorer")
        case .cart:
            return TabItemData(image: "cart", title: "Cart")
        case .favorite:
            return TabItemData(image: "heart", title: "Favourite")
        case .profile:
            return TabItemData(image: "profile", title: "Profile")
        }
    }
}

//struct CustomTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomTabView()
//    }
//}
