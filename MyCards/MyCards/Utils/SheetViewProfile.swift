//
//  Utils.swift
//  MyCards
//
//  Created by Valerio Mosca on 16/11/22.
//

import SwiftUI
import PhotosUI

struct SheetViewProfile: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var fiscalCode: String = ""
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var image: UIImage = UIImage(named: "personBlu")!
    @State private var reloader: Int = 0
    
    var body: some View {
        NavigationView(){
            VStack{
                Spacer()
                Spacer()
                Image(uiImage: image).resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120.0,height: 120.0)
                    .clipped()
                    .cornerRadius(150)
                
                
                //button addphoto
                PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared())
                {
                    Text("add photo")
                }
                .onChange(of: selectedItem) { newItem in
                    Task {
                        
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            selectedImageData = data
                        }
                        
                        //updateImg()
                        
                        if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
                            
                            image = uiImage
                            reloader += 1 //perchè sono stato costretto ad utilizzare un'altra variabile @State per poter aggiornare la schermata? anche image era @State...
                            
                        }
                    }
                }
                
                List{
                    Section(){
                        HStack{
                            TextField("Name" ,
                                      text : $name)
                            Spacer()
                        }
                        HStack{
                            TextField("Surname" ,
                                      text : $surname)
                        }
                        
                        HStack{
                            TextField( "Fiscal Code" ,
                                       text : $fiscalCode)
                        }
                        
                        
                    }
                    Section(){
                        Button{
                            //dismiss()
                        }label: {
                            Text("add a field")
                        }
                    }
                    
                }.listStyle(GroupedListStyle())
                    .offset(y:-10)
                    
            }
            .background(Color("sheetColor")            .ignoresSafeArea()
)
                .navigationBarTitle("Add Profile", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    do{
                        try
                        addProfile()
                        dismiss()
                    }catch{
                        print("Missing fields")
                    }
                    
                }, label: {
                    Text("Done")
                }))
                .navigationBarItems(leading: Button(action: {
                    dismiss()
                }, label: {
                    Text("Cancel")
                }))
                
        }
//        Spacer()
    }
    
    enum FormSubmissionError: Error {
            case missingInput
            case anyOtherKindofError
        }
    
    private func addProfile() throws {
        guard self.name != "" && self.surname != "" else {throw FormSubmissionError.missingInput}
        let newProfile = Profile(context: viewContext)
        newProfile.name = self.name
        newProfile.surname = self.surname
        newProfile.fiscalCode = self.fiscalCode
        newProfile.id = UUID()
        
        let imagePng = image.pngData()
        newProfile.image = imagePng
        saveProfile()
    }
    
    private func saveProfile(){
        do {
            try viewContext.save()
                print("Profile saved.")
            } catch {
                print(error.localizedDescription)
            }
    }
}


struct SheetViewProfile_Previews: PreviewProvider {
    static var previews: some View {
        SheetViewProfile()
    }
}

