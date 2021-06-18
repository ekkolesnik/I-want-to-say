//
//  SettingsView.swift
//  I want to say
//
//  Created by Evgeny Kolesnik on 15.06.2021.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
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
                    }
                    
                    CategoryTitleTextView(text: "Настройки")
                }
                .padding(.bottom, 10)
                
                Text("Выберите категорию для \nдобавления/удаления фотографий")
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(.bottom, 15)
                
                NavigationLink(
                    destination: SettingsWantCategoryView(),
                    label: {
                        ZStack {
                            Color.white
                                .opacity(0.3)
                                .frame(width: 300, height: 100)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            
                            CategoryTitleTextView(text: "Хочу")
                        }
                    })
                    .padding(.bottom, 10)
                
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        ZStack {
                            Color.white
                                .opacity(0.3)
                                .frame(width: 300, height: 100)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            
                            CategoryTitleTextView(text: "Болит")
                        }
                    })
                    .padding(.bottom, 10)
                
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        ZStack {
                            Color.white
                                .opacity(0.3)
                                .frame(width: 300, height: 100)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            
                            CategoryTitleTextView(text: "Еда")
                        }
                    })
                    .padding(.bottom, 10)
                
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        ZStack {
                            Color.white
                                .opacity(0.3)
                                .frame(width: 300, height: 100)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            
                            CategoryTitleTextView(text: "Общее")
                        }
                    })
                
                Spacer()
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
