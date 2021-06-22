//
//  ContentView.swift
//  I want to say
//
//  Created by Evgeny Kolesnik on 13.06.2021.
//

import SwiftUI

struct CategorySelectionView: View {
    
    var body: some View {
        
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.001840596669, green: 0.8078940511, blue: 0.9998741746, alpha: 1)), Color(#colorLiteral(red: 0.007844023407, green: 5.293237791e-06, blue: 0.1411535442, alpha: 1))]), center: .center, startRadius: 50, endRadius: 700)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        NavigationLink(
                            destination: WantCategoryView(),
                            label: {
                                ZStack {
                                    Color.white
                                        .opacity(0.3)
                                        .frame(width: 150, height: 160)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                    
                                    CategoryTitleTextView(text: "Хочу")
                                }
                                .padding(5)
                            })
                        
                        NavigationLink(
                            destination: HoodCategoryView(),
                            label: {
                                ZStack {
                                    Color.white
                                        .opacity(0.3)
                                        .frame(width: 150, height: 160)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                    
                                    CategoryTitleTextView(text: "Болит")
                                }
                                .padding(5)
                            })
                    }
                    
                    HStack {
                        NavigationLink(
                            destination: FoodCategoryView(),
                            label: {
                                ZStack {
                                    Color.white
                                        .opacity(0.3)
                                        .frame(width: 150, height: 160)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                    
                                    VStack(spacing: 7) {
                                        Image("0")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 140, height: 150)
                                            .clipped()
                                            .cornerRadius(10)
                                    }
                                    .frame(width: 150, height: 160)
                                    
                                }
                                .padding(5)
                            })
                        
                        NavigationLink(
                            destination: GeneralCategoryView(),
                            label: {
                                ZStack {
                                    Color.white
                                        .opacity(0.3)
                                        .frame(width: 150, height: 160)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                    
                                    CategoryTitleTextView(text: "Общее")
                                }
                                .padding(5)
                            })
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CategorySelectionView()
    }
}
