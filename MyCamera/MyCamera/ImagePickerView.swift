//
//  ImagePickerView.swift
//  MyCamera
//
//  Created by Yota on 2022/02/12.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var isShowSheet: Bool
    
    @Binding var captureImage: UIImage?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        let parent: ImagePickerView
        
        init(_ parent: ImagePickerView){
            self.parent = parent
        }
        
        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
                if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                    parent.captureImage = originalImage
                }
                parent.isShowSheet = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
            parent.isShowSheet = false
        }
    }
    
    // Coordinatorを生成する
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(
        context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
        let myImagePickerController = UIImagePickerController()
        
        myImagePickerController.sourceType = .camera
        myImagePickerController.delegate = context.coordinator
        
        return myImagePickerController
    }
    
    func updateUIViewController(
        _ uiViewController: UIImagePickerController,
        context: UIViewControllerRepresentableContext<ImagePickerView>) {
        
    }
}
