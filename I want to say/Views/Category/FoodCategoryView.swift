//
//  FoodCategoryView.swift
//  I want to say
//
//  Created by Evgeny Kolesnik on 14.06.2021.
//

import SwiftUI
import AVFoundation

struct FoodCategoryView: View {
    
    let synthesizer = AVSpeechSynthesizer()
    
    @StateObject var vm = FileManagerViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var cardArray = [FoodCategoryCard]()
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.001840596669, green: 0.8078940511, blue: 0.9998741746, alpha: 1)), Color(#colorLiteral(red: 0.007844023407, green: 5.293237791e-06, blue: 0.1411535442, alpha: 1))]), center: .center, startRadius: 50, endRadius: 700)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack {
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
                            destination: SettingsFoodCategoryView(),
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
                    
                    CategoryTitleTextView(text: "Еда")
                }
                
                Button(action: {
                    let utterance = AVSpeechUtterance(string: "Я хочу")
                    utterance.voice = AVSpeechSynthesisVoice(language: "ru-RU")
                    utterance.rate = 0.4

                    synthesizer.speak(utterance)
                }, label: {
                    ZStack {
                        Color.white
                            .opacity(0.3)
                            .frame(width: 200, height: 100)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        
                        CategoryTitleTextView(text: "Я хочу")
                    }
                })
                
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
                            Button(action: {
                                let utterance = AVSpeechUtterance(string: card.title)
                                utterance.voice = AVSpeechSynthesisVoice(language: "ru-RU")
                                utterance.rate = 0.4

                                synthesizer.speak(utterance)
                            }, label: {
                                FoodCategoryBodyView(card: card)
                            })
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
        
        let dataCards = UserDefaults.standard.object(forKey: "foodArray")
        
        if dataCards != nil {
            print("111")
            if let savedCardData = UserDefaults.standard.object(forKey: "foodArray") as? Data {
                if let savedCard = try? JSONDecoder().decode([FoodCategoryCard].self, from: savedCardData) {
                    print(cardArray)
                    print(savedCard)
                    for i in savedCard {
                        cardArray.append(i)
                    }
                }
            }
        } else {
            print("222")
            let importArray = [
                FoodCategoryCard(id: UUID(), title: "Суп", image: "Суп")
            ]
            
            print(importArray)
            
            for i in importArray {
                cardArray.append(i)
                let image = UIImage(named: i.image)
                vm.saveImageFoodCategory(image: image, name: i.title)
            }
            
            if let encodeCard = try? JSONEncoder().encode(importArray) {
                UserDefaults.standard.set(encodeCard, forKey: "foodArray")
            }
        }
    }
}

struct FoodCategoryBodyView: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var card: FoodCategoryCard
    
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

struct FoodCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        FoodCategoryView()
    }
}
