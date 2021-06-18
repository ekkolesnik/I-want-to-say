//
//  WantCategoryView.swift
//  I want to say
//
//  Created by Evgeny Kolesnik on 14.06.2021.
//

import SwiftUI

struct WantCategoryView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var cardArray = [
        WantCategoryCard(title: "Гулять", image: "1"),
        WantCategoryCard(title: "Купаться", image: "2"),
        WantCategoryCard(title: "Есть", image: "3"),
        WantCategoryCard(title: "Играть", image: "4")
    ]
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.001840596669, green: 0.8078940511, blue: 0.9998741746, alpha: 1)), Color(#colorLiteral(red: 0.007844023407, green: 5.293237791e-06, blue: 0.1411535442, alpha: 1))]), center: .center, startRadius: 50, endRadius: 700)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.gray)
                            .font(.title)
                    })
                    Spacer()
                    NavigationLink(
                        destination: SettingsView(),
                        label: {
                            Image(systemName: "gearshape")
                                .foregroundColor(.gray)
                                .font(.title)
                        })
                }
                .padding()
                
                ZStack {
                    Color.white
                        .opacity(0.3)
                        .frame(width: 200, height: 100)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    
                    CategoryTitleTextView(text: "Я хочу")
                }
                
                Color.white
                    .frame(width: 300, height: 2)
                    .opacity(0.3)
                    .padding()
                
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.fixed(110)),
                        GridItem(.fixed(110)),
                        GridItem(.fixed(110))
                    ], alignment: .center, spacing: nil, content: {
                        ForEach(cardArray, id: \.self) { card in
                            VStack {
                                Image(card.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(5)
                                
                                Text(card.title)
                                    .foregroundColor(.white)
                            }
                            .padding(5)
                        }
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(10)
                        .frame(width: 110, height: 150)
                        
                        .shadow(radius: 5)
                    })
                }
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

struct WantCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        WantCategoryView()
    }
}
