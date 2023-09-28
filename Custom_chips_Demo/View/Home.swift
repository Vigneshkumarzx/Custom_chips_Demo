//
//  Home.swift
//  Custom_chips_Demo
//
//  Created by vignesh kumar c on 28/09/23.
//

import SwiftUI

struct Home: View {
    @State var selectText: String = ""
    
    @State var tags: [Tag] = []
    @State var ShowAlret: Bool = false
    
    var body: some View {
        
        VStack {
            Text("Filter \nMenus")
                .font(.system(size: 35, weight: .bold, design: .default))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TagView(maxLimit: 150, tags: $tags)
                .frame(height: 280)
                .padding(.top, 20)
            
            TextField("apple", text: $selectText)
                .font(.title3)
                .padding(.vertical, 15)
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 10).stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
                .environment(\.colorScheme, .dark)
                .padding(.vertical, 20)
            
            Button {
                
                addText(tags: tags, text: selectText, fontSize: 16, maxLimit: 150) { alert, tag in
                    if alert {
                        ShowAlret.toggle()
                    } else {
                        tags.append(tag)
                        selectText = ""
                    }
                }
                
            } label: {
                Text("Add tag")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("bg"))
                    .padding(.vertical, 12)
                    .padding(.horizontal, 14)
                    .background(Color("tag"))
                    .cornerRadius(10)
            }

            .disabled(selectText == "")
            .opacity(selectText == "" ? 0.6 : 1)
        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background((Color("bg")).ignoresSafeArea())
        .alert(isPresented: $ShowAlret) {
            Alert(title: Text("Error"), message: Text("Tag Limit Exceed try to delete some tags"), dismissButton: .destructive(Text("Okay")))
        }
    }
}

#Preview {
    Home()
}
