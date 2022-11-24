//
//  DocumentDetails.swift
//  MyCards
//
//  Created by Valerio Mosca on 23/11/22.
//

import SwiftUI

struct CardDetails: View {
    var selectedCard: Document
    var body: some View {
            VStack{
                HStack{
                    let rearUImg = Image(uiImage: UIImage(data: selectedCard.rearImage ?? Data()) ?? UIImage())
                    let frontUImg = Image(uiImage: UIImage(data: selectedCard.frontImage ?? Data()) ?? UIImage())
                    Spacer()
                    
                    rearUImg
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 168.0,height: 106.0)
                        .clipped()
                        .cornerRadius(16)
                    Spacer()
                    frontUImg
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 168.0,height: 106.0)
                        .clipped()
                        .cornerRadius(16)
                    
                    Spacer()
                }.padding(.top,28)
                List{
                    Section{
                        Text(selectedCard.cardType!)
                            .bold().font(.system(size: 17))
                        Text("Card Number: \(selectedCard.cardNumber!)")
                            .font(.system(size: 13))
                        
                        Text("Expiry Date: \(selectedCard.expiryDate!, formatter: itemFormatter)")
                            .font(.system(size: 13))
                        
                    }
                    
                }.listStyle(.insetGrouped)
                    .navigationTitle("\(selectedCard.cardType!)")
                Spacer()
            }.background(Color("cardDetail"))
            .frame(maxWidth: .infinity)
        
    }
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
}

struct CardDetails_Previews: PreviewProvider {
    static var previews: some View {
        CardDetails(selectedCard: Document())
    }
}
