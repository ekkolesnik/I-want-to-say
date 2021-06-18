//
//  AddCardView.swift
//  I want to say
//
//  Created by Evgeny Kolesnik on 16.06.2021.
//

import SwiftUI

struct AddCardView: View {
    
    @State private var image: Image?
    @State private var title = ""
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
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
                    .padding(.horizontal, 16)
                    
                    CategoryTitleTextView(text: "Добавление")
                }
                .padding(.bottom, 20)
                
                ZStack {
                    Color.white
                        .opacity(0.3)
                        .frame(width: 300, height: 300)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFill()
                            .frame(width: 290, height: 290)
                            .clipped()
                            .cornerRadius(10)
                    } else {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 90))
                            .foregroundColor(.white)
                            .opacity(0.8)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                .padding(.bottom, 20)
                
                HStack {
                    Text("Введите название")
                        .font(.title3)
                        .foregroundColor(.white)
                        .bold()
                    
                    Spacer()
                }
                .padding(.horizontal, 30)
                
                TextField("Название картинки", text: $title)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                
                Button(action: {
                    print("test")
                }, label: {
                    ZStack {
                        Color.white
                            .opacity(0.3)
                            .frame(width: 300, height: 60)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        
                        Text("Сохранить")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .opacity(0.8)
                    }
                })
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage, content: {
            ImagePicker(image: self.$inputImage)
        })
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct AddCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardView()
    }
}