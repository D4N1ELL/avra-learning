import SwiftUI

enum Tab: String, CaseIterable {
    case house
    case chart = "chart.bar"
    case message
    case person
}

struct CustomTabBar: View {
    let BlackGround = Color(red: 42/255, green: 42/255, blue: 42/255)
    
    @Binding var isTabBarVisible: Bool // Accept isTabBarVisible as a binding

    
    @Binding var selectedTab: Tab
    private var fillImage: String{
        selectedTab.rawValue + ".fill"
    }
    
    var body: some View{
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image (systemName: selectedTab == tab ? fillImage :
                        tab.rawValue)
                        .scaleEffect(tab == selectedTab ? 1.25: 1.0)
                        .foregroundColor(selectedTab == tab ? BlackGround : .gray)
                        .font(.system(size: 22))
                        .onTapGesture{
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
                
            }
            .frame(width: nil, height: 60)
            .background(.thinMaterial)
            .cornerRadius(30)
            .padding()
            .opacity(isTabBarVisible ? 1 : 0) // Toggle visibility based on isTabBarVisible
            .animation(.easeInOut, value: isTabBarVisible)
        }
    }
}
 
struct CustomTabBar_Previews: PreviewProvider {
    @State static var selectedTab: Tab = .house
    @State static var isTabBarVisible: Bool = true // Define isTabBarVisible for the preview

    static var previews: some View {
        CustomTabBar(isTabBarVisible: $isTabBarVisible, selectedTab: $selectedTab)
    }
}


