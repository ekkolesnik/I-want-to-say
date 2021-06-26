//
//  GeneralCategoryView.swift
//  I want to say
//
//  Created by Evgeny Kolesnik on 14.06.2021.
//

import SwiftUI
import AVFoundation

struct GeneralCategoryView: View {
    
    let synthesizer = AVSpeechSynthesizer()
    
    @StateObject var vm = FileManagerViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var cardArray = [GeneralCategoryCard]()
    @State private var settingsToggle = false
    
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
                            destination: SettingsGeneralCategoryView(),
                            isActive: $settingsToggle,
                            label: {
                                Button(action: {
                                    cardArray.removeAll()
                                    settingsToggle.toggle()
                                }, label: {
                                    Image(systemName: "gearshape")
                                        .foregroundColor(.gray)
                                        .font(.title)
                                })
                            })
                    }
                    .padding()
                    
                    CategoryTitleTextView(text: "Общее")
                }
                
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
                                GeneralCategoryBodyView(card: card)
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
        
        let dataCards = UserDefaults.standard.object(forKey: "generalArray")
        
        if dataCards != nil {
            if let savedCardData = UserDefaults.standard.object(forKey: "generalArray") as? Data {
                if let savedCard = try? JSONDecoder().decode([GeneralCategoryCard].self, from: savedCardData) {
                    for i in savedCard {
                        cardArray.append(i)
                    }
                }
            }
        } else {
            let importArray = [
                GeneralCategoryCard(id: UUID(), title: "да", image: "да"),
                GeneralCategoryCard(id: UUID(), title: "нет", image: "нет")
            ]
            
            for i in importArray {
                cardArray.append(i)
                let image = UIImage(named: i.image)
                vm.saveImageGeneralCategory(image: image, name: i.title)
            }
            
            if let encodeCard = try? JSONEncoder().encode(importArray) {
                UserDefaults.standard.set(encodeCard, forKey: "generalArray")
            }
        }
    }
}

struct GeneralCategoryBodyView: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var card: GeneralCategoryCard
    
    var body: some View {
        VStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(5)
            }
            
            CategoryCardTitleTextView(text: card.title)
        }
        .padding(5)
        .onAppear(perform: {
            vm.getImafeFromFileManager(name: card.title)
        })
    }
}

struct GeneralCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralCategoryView()
    }
}
