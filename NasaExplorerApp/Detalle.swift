//
//  Detalle.swift
//  NasaExplorerApp
//
//  Created by Juan on 29/04/20.
//  Copyright © 2020 usuario. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct Detalle: View {
    var nasaImage : NasaImage
    
    var body: some View {
          NavigationView {
            Form{
                // Text(nasaImage.title)
                ZStack (alignment: .bottomTrailing){
                    WebImage(url:URL(string: nasaImage.image)).resizable()
                            .frame(height: 400)
                    HStack{
                          Text("Center: \(nasaImage.center)")
                        Spacer()
                        Text("Date: \(nasaImage.date_created)")
                    }.foregroundColor(.white)
                     .background(Color.black)
                    .font(.caption)
                    .padding()/// seguir diseño de detalle
                   
                }
                
             

                Text(nasaImage.description)
              Spacer()
            }.navigationBarTitle(nasaImage.title)
            
                         
                     }
    }
}

struct Detalle_Previews: PreviewProvider {
    static var previews: some View {
        Detalle(nasaImage: NasaImage(id: "", description: "", title: "", image: "", center: "", date_created: ""))
    }
}
