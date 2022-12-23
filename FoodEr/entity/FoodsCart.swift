//
//  FoodsCart.swift
//  FoodEr
//
//  Created by Abid Qurbanov on 14.12.2022.
//

import Foundation
class FoodsCart : Codable{
    var cartId: Int?
    var name: String?
    var image: String?
    var price: Int?
    var category: String?
    var orderAmount: Int?
    var userName: String?
    
    init(){
        
    }
    
    init(sepet_yemek_id: Int, yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String){
        self.cartId = sepet_yemek_id
        self.name = yemek_adi
        self.image = yemek_resim_adi
        self.price = yemek_fiyat
        self.orderAmount = yemek_siparis_adet
        self.userName = kullanici_adi
        
    }
}
