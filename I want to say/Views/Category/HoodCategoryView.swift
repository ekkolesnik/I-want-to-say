//
//  HoodCategoryView.swift
//  I want to say
//
//  Created by Evgeny Kolesnik on 14.06.2021.
//

import SwiftUI
import AVFoundation

struct HoodCategoryView: View {
    
    let synthesizer = AVSpeechSynthesizer()
    
    @StateObject var vm = FileManagerViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var cardArray = [HoodCategoryCard]()
    @State private var settingsToggle = false
    
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
                            destination: SettingsHoodCategoryView(),
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
                
                Button(action: {
                    let utterance = AVSpeechUtterance(string: "У меня болит")
                    utterance.voice = AVSpeechSynthesisVoice(language: "ru-RU")
                    utterance.rate = 0.4

                    synthesizer.speak(utterance)
                }, label: {
                    ZStack {
                        Color.white
                            .opacity(0.3)
                            .frame(width: 300, height: 100)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        
                        CategoryTitleTextView(text: "У меня болит")
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
                                HoodCategoryBodyView(card: card)
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
        
        let dataCards = UserDefaults.standard.object(forKey: "hoodArray")
        
        if dataCards != nil {
            if let savedCardData = UserDefaults.standard.object(forKey: "hoodArray") as? Data {
                if let savedCard = try? JSONDecoder().decode([HoodCategoryCard].self, from: savedCardData) {
                    for i in savedCard {
                        cardArray.append(i)
                    }
                }
            }
        } else {
            let importArray = [
                HoodCategoryCard(id: UUID(), title: "рука", image: "рука")
            ]
            
            for i in importArray {
                cardArray.append(i)
                let image = UIImage(named: i.image)
                vm.saveImageHoodCategory(image: image, name: i.title)
            }
            
            if let encodeCard = try? JSONEncoder().encode(importArray) {
                UserDefaults.standard.set(encodeCard, forKey: "hoodArray")
            }
        }
    }
}

struct HoodCategoryBodyView: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var card: HoodCategoryCard
    
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

struct HoodCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        HoodCategoryView()
    }
}
