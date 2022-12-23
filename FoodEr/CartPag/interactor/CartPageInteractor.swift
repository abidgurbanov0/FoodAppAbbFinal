//
//  CartPageInteractor.swift
//  FoodEr
//
//  Created by Abid Qurbanov on 14.12.2022.
//

import Foundation
import FirebaseAuth
import Alamofire
class CartPageInteractor:PresenterToInteractorCartPageProtocol{
    
    var cartPagePresenter: InteractorToPresenterCartPageProtocol?
    
    
    
    
    func changeCartFoodCountI(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:Int,sepet_yemek_id:Int ,yeniAdet:Int){
        let userInfo = Auth.auth().currentUser
        let email = userInfo?.email
       
        let param : Parameters = ["cartId":sepet_yemek_id,"userName":email!]
        AF.request("http://kasimadalan.pe.hu/foods/deleteFood.php", method: .post, parameters: param).response { response in
            if let data = response.data {
                do{
                   let answer = try JSONSerialization.jsonObject(with: data)
                    print(answer)
                    
                }catch{
                    print(error.localizedDescription)
                }
                
                
            }}
        
        
        
        
        
        
        
        
        addToCartI(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yeniAdet)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            self.getCartFoodI()
        }
       
        
    }
    
    func addToCartI(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:Int,yemek_siparis_adet:Int) {
        let userInfo = Auth.auth().currentUser
        let email = userInfo?.email

             let intAdet = yemek_siparis_adet
        let intFiyat = yemek_fiyat

                let params:Parameters = ["name":yemek_adi,"image":yemek_resim_adi,"price":intFiyat ,"category":"","orderAmount": intAdet,"userName":email!]
            
            AF.request("http://kasimadalan.pe.hu/foods/insertFood.php",method: .post,parameters: params).response { response in
                if let data = response.data {
                    do{
                        let cevap = try JSONSerialization.jsonObject(with: data)
                        print(cevap)
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
            
             }
    
    
    
    
    
    func getCartFoodI() {
        let userEmail = Auth.auth().currentUser?.email
        var totalPrice = 0
        var foodTotalPrice = 0
        let emptyAnswerArray : [FoodsCart] = []
        if let email = userEmail{
            
            
            let param : Parameters = ["userName":email]
            AF.request("http://kasimadalan.pe.hu/foods/getFoodsCart.php", method: .post, parameters: param).response { response in
                if let data = response.data {
                    
                    do {
                        let answer = try JSONDecoder().decode(FoodsCartResponse.self, from: data)
                        
                        if var answerArray = answer.foods_cart {
                            for food in answerArray{
                                foodTotalPrice = food.orderAmount! * food.price!
                                totalPrice += foodTotalPrice
                            }
                            answerArray.sort(by: { ($0.name!) < ($1.name!) })
                            
                                self.cartPagePresenter?.sendDataToPresenter(foodsCart: answerArray, totalPrice: totalPrice)
                            
                            
                        }
                        
                    } catch  {
                        self.cartPagePresenter?.sendDataToPresenter(foodsCart: emptyAnswerArray, totalPrice: 0)
                    }
                }
            }}
        
        
        
    }
    
    func deleteCartFoodI(sepet_yemek_id: Int, kullanici_adi: String) {
        if kullanici_adi ==  Auth.auth().currentUser?.email{
            let param : Parameters = ["cartId":sepet_yemek_id,"userName":kullanici_adi]
            AF.request("http://kasimadalan.pe.hu/foods/deleteFood.php", method: .post, parameters: param).response { response in
                if let data = response.data {
                    do{
                       let answer = try JSONSerialization.jsonObject(with: data)
                        print(answer)
                        
                        self.getCartFoodI()
                    }catch{
                        print(error.localizedDescription)
                    }
                    
                    
                }}
            
            
        }}
}
