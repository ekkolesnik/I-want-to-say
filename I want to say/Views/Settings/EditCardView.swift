//
//  EditCardView.swift
//  I want to say
//
//  Created by Evgeny Kolesnik on 23.06.2021.
//

import SwiftUI

struct EditCardView: View {
    
    var cardId: UUID
    var categoryCard: String
    var titleName: String
    var imageName: String
    
    @State private var value: CGFloat = 0
    
    @StateObject var vm = FileManagerViewModel()
    
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
                    
                    CategoryTitleTextView(text: "Изменение")
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
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                .padding(.bottom, 20)
                .onAppear(perform: {
                    vm.getImafeFromFileManager(name: titleName)
                    inputImage = vm.image  //Нужно или нет
                    guard let image = vm.image else { return }
                    self.image = Image(uiImage: image)
                })
                
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
                    .onAppear(perform: {
                        title = titleName
                    })
                
                Button(action: {
                    
                        //удаление фото из дирректории
                        DispatchQueue.main.async {
                            vm.deleteImage(name: titleName)
                        }
                        
                        if categoryCard == "want" {
                            
                            var cardsArray = [WantCategoryCard]()
                            var newCardArray = [WantCategoryCard]()
                            
                            
                            // добавить функцию получение текущего массива и удаления из него записи
                            if let savedCardData = UserDefaults.standard.object(forKey: "wantArray") as? Data {
                                if let savedUser = try? JSONDecoder().decode([WantCategoryCard].self, from: savedCardData) {
                                    for i in savedUser {
                                        cardsArray.append(i)
                                    }
                                }
                            }
                            
                            for i in cardsArray {
                                if i.id != cardId {
                                    newCardArray.append(i)
                                }
                            }
                            
                            vm.saveEditImage(image: inputImage, name: title)
                            
                            // добавления новой записи в массив с записью в UserDefaults
                            let newWantCategoryCard = WantCategoryCard(id: UUID(), title: title, image: title)
                            newCardArray.append(newWantCategoryCard)

                            if let encodeCard = try? JSONEncoder().encode(newCardArray) {
                                UserDefaults.standard.set(encodeCard, forKey: "wantArray")
                            }
                            
                        } else if categoryCard == "food" {
                            
                            var cardArray = [FoodCategoryCard]()
                            var newCardArray = [FoodCategoryCard]()
                            
                            // добавить функцию получение текущего массива и удаления из него записи
                            if let savedCardData = UserDefaults.standard.object(forKey: "foodArray") as? Data {
                                if let savedUser = try? JSONDecoder().decode([FoodCategoryCard].self, from: savedCardData) {
                                    for i in savedUser {
                                        cardArray.append(i)
                                    }
                                }
                            }
                            
                            for i in cardArray {
                                if i.id != cardId {
                                    newCardArray.append(i)
                                }
                            }
                            
                            vm.saveEditImage(image: inputImage, name: title)
                            
                            // добавления новой записи в массив с записью в базу
                            let newFoodCategoryCard = FoodCategoryCard(id: UUID(), title: title, image: title)
                            newCardArray.append(newFoodCategoryCard)
                            
                            if let encodeCard = try? JSONEncoder().encode(newCardArray) {
                                UserDefaults.standard.set(encodeCard, forKey: "foodArray")
                            }
                            
                        } else if categoryCard == "hood" {
                            
                            var cardArray = [HoodCategoryCard]()
                            var newCardArray = [HoodCategoryCard]()
                            
                            // добавить функцию получение текущего массива и удаления из него записи
                            if let savedCardData = UserDefaults.standard.object(forKey: "hoodArray") as? Data {
                                if let savedUser = try? JSONDecoder().decode([HoodCategoryCard].self, from: savedCardData) {
                                    for i in savedUser {
                                        cardArray.append(i)
                                    }
                                }
                            }
                            
                            for i in cardArray {
                                if i.id != cardId {
                                    newCardArray.append(i)
                                }
                            }
                            
                            vm.saveEditImage(image: inputImage, name: title)
                            
                            // добавления новой записи в массив с записью в базу
                            let newHoodCategoryCard = HoodCategoryCard(id: UUID(), title: title, image: title)
                            newCardArray.append(newHoodCategoryCard)
                            
                            if let encodeCard = try? JSONEncoder().encode(newCardArray) {
                                UserDefaults.standard.set(encodeCard, forKey: "hoodArray")
                            }
                            
                        } else {
                            
                            var generalCardArray = [GeneralCategoryCard]()
                            var newCardArray = [GeneralCategoryCard]()
                            
                            // добавить функцию получение текущего массива и удаления из него записи
                            if let savedCardData = UserDefaults.standard.object(forKey: "generalArray") as? Data {
                                if let savedUser = try? JSONDecoder().decode([GeneralCategoryCard].self, from: savedCardData) {
                                    for i in savedUser {
                                        generalCardArray.append(i)
                                    }
                                }
                            }
                            
                            for i in generalCardArray {
                                if i.id != cardId {
                                    newCardArray.append(i)
                                }
                            }
                            
                            vm.saveEditImage(image: inputImage, name: title)
                            
                            // добавления новой записи в массив с записью в базу
                            let newGeneralCategoryCard = GeneralCategoryCard(id: UUID(), title: title, image: title)
                            newCardArray.append(newGeneralCategoryCard)
                            
                            if let encodeCard = try? JSONEncoder().encode(newCardArray) {
                                UserDefaults.standard.set(encodeCard, forKey: "generalArray")
                            }
                        }
                        presentationMode.wrappedValue.dismiss()
                    
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
    }
}

struct EditCardView_Previews: PreviewProvider {
    static var previews: some View {
        EditCardView(cardId: UUID(), categoryCard: "WantCategoryCard", titleName: "Гулять", imageName: "1")
    }
}
