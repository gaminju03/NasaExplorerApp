//
//  Favoritos.swift
//  NasaExplorerApp
//
//  Created by Juan on 29/04/20.
//  Copyright © 2020 usuario. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ListaFavoritos: View {
    @Environment(\.managedObjectContext) var moc
     @FetchRequest(entity: Favoritos.entity(), sortDescriptors: []) var favoritos: FetchedResults<Favoritos>
    
    var body: some View {
      NavigationView {
                 
                        List {
                       
                            ForEach(favoritos,id:\.id) { item in
                            HStack{
                                WebImage(url:URL(string: item.imagen)).resizable()
                                .frame(height: 400)
                                VStack{
                                     Text("\(item.titulo)")
                                    Text("Date: \(item.fecha)")
                                }
                                
                            }
                            
                            }.onDelete { indexSet in
                                for index in indexSet {
                                    self.moc.delete(self.favoritos[index])
                                }
                            }

                            }
                            
                        .navigationBarTitle("Nasa Explorer APP")
                    }
    }
}

struct ListaFavoritos_Previews: PreviewProvider {
    static var previews: some View {
        ListaFavoritos()
    }
}
