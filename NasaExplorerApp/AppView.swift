//
//  AppView.swift
//  NasaExplorerApp
//
//  Created by Juan on 28/04/20.
//  Copyright © 2020 usuario. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            //Tab 1
            ContentView().tabItem {
                Image(systemName: "house")
                Text("Inicio")
            }
            //Tab 2
            /*OrderView().tabItem{
                Image(systemName: "star.circle")
                Text("Order")
            }*/
        }
        
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
