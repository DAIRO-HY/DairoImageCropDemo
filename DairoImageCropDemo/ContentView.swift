//
//  ContentView.swift
//  DairoImageCrop
//
//  Created by zhoulq on 2024/03/17.
//

import SwiftUI
import DairoImageCrop


struct ContentView: View {
    
    /**
     * 显示图片选择器开关
     */
    @State private var isShowingCropView = false
    
    /**
     * 图片选择器开关
     */
    @State private var isShowingImagePicker = false
    
    /**
     * 裁剪好的图片
     */
    @State var cropImage: UIImage?

    @State private var position = CGSize.zero
    @GestureState private var magnification: CGFloat = 1.0
    @GestureState private var translation: CGSize = .zero
    
    private let vm = ContentViewModel()
    var body: some View {
        VStack {
            if let cropImage = self.cropImage{
                Image(uiImage: cropImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            }
            Spacer().frame(height: 100)
            Button(action:{
                self.isShowingImagePicker.toggle()
            }){
                Text("选择图片")
            }
        }
        .fullScreenCover(isPresented: self.$isShowingCropView) {
            DairoImageCropView(cropWHRate:"2:1", inputImage: self.vm.inputImage!){
                self.cropImage = $0
            }
        }
        .fullScreenCover(isPresented: $isShowingImagePicker) {
            
            //选择图片
            SystemUIImagePicker{
                self.vm.inputImage = $0
                self.isShowingCropView = $0 != nil
            }
        }
        .edgesIgnoringSafeArea(.all)//忽略安全区域
    }
    
}

class ContentViewModel{
    var inputImage: UIImage?
}

#Preview{
    ContentView()
}
