//
//  SettingsWantCategoryView.swift
//  I want to say
//
//  Created by Evgeny Kolesnik on 15.06.2021.
//

import SwiftUI

struct SettingsWantCategoryView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var cardArray = [
        WantCategoryCard(title: "Гулять", image: "1"),
        WantCategoryCard(title: "Купаться", image: "2"),
        WantCategoryCard(title: "Есть", image: "3"),
        WantCategoryCard(title: "Играть", image: "4")
    ]
    
    init() {
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
    }
    
    func deleteRow(at indexSet: IndexSet) {
            self.cardArray.remove(atOffsets: indexSet)
        }
    
    var body: some View {
        NavigationView {
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
                                destination: AddCardView(),
                                label: {
                                    Image(systemName: "plus")
                                        .foregroundColor(.gray)
                                        .font(.title)
                                })
                        }
                        .padding(.horizontal, 16)
                        
                        CategoryTitleTextView(text: "Хочу")
                    }
                    
                    List {
                        ForEach(cardArray, id: \.self) { card in
                            NavigationLink(
                                destination: EmptyView(),
                                label: {
                                    HStack {
                                        ZStack {
                                            Color.white
                                                .opacity(0.3)
                                                .frame(width: 100, height: 100)
                                                .cornerRadius(10)
                                                .shadow(radius: 5)
                                            
                                            Image(card.image)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 90, height: 90)
                                                .clipped()
                                                .cornerRadius(10)
                                        }
                                        .padding(.trailing, 20)
                                        
                                        Text(card.title)
                                            .font(.title2)
                                            .foregroundColor(.white)
                                            .bold()
                                        
                                        Spacer()
                                    }
                                    
                                })
                        }
                        .onDelete(perform: self.deleteRow)
                        .listRowBackground(Color.clear)
                    }
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct SettingsWantCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsWantCategoryView()
    }
}
