//
//  CartPageProtocols.swift
//  FoodEr
//
//  Created by Abid Qurbanov on 14.12.2022.
//

import Foundation
protocol ViewToPresenterCartPageProtocol{
    var cartPageInteractor : PresenterToInteractorCartPageProtocol?{get set}
    var cartPageView :PresenterToViewCartPageProtocol?{get set}
    func getCartFood()
    func deleteCartFood(sepet_yemek_id:Int, kullanici_adi:String)
    func changeCartFoodCount(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:Int,sepet_yemek_id:Int ,yeniAdet:Int)
}
protocol PresenterToInteractorCartPageProtocol{
    var cartPagePresenter : InteractorToPresenterCartPageProtocol?{get set}
    func getCartFoodI()
    func deleteCartFoodI(sepet_yemek_id:Int, kullanici_adi:String)
    func changeCartFoodCountI(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:Int,sepet_yemek_id:Int ,yeniAdet:Int)
}

protocol InteractorToPresenterCartPageProtocol{
    func sendDataToPresenter(foodsCart:[FoodsCart],totalPrice:Int)
}

protocol PresenterToViewCartPageProtocol{
    func sendDataToView(foodsCart:[FoodsCart],totalPrice:Int)
}



protocol PresenterToRouterCartPageProtocol{
    static func createModule(ref: CartPageVC)
}
