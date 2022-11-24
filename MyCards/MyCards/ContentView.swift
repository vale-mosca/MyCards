//
//  SwiftUIView.swift
//  MyCards
//
//  Created by Valerio Mosca on 16/11/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.name)]
    ) var profilesArr: FetchedResults<Profile>
    
    
    @State private var showingSheet = false
    
    var body: some View {
        
        NavigationView {
            List{
                ForEach(profilesArr) { profile in
                    Section{      //COMMENT TO SEE THE ALTERNATIVE
                        NavigationLink{
                            RelatedCards(selectedProfile: profile)
                        } label: {
                            HStack{
                                let convertedUImg = Image(uiImage: UIImage(data: profile.image ?? Data()) ?? UIImage())
                                
                                convertedUImg
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50.0,height: 50.0)
                                    .clipped()
                                    .cornerRadius(50)
                                    .padding(.trailing, 16)
                                
                                VStack(alignment: .leading){
                                    Text("\(profile.name!) \(profile.surname!)")
                                        .bold()
                                        .lineLimit(1)
                                        .font(.system(size: 20))
                                    
                                    if(profile.numberOfCards == 1){
                                        Text("\(profile.numberOfCards) card")
                                            .font(.system(size: 15))
                                            .lineLimit(1)
                                        
                                    }else{
                                        Text("\(profile.numberOfCards) cards")
                                            .font(.system(size: 15))
                                            .lineLimit(1)
                                        
                                    }
                                    
                                }.padding(.leading,10)
                            }
                        }
                        
                    }             //COMMENT TO SEE THE ALTERNATIVE
                }
                .onDelete(perform: deleteItems)
            }
                .listStyle(.insetGrouped)
                .navigationTitle("Profiles")
                .toolbar{
                    ToolbarItem{
                        Button{
                            
                            showingSheet.toggle()
                            
                        }label: {
                            Label("Add Item", systemImage: "plus")
                        }
                        .sheet(isPresented: $showingSheet) {
                            SheetViewProfile()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
            }
            //.padding(.top, 28)
            .frame(maxWidth: .infinity)
            
        }
        
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { profilesArr[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

extension UIImage {
    func toPngString() -> String? {
        let data = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
    
    func toJpegString(compressionQuality cq: CGFloat) -> String? {
        let data = self.jpegData(compressionQuality: cq)
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

