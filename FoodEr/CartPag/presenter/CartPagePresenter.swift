//
//  CartPagePresenter.swift
//  FoodEr
//
//  Created by Abid Qurbanov on 14.12.2022.
//

import Foundation
class CartPagePresenter:ViewToPresenterCartPageProtocol,InteractorToPresenterCartPageProtocol{
    
     var cartPageInteractor: PresenterToInteractorCartPageProtocol?
     
     var cartPageView: PresenterToViewCartPageProtocol?
    
    func changeCartFoodCount(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:Int,sepet_yemek_id:Int ,yeniAdet:Int) {
        cartPageInteractor?.changeCartFoodCountI(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat,  sepet_yemek_id: sepet_yemek_id, yeniAdet: yeniAdet)
    }
    
   

    
    func getCartFood() {
        cartPageInteractor?.getCartFoodI()
    }
    
    func deleteCartFood(sepet_yemek_id: Int, kullanici_adi: String) {
        cartPageInteractor?.deleteCartFoodI(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
    
    func sendDataToPresenter(foodsCart: [FoodsCart], totalPrice: Int) {
        cartPageView?.sendDataToView(foodsCart: foodsCart,totalPrice: totalPrice)
    }
    
    
}
