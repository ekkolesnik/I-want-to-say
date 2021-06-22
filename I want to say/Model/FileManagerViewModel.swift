//
//  FileManagerViewModel.swift
//  I want to say
//
//  Created by Evgeny Kolesnik on 21.06.2021.
//

import Foundation
import SwiftUI

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let manager = LocalFileManager.instance
    
    func saveImage(image: UIImage?, name: String) {
        guard let image = image else { return }
        manager.saveImage(image: image, name: name)
        
        //Получаем массив из UserDefaults и записываем в него новое значение, после чего записываем новый массив в UserDefaults
        var cardArray = [WantCategoryCard]()
        //Получение
        if let savedCardData = UserDefaults.standard.object(forKey: "wantArray") as? Data {
            if let savedCard = try? JSONDecoder().decode([WantCategoryCard].self, from: savedCardData) {
                for i in savedCard {
                    cardArray.append(i)
                }

                //Запись нового значения в массив
                let newCard = WantCategoryCard(id: UUID(), title: name, image: name)
                cardArray.append(newCard)
                
                //Запись обнавлённого массива в UserDefaults
                if let encodeCard = try? JSONEncoder().encode(cardArray) {
                    UserDefaults.standard.set(encodeCard, forKey: "wantArray")
                }
                
                print(cardArray)
            }
        }
    }
    
    func saveImageFoodCategory(image: UIImage?, name: String) {
        guard let image = image else { return }
        manager.saveImage(image: image, name: name)
        
        //Получаем массив из UserDefaults и записываем в него новое значение, после чего записываем новый массив в UserDefaults
        var cardArray = [FoodCategoryCard]()
        //Получение
        if let savedCardData = UserDefaults.standard.object(forKey: "foodArray") as? Data {
            if let savedCard = try? JSONDecoder().decode([FoodCategoryCard].self, from: savedCardData) {
                for i in savedCard {
                    cardArray.append(i)
                }

                //Запись нового значения в массив
                let newCard = FoodCategoryCard(id: UUID(), title: name, image: name)
                cardArray.append(newCard)
                
                //Запись обнавлённого массива в UserDefaults
                if let encodeCard = try? JSONEncoder().encode(cardArray) {
                    UserDefaults.standard.set(encodeCard, forKey: "foodArray")
                }
                
                print(cardArray)
            }
        }
    }
    
    func saveImageHoodCategory(image: UIImage?, name: String) {
        guard let image = image else { return }
        manager.saveImage(image: image, name: name)
        
        //Получаем массив из UserDefaults и записываем в него новое значение, после чего записываем новый массив в UserDefaults
        var cardArray = [HoodCategoryCard]()
        //Получение
        if let savedCardData = UserDefaults.standard.object(forKey: "hoodArray") as? Data {
            if let savedCard = try? JSONDecoder().decode([HoodCategoryCard].self, from: savedCardData) {
                for i in savedCard {
                    cardArray.append(i)
                }

                //Запись нового значения в массив
                let newCard = HoodCategoryCard(id: UUID(), title: name, image: name)
                cardArray.append(newCard)
                
                //Запись обнавлённого массива в UserDefaults
                if let encodeCard = try? JSONEncoder().encode(cardArray) {
                    UserDefaults.standard.set(encodeCard, forKey: "hoodArray")
                }
                
                print(cardArray)
            }
        }
    }
    
    func deleteImage(name: String) {
        manager.deleteImage(name: name)
    }
    
    func getImafeFromFileManager(name: String) {
        image = manager.getImage(name: name)
    }
}
