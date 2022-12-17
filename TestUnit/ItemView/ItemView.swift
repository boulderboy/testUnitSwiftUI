//
//  ItemView.swift
//  TestUnit
//
//  Created by Mac on 11.12.2022.
//

import SwiftUI

struct ItemView: View {
   
    @ObservedObject var vm = ItemViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                ZStack {
                    Color.mainBackgroundColor.ignoresSafeArea()
                    VStack {
                        if !vm.itemImages.isEmpty {
                            CarouselView(images: vm.itemImages)
                        }
                        DescriptionView(item: $vm.item, selectedColor: $vm.selectedColor, selectedCapacity: $vm.selectedMemory)
                    }
                    .padding(.top, 30)
                }
                .navigationTitle("Product details")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .background(
                                    Color.darkViolet
                                        .frame(width: 37, height: 37)
                                        .cornerRadius(10)
                                )
                        }
                        .padding(.leading, 42)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            
                        } label: {
                            Image("cart")
                                .foregroundColor(.white)
                                .background(
                                    Color.mainOrange
                                        .frame(width: 37, height: 37)
                                        .cornerRadius(10)
                                )
                        }
                        .padding(.trailing, 42)
                    }
                
                }
            }
        }.onAppear {
            vm.getData { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let item):
                    vm.item = item

                    vm.getImages { result in
                        switch result {
                        case .failure(let error):
                            print(error)
                        case .success(let image):
                            
                            print("image")
                            vm.itemImages.append(Image(uiImage: image))
                        }
                    }
                }
            }
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView()
    }
}
