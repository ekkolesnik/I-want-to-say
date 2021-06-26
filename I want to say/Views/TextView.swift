//
//  TextView.swift
//  I want to say
//
//  Created by Evgeny Kolesnik on 14.06.2021.
//

import SwiftUI

struct SettingsListCardTitleTextView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.title2)
            .foregroundColor(.white)
            .bold()
    }
}

struct CategoryTitleTextView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .bold()
            .font(.largeTitle)
            .foregroundColor(.white)
            .opacity(0.8)
    }
}

struct CategoryCardTitleTextView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
    }
}

struct SaveButtonTextView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.title)
            .foregroundColor(.white)
            .bold()
            .opacity(0.8)
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.001840596669, green: 0.8078940511, blue: 0.9998741746, alpha: 1)), Color(#colorLiteral(red: 0.007844023407, green: 5.293237791e-06, blue: 0.1411535442, alpha: 1))]), center: .center, startRadius: 50, endRadius: 700)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                CategoryTitleTextView(text: "Название")
                SettingsListCardTitleTextView(text: "Название")
                CategoryCardTitleTextView(text: "Название")
                SaveButtonTextView(text: "Сохранить")
            }
        }
        
    }
}
