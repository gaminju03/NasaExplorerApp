//
//  ContentView.swift
//  NasaExplorerApp
//
//  Created by Juan on 28/04/20.
//  Copyright © 2020 usuario. All rights reserved.
//

import SwiftUI//
struct NasaImage:Identifiable {
    var id : String
    var description : String
    var title : String
    var image : String
    var center : String
    var date_created : String
    
    
}

struct ContentView: View {
    @State private var ListImage = [NasaImage]()
    
    var body: some View {
         NavigationView {
            
                   List {
                  
                      ForEach(ListImage) { item in
                           VStack(alignment: .leading){
                               Text(item.title)
                                   .font(.headline)
                               Text(item.image)

                           }

                       }

                       }.onAppear(perform: loadData)
                   .navigationBarTitle("Nasa Explorer APP")
               }

           }
           
           func loadData(){
               //Paso 1 URL
               guard let url = URL (string: "https://images-api.nasa.gov/search?q=Earth&media_type=image")else{
                   print("Validar URL")
                   return
               }
               //Paso 2
               let request = URLRequest(url: url)
               
               //PASO 3
               URLSession.shared.dataTask(with: request){data, response, error in
               //PASO 4
                   if let data = data{
                    do {
                           let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    
                           // Parse JSON data //nodo raiz
                           let jsoncollection = jsonResult?["collection"] as! AnyObject
                       let jsonitems = jsoncollection["items"] as! [AnyObject]
                        for jsonItem in jsonitems{
                            let jsonLinks = jsonItem["links"] as! [AnyObject]
                             let jsonData = jsonItem["data"] as! [AnyObject]
                            let jsonhref = jsonLinks[0] as! [String:AnyObject]
                            let image = jsonhref["href"] as! String
                            let jsondata = jsonData[0] as! [String:AnyObject]
                            let description = jsondata["description"] as! String
                            let nasa_id = jsondata["nasa_id"] as! String
                            let title = jsondata["title"] as! String
                            let center = jsondata["center"] as! String
                            let date_created = jsondata["date_created"] as! String
                            
                            let nasaImages = NasaImage(
                                id: nasa_id, description: description, title: title, image: image, center: center, date_created: date_created
                                
                                
                            )
                           
                            DispatchQueue.main.async {
                                //main thread
                                self.ListImage.append(nasaImages)
                            }
                            
                        }
                        
                        
                        /* for jsonLoan in jsonLoans {
                               let loan = Loan()
                               loan.name = jsonLoan["name"] as! String
                               loan.amount = jsonLoan["loan_amount"] as! Int
                               loan.use = jsonLoan["use"] as! String
                               let location = jsonLoan["location"] as! [String:AnyObject]
                               loan.country = location["country"] as! String
                               loans.append(loan)
                           }*/
                       
                        return
                    
                       } catch {
                           print(error)
                       }
                   }
                   
                   print ("Fetch failed\(error?.localizedDescription ?? "Unkow error" )")
                   
               }.resume()
               
           }

    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
