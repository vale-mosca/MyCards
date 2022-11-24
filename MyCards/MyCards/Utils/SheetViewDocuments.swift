//
//  Utils.swift
//  MyCards
//
//  Created by Valerio Mosca on 16/11/22.
//

import SwiftUI
import PhotosUI

struct SheetViewDocuments: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var cardType: String = ""
    @State private var cardNumber: String = ""
    @State private var expiryDate: Date = Date()
    @State private var rearImage: UIImage = UIImage(named: "rearCard")!
    @State private var frontImage: UIImage = UIImage(named: "frontCard")!
    
    //@State private var color: String = ""
    
    var selectedProfile: Profile
    
    @State private var selectedItemRear: PhotosPickerItem? = nil
    @State private var selectedImageDataRear: Data? = nil
    
    @State private var selectedItemFront: PhotosPickerItem? = nil
    @State private var selectedImageDataFront: Data? = nil
    
    @State private var reloader: Int = 0
    
    
    var body: some View {
        NavigationView(){
            VStack{
                Spacer()
                
                HStack{
                    Spacer()
                    
                    PhotosPicker(selection: $selectedItemFront, matching: .images, photoLibrary: .shared())
                    {
                        VStack{
                            Image(uiImage: frontImage).resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120.0,height: 120.0)
                                .clipped()
                            
                            Text("add front photo")
                        }
                    }
                    .onChange(of: selectedItemFront) { newItem in
                        Task {
                            
                            if let frontData = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedImageDataFront = frontData
                            }
                            
                            //updateImg()
                            
                            if let selectedImageDataFront, let uiImageFront = UIImage(data: selectedImageDataFront) {
                                
                                frontImage = uiImageFront
                                reloader += 1 //perchè sono stato costretto ad utilizzare un'altra variabile @State per poter aggiornare la schermata? anche image era @State...
                                
                            }
                        }
                    }
                    
                    Spacer()
                    
                    //button addphoto
                    PhotosPicker(selection: $selectedItemRear, matching: .images, photoLibrary: .shared())
                    {
                        VStack{
                            Image(uiImage: rearImage).resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120.0,height: 120.0)
                                .clipped()
                            
                            Text("add rear photo")
                        }
                    }
                    .onChange(of: selectedItemRear) { newItem in
                        Task {
                            
                            if let rearData = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedImageDataRear = rearData
                            }
                            
                            //updateImg()
                            
                            if let selectedImageDataRear, let uiImageRear = UIImage(data: selectedImageDataRear) {
                                
                                rearImage = uiImageRear
                                reloader += 1 //perchè sono stato costretto ad utilizzare un'altra variabile @State per poter aggiornare la schermata? anche image era @State...
                                
                            }
                        }
                    }
                    Spacer()
                }
                
                List{
                    Section(){
                        
                            TextField("Document Type" ,
                                      text : $cardType)
                            
                            TextField("Document Number" ,
                                      text : $cardNumber)
                    }
                    
                    Section(){
                        DatePicker("Expiry Date", selection: $expiryDate, in: Date()..., displayedComponents: .date)
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
                
                
            }.background(Color("sheetColor")            .ignoresSafeArea())
                //.frame(maxWidth: .infinity)
                .navigationBarTitle("Add Card", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    
                    do {
                        try
                        addDocument()
                        dismiss()
                    }catch{
                        //how do I show them the error? alerts are deprecated, Should I set the button unclickable? How?
                        print("Missing field")
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
        //Spacer()
    }
    
    enum FormSubmissionError: Error {
            case missingInput
            case anyOtherKindofError
        }
    
    
    private func addDocument() throws{
        guard self.cardType != "" && self.cardNumber != ""  else {throw FormSubmissionError.missingInput}
        let newDocument = Document(context: viewContext)
        newDocument.cardType = self.cardType
        newDocument.cardNumber = self.cardNumber
        newDocument.expiryDate = self.expiryDate
        newDocument.id = UUID()
        newDocument.hasAProfile = self.selectedProfile
        
        let rearImagePng = rearImage.pngData()
        let frontImagePng = frontImage.pngData()
        newDocument.rearImage = rearImagePng
        newDocument.frontImage = frontImagePng
        
        saveDocument()
    }
    
    private func saveDocument(){
        do {
            try viewContext.save()
            print("Document saved.")
        } catch {
            print(error.localizedDescription)
        }
    }
}


struct SheetViewDocuments_Previews: PreviewProvider {
    static var previews: some View {
        SheetViewDocuments(selectedProfile: Profile())
    }
}


    

