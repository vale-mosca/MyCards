//
//  RelatedCards.swift
//  MyCards2
//
//  Created by Valerio Mosca on 19/11/22.
//

import SwiftUI

struct RelatedCards: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var selectedProfile : Profile
    
    @FetchRequest(
        sortDescriptors: []
    ) var documentsArr: FetchedResults<Document>
    
    var docs :[Document] {
        documentsArr
            .filter({ doc in
                //print(doc.hasAProfile?.id ?? Profile(), selectedProfile.id ?? Profile())
                return doc.hasAProfile?.id == selectedProfile.id
            })
    }
    
    @State private var showingSheet = false
    
    var body: some View {
        VStack(spacing: 10){
            List{
                ForEach(docs) { document in
                    Section{
                        NavigationLink{
                            CardDetails(selectedCard: document)
                        } label: {
                            HStack{
                                let convertedUImg = Image(uiImage: UIImage(data: selectedProfile.image ?? Data()) ?? UIImage())

                                convertedUImg
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50.0,height: 50.0)
                                    .clipped()
                                    .cornerRadius(50)
                                    .padding(.trailing, 16)

                                VStack(alignment: .leading){
                                    Text(document.cardType ?? "")
                                        .bold().font(.system(size: 17))
                                    Text("Card Number: \(document.cardNumber ?? "")")
                                        .font(.system(size: 13))

                                    Text("Expiry Date: \(document.expiryDate!, formatter: itemFormatter)")
                                        .font(.system(size: 13))

                                }
                            }
                        }

                    }
                }
                .onDelete(perform: deleteItems)

            }
            .listStyle(.insetGrouped)
            .navigationTitle("Cards")
            .toolbar{
                ToolbarItem{
                    Button{
                        showingSheet.toggle()

                    }label: {
                        Label("Add Item", systemImage: "plus")
                    }
                    .sheet(isPresented: $showingSheet) {
                        SheetViewDocuments(selectedProfile: selectedProfile)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }

            }
            .onAppear {
                print(docs)
            }
        }
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { docs[$0] }.forEach(viewContext.delete)

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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = "dd/MM/yyyy"
    return formatter
}()

struct RelatedCards_Previews: PreviewProvider {
    static var previews: some View {
        RelatedCards(selectedProfile: Profile())
    }
}
