//
//  SettingsGeneralCategoryView.swift
//  I want to say
//
//  Created by Evgeny Kolesnik on 22.06.2021.
//

import SwiftUI

struct SettingsGeneralCategoryView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var vm = FileManagerViewModel()
    
    @State private var cardArray = [GeneralCategoryCard]()
    
    init() {
        //прозрачный фон листинга
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.001840596669, green: 0.8078940511, blue: 0.9998741746, alpha: 1)), Color(#colorLiteral(red: 0.007844023407, green: 5.293237791e-06, blue: 0.1411535442, alpha: 1))]), center: .center, startRadius: 50, endRadius: 700)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack {
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
                            destination: AddCardView(category: "general"),
                            label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.gray)
                                    .font(.title)
                            })
                            .onAppear(perform: {
                                cardArray.removeAll()
                            })
                    }
                    .padding(.horizontal, 16)
                    
                    CategoryTitleTextView(text: "Общее")
                }
                .padding()
                
                List {
                    ForEach(cardArray, id: \.self) { card in
                        NavigationLink(
                            destination: EditCardView(cardId: card.id, categoryCard: "general", titleName: card.title, imageName: card.image),
                            label: {
                                SettingsGeneralBodyView(card: card)
                                
                            })
                    }
                    .onDelete(perform: self.deleteRow)
                    .listRowBackground(Color.clear)
                }
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
        .onAppear(perform: {
            DispatchQueue.main.async {
                getArray()
            }
        })
    }
    
    func deleteRow(at indexSet: IndexSet) {
        
        //удаление фотографии из дирректории
        let index = indexSet[indexSet.startIndex]
        let cardImageName = cardArray[index].title
        vm.deleteImage(name: cardImageName)
        
        //удаление записи из массива
        self.cardArray.remove(atOffsets: indexSet)
        
        //запись нового массива после удаления элемента
        if let encodeCard = try? JSONEncoder().encode(cardArray) {
            UserDefaults.standard.set(encodeCard, forKey: "generalArray")
        }
    }
    
    //получаем массив из UserDefaults
    func getArray() {
        if let savedCardData = UserDefaults.standard.object(forKey: "generalArray") as? Data {
            if let savedCard = try? JSONDecoder().decode([GeneralCategoryCard].self, from: savedCardData) {
                for i in savedCard {
                    cardArray.append(i)
                }
            }
        }
    }
}

struct SettingsGeneralBodyView: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    let card: GeneralCategoryCard
    
    var body: some View {
        
        HStack {
            ZStack {
                Color.white
                    .opacity(0.3)
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 90, height: 90)
                        .clipped()
                        .cornerRadius(10)
                }
            }
            .padding(.trailing, 20)
            .onAppear(perform: {
                vm.getImafeFromFileManager(name: card.title)
            })
            
            SettingsListCardTitleTextView(text: card.title)
            
            Spacer()
        }
    }
}

struct SettingsGeneralCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsGeneralCategoryView()
    }
}
