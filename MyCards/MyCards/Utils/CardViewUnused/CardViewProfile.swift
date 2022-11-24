//
//  CardViewProfile.swift
//  test
//
//  Created by Valerio Mosca on 16/11/22.
//

import SwiftUI
import Foundation

struct CardP {
    //let imageProfile: String
    let name: String
    let surname: String
    let fiscalCode: String
    //let cardCounter: Int
    
    init(name: String, surname: String, fiscalCode: String) {
        self.name = name
        self.surname = surname
        self.fiscalCode = fiscalCode
    }
}

struct CardViewProfile: View {
    
    let card: CardP
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 24, style: .continuous).fill(.white)
                .shadow(radius: 10)
            
            HStack(alignment: .center){
                
                Image("persofill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70.0,height: 70.0)
                    .clipped()
                    .cornerRadius(50)
                    .padding(.leading, 14)
                
                VStack(alignment: .leading, spacing: 5){
                    HStack{
                        
                        Text(card.name)
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .lineLimit(2)
                            .bold()
                        Text(card.surname)
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .lineLimit(2)
                            .bold()
                        //numero carte
                    }
                            
//                        if(card.cardCounter > 1){
//                            Text("\(card.cardCounter) cards").font(.system(size: 14)).foregroundColor(Color.black)
//                        }else{
//                            Text("\(card.cardCounter) card").font(.system(size: 14)).foregroundColor(Color.black)
//                        }
                    
                }
                .padding(.leading, 10)
                Spacer()
                
            }
            .padding(.trailing,114)
        }
        .frame(width: 353, height: 94)
    }
}



struct CardViewProfile_Previews: PreviewProvider {
    static var previews: some View {
        CardViewProfile(card: CardP(name: "ahahah", surname: "ahahah", fiscalCode: ""))
    }
}
