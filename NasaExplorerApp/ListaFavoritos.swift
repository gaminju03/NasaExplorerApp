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
    @Environment(\.managedObjectContext) var moc//conectamos con la db en la variable moc
     @FetchRequest(entity: Favoritos.entity(), sortDescriptors: []) var favoritos: FetchedResults<Favoritos>//consulta de la entity
    
    var body: some View {
      NavigationView {
                 
                        List {
                                //mostamos el arreglo deacurdo con el id y lo inicializamos el el item
                            ForEach(favoritos,id:\.id) { item in
                            HStack{
                                //consulta imagen con
                                WebImage(url:URL(string: item.imagen)).resizable()
                                    .frame(width:100, height: 100)
                                VStack{
                                    //consulta titulo de la db
                                     Text("\(item.titulo)")
                                    //consulta fecha db
                                    Text("Date: \(item.fecha)")
                                }
                                
                            }
                            
                            }.onDelete { indexSet in
                                for index in indexSet {
                                    self.moc.delete(self.favoritos[index])
                                }
                            }

                            }
                            
                        .navigationBarTitle("NASA EXPLORER APP")
                    }
    }
}
//mostramos lista favoritos con un view 
struct ListaFavoritos_Previews: PreviewProvider {
    static var previews: some View {
        ListaFavoritos()
    }
}
