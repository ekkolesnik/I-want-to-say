//
//  AddCardView.swift
//  I want to say
//
//  Created by Evgeny Kolesnik on 16.06.2021.
//

import SwiftUI

struct AddCardView: View {
    var category: String
    
    @StateObject var vm = FileManagerViewModel()
    
    @State private var image: Image?
    @State private var title = ""
    
    @State private var value: CGFloat = 0
    
    @State private var changeAction = false
    @State private var showingAlert = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var resizedImage: UIImage?
    
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
                .padding()
                
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
                    if changeAction == false || title == "" {
                        showingAlert = true
                    } else {
                        if category == "want" {
                            vm.saveImage(image: inputImage, name: title)
                        } else if category == "food" {
                            vm.saveImageFoodCategory(image: inputImage, name: title)
                        } else if category == "hood" {
                            vm.saveImageHoodCategory(image: inputImage, name: title)
                        } else {
                            vm.saveImageGeneralCategory(image: inputImage, name: title)
                        }
                        
                        presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                    ZStack {
                        Color.white
                            .opacity(0.3)
                            .frame(width: 300, height: 60)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        
                        SaveButtonTextView(text: "Сохранить")
                    }
                })
                .alert(isPresented: $showingAlert, content: {
                    Alert(title: Text("Ошибка"), message: Text("Не выбрана картинка, либо не введено название"), dismissButton: .default(Text("OK")))
                })
                
                Spacer()
            }
            .offset(y: -self.value)
            .animation(.spring())
            .onAppear(perform: {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                    
                    self.value = 100
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                    
                    self.value = 0
                }
            })
            
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage, content: {
            ImagePicker(image: self.$inputImage)
        })
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        changeAction = true
    }
}

struct AddCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardView(category: "want")
    }
}
