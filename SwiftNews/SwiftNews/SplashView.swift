//
//  SplashView.swift
//  SwiftNews
//
//

import SwiftUI

struct SplashView: View {
    
    @State var isAnimating = false

    
    var body: some View {
        
        ZStack{
            
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                
                Image(systemName: "swift")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .scaleEffect(isAnimating ? CGFloat(1) : CGFloat(100))
                    .rotationEffect(isAnimating ? .degrees(360) : .degrees(0))
                    .animation(Animation.easeOut(duration: 1), value: isAnimating)
                    .foregroundColor(Color("primaryColor"))
                    .padding(20)
                    
                    
                    
                    
                
                Text("SWIFT")
                    .padding(-15)
                    .font(.system(size: 60 , design: .rounded))
                    .fontWeight(.semibold)
                    .kerning(3)
                    .foregroundStyle(
                        Color(.white).shadow(.inner(color: .black.opacity(1), radius: 1))
                    )
                    .offset(x: isAnimating ? 0 : -600)
                    .animation(Animation.easeOut(duration: 0.5).delay(1), value: isAnimating)
                
                Text("NEWS")
                    .padding(-15)
                    .font(.system(size: 65 , design: .rounded))
                    .fontWeight(.bold)
                    .kerning(4)
                    .foregroundStyle(
                        Color(.white).shadow(.inner(color: .black.opacity(1), radius: 1))
                    )
                    .offset(x: isAnimating ? 0 : 600)
                    .animation(Animation.easeOut(duration: 0.5).delay(1.5), value: isAnimating)
                    
            }
        }
        .onAppear{
            isAnimating = true
        }
        
            
        
    }
        
}
