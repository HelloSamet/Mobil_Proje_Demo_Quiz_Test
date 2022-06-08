//
//  UsersData.swift
//  DemoMobilProje
//
//  Created by Abdulsamet Göçmen on 16.05.2022.
//

import Foundation
public class User{
  private  var name: String?
   private var gmail: String?
   private var passwords: String?
    
    
    public func getName() -> String{
        return name!
    }
    
    public func setName(_name: String){
        self.name = _name
    }
    
    public func getGmail() -> String{
        return gmail!
    }
    
    public func setGmail(_gmail: String){
        self.gmail = _gmail
    }
    
    public func getPassword() -> String{
        return passwords!
    }
    
    public func setPassword(_password: String){
        self.passwords = _password
    }
    
}
