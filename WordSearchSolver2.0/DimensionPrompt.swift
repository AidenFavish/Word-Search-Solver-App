//
//  DimensionPrompt.swift
//  WordSearchSolver2.0
//
//  Created by Aiden Favish on 1/1/23.
//

import SwiftUI

struct DimensionPrompt: View {
    @State var width = ""
    @State var height = ""
    
    func simpleSuccess() {
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
        impactMed.impactOccurred()
    }
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .frame(height: 50)
                    .foregroundColor(.gray)
                    .opacity(0.30)
                
                HStack {
                    Text("Width:")
                    Spacer()
                    TextField("Enter # of characters", text: $width)
                        .keyboardType(.numberPad)
                        .onTapGesture(perform: simpleSuccess)
                    
                } .padding(.horizontal)
                
            }.padding()
            .padding(.horizontal)
            .padding(.top)
            
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .frame(height: 50)
                    .foregroundColor(.gray)
                    .opacity(0.30)
                
                HStack {
                    Text("Height:")
                    Spacer()
                    TextField("Enter # of characters", text: $height)
                        .keyboardType(.numberPad)
                        .onTapGesture(perform: simpleSuccess)
                    
                } .padding(.horizontal)
                
            }.padding()
            .padding(.horizontal)
            
            NavigationLink(destination: SearchScanner(width: Int(width) ?? 1, height: Int(height) ?? 1)) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 125, height: 40)
                        .foregroundColor(.blue)
                    Text("Confirm")
                        .foregroundColor(.white)
                }
            }.padding()
            
            Spacer()
            
        }.navigationTitle("Enter Dimensions")
    }
}

struct DimensionPrompt_Previews: PreviewProvider {
    static var previews: some View {
        DimensionPrompt()
    }
}
