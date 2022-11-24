//
//  CardViewDocument.swift
//  test
//
//  Created by Valerio Mosca on 17/11/22.
//

import SwiftUI

struct CardViewDocument: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 24, style: .continuous).fill(.white)
                .shadow(radius: 10)
            
            HStack(alignment: .center){
                
                Image("personfill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70.0,height: 70.0)
                    .clipped()
                    .cornerRadius(50)
                    .padding(.leading, 14)
                
                VStack(alignment: .leading, spacing: 5){
                    
                    Text("Identity Card")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .bold()
                        
                    
                    Text("Card Number:")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .bold()
                        .lineLimit(2)
                    
                    Text("Expiry Date:")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .bold()
                        .lineLimit(2)
                    
                    
                }
                .padding(.leading, 10)
                Spacer()
                
            }
            .padding(.trailing,114)
        }
        .frame(width: 353, height: 125)
    }
}



struct CardViewDocument_Previews: PreviewProvider {
    static var previews: some View {
        CardViewDocument()
    }
}
