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
    @Environment(\.managedObjectContext) var moc
   @State private var favoritosel = Favoritos()
    @State private var favorito = false
   @FetchRequest(entity: Favoritos.entity(), sortDescriptors: []) var listafavoritos: FetchedResults<Favoritos>
    
    
    var nasaImage : NasaImage
    
    var body: some View {
        
            VStack{
                // Text(nasaImage.title)
                ZStack (alignment: .bottomTrailing){
                    WebImage(url:URL(string: nasaImage.image)).resizable()
                            .frame(height: 350)
                    HStack{
                          Text("Center: \(nasaImage.center)")
                        Spacer()
                        Text("Date: \(nasaImage.date_created)")
                    }.background(Color.black)
                   
                }.foregroundColor(.white)
                 .background(Color.black)
                
                .padding()/// seguir diseño de detalle
                
             

                Text(nasaImage.description)
              Spacer()
            }.navigationBarTitle(nasaImage.title)
             .onAppear(perform: favoritoscheck)
     
                     .navigationBarItems(trailing: Button( action:{
                        
                        self.favorito.toggle()//si el valor es false comvierte a false  cambio de estado y actualiza nuevamente
                        
                        if(self.favorito){
                            let favoritodb = Favoritos(context: self.moc)
                            favoritodb.id = self.nasaImage.id
                            favoritodb.imagen = self.nasaImage.image
                            favoritodb.fecha = self.nasaImage.date_created
                            favoritodb.titulo = self.nasaImage.title
                            
                              try? self.moc.save()
                            self.favoritosel=favoritodb
                            
                            
                        }
                        else{
                           
                            self.moc.delete(self.favoritosel)
                             
                            
                        }
                        
                         
                         }){
                             Image(systemName: self.favorito ? "heart.fill": "heart")//si favorito es true
                                 .resizable().frame(width: 24, height: 24, alignment: .center).foregroundColor(.red)
                            
                             
                         }
                     )
    }
    
    func favoritoscheck(){
    //coleccion de registros que coinsiden en el criterio de busqueda
        let filtered = self.listafavoritos.filter{($0).id == self.nasaImage.id}//filtar la lista
        if filtered.count > 0 {//consulta por el id
          self.favorito = true //cambia el valor a true para cambiarlo a favorito
            self.favoritosel=filtered.first! //elimina favorito seleccionado de la lista , recupera el primer eliemenoto filtrado
        }
        
        
    }
}


struct Detalle_Previews: PreviewProvider {
    static var previews: some View {
        Detalle(nasaImage: NasaImage(id: "", description: "", title: "", image: "", center: "", date_created: ""))
        
        
    }
    
    
}
