import SwiftUI

struct CustomTabBarItem: View {
    let title: String
    @Binding var selectedTab: String

    var body: some View {
        Text(title)
            .padding()
            .onTapGesture {
                selectedTab = title
            }
    }
}

struct RnDView: View {
    @State private var selectedTab = "Tab1"

    var body: some View {
        VStack {
            // Custom Tab Bar at the Top
            HStack {
                CustomTabBarItem(title: "Tab 1", selectedTab: $selectedTab)
                CustomTabBarItem(title: "Tab 2", selectedTab: $selectedTab)
                // Add more tabs as needed
            }

            // Content below the tab bar
            TabView(selection: $selectedTab) {
                Text("Content of Tab 1")
                    .tag("Tab1")
                Text("Content of Tab 2")
                    .tag("Tab2")
                // Add more content views as needed
            }
        }
    }
}




#Preview {
    RnDView()
}
