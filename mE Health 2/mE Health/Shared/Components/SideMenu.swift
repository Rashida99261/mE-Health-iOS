//
//  SideMenu.swift
//  mE-Core
//
//  Created by iPHTech21 on 05/06/25.
//

import SwiftUI


struct SideMenuIconView: View {
    
    var isSystemImage:Bool
    var iconName:String
    var color:Color = Color.pink
    var name:String
    @State var showLogoutAlert = false
    var body: some View{
        
        HStack(alignment: .top) {
            
            VStack(alignment: .center, spacing: isSystemImage ? 8 : 8){
                
                Button(action: {
                        print("Button Tapped")
                }) {
                    if isSystemImage{
                        Image(systemName: iconName)
                            .frame(width: 28, height: 28)
                            .foregroundColor(color)
                            .background(Color.white)
                            .clipShape(Circle())
                            
                            .shadow(radius: 1)
                    }else{
                        Image(iconName)
                            .frame(width: 28, height: 28)
                            .foregroundColor(color)
                            .background(Color.white)
                            .clipShape(Circle())
                       
                            .shadow(radius: 1)
                    }
                    
                }.scaleEffect(1.5, anchor: .center)
                
                Text(name)
                    .fontWeight(.light)
                    .font(Font.system(size: 11.0))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray).padding(.top,name == "Dashboard" || name == "Switch to User" || name == "Switch to mEProvider" ? 0 : 0)
            }
            
        }.frame(width:70, height: 60)
    }
}

struct SideMenuView: View {
    let selectedTab: SideMenuTab
    let onItemTap: (SideMenuTab) -> Void

    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            SideMenuItemView(iconName: "dashboard_menu", title: "Dashboard") {
                onItemTap(.dashboard)
            }

            SideMenuItemView(iconName: "Personas", title: "My Persona") {
                onItemTap(.persona)
            }

            SideMenuItemView(iconName: "setting", title: "Settings") {
                onItemTap(.settings)
            }

            SideMenuItemView(iconName: "ContactUs", title: "Contact Us") {
                onItemTap(.contact)
            }

            SideMenuItemView(iconName: "logout", title: "Logout") {
                onItemTap(.logout)
            }

            Spacer()
        }
        .padding(.top, 60)
        .padding(.horizontal, 16) // ✅ Keep minimal padding here if needed
        .frame(width: 150, alignment: .center)
        .background(Color(.systemGray6))
    }
}


struct SideMenuItemView: View {
    let iconName: String
    let title: String
    let action: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            Button(action: action) {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 48, height: 48)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)

                    Image(iconName)
                }
            }

            Text(title)
                .font(.custom("Montserrat-Medium", size: 14))
                .foregroundColor(.primary)
        }
        .padding(.vertical, 4)
    }
}

enum SideMenuTab: Equatable {
    case dashboard
    case persona
    case settings
    case contact
    case logout
}
