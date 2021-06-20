//
//  WantCategoryView.swift
//  I want to say
//
//  Created by Evgeny Kolesnik on 14.06.2021.
//

import SwiftUI

struct WantCategoryView: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var cardArray = [WantCategoryCard]()
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.001840596669, green: 0.8078940511, blue: 0.9998741746, alpha: 1)), Color(#colorLiteral(red: 0.007844023407, green: 5.293237791e-06, blue: 0.1411535442, alpha: 1))]), center: .center, startRadius: 50, endRadius: 700)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {
                        cardArray.removeAll()
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
                        .onAppear(perform: {
                            cardArray.removeAll()
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
                            BodyView(card: card)
                        }
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(10)
                        .frame(width: 110, height: 150)
                        
                        .shadow(radius: 5)
                    })
                }
                
                Spacer()
            }
            
        }
        .navigationBarHidden(true)
        .onAppear {
            checkArray()
        }
    }
    
    func checkArray() {
        
        let dataCards = UserDefaults.standard.object(forKey: "wantArray")
        
        if dataCards != nil {
            print("111")
            if let savedCardData = UserDefaults.standard.object(forKey: "wantArray") as? Data {
                if let savedUser = try? JSONDecoder().decode([WantCategoryCard].self, from: savedCardData) {
                    print(cardArray)
                    print(savedUser)
                    for i in savedUser {
                        cardArray.append(i)
                    }
                }
            }
        } else {
            print("222")
            let importArray = [
                WantCategoryCard(id: UUID(), title: "Гулять", image: "1"),
                WantCategoryCard(id: UUID(), title: "Купаться", image: "2"),
                WantCategoryCard(id: UUID(), title: "Есть", image: "3"),
                WantCategoryCard(id: UUID(), title: "Играть", image: "4")
            ]
            
            print(importArray)
            
            for i in importArray {
                cardArray.append(i)
                let image = UIImage(named: i.image)
                vm.saveImage(image: image, name: i.title)
            }
            
            if let encodeCard = try? JSONEncoder().encode(importArray) {
                UserDefaults.standard.set(encodeCard, forKey: "wantArray")
            }
        }
    }
}

struct WantCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        WantCategoryView()
    }
}

struct BodyView: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var card: WantCategoryCard
    
    var body: some View {
        VStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(5)
            }
            
            Text(card.title)
                .foregroundColor(.white)
        }
        .padding(5)
        .onAppear(perform: {
            vm.getImafeFromFileManager(name: card.title)
        })
    }
}
