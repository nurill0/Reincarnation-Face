//
//  Testssss.swift
//  Reincarnation Face
//
//  Created by Nurillo Domlajonov on 27/10/23.
//

import UIKit
import Vision

protocol ImageSelectionDelegate: AnyObject {
    func didSelectImage(_ image: UIImage)
}

class DrawVC: BaseVC {
    
    weak var delegate: ImageSelectionDelegate?
    
    
    lazy var imageView: UIImageView = {
        let imgv = UIImageView()
        imgv.image = UIImage(named: "example")
        imgv.contentMode = .scaleAspectFill
        
        return imgv
    }()
    
    lazy var maskImageView: UIImageView = {
        let imgv = UIImageView()
        imgv.image = UIImage(named: "a1")
        imgv.contentMode = .scaleAspectFill
        
        return imgv
    }()
    
    lazy var addMaskButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Add Mask", for: .normal)
        btn.backgroundColor = .link
        btn.addTarget(self, action: #selector(addMask), for: .touchUpInside)
        
        return btn
    }()
    
    
    lazy var margedImgView: UIImageView = {
        let imgv = UIImageView()
        imgv.contentMode = .scaleAspectFit
        
        return imgv
    }()
    var initialCenter = CGPoint()
    
    var wd: CGFloat!
    var ht: CGFloat!
    var xx: CGFloat!
    var yy: CGFloat!
    
    @objc func addMask(){
        delegate?.didSelectImage(combineImages())
        dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        draw()
        view.addSubview(imageView)
        view.addSubview(addMaskButton)
        addMaskButton.bottom(view.safeAreaLayoutGuide.bottomAnchor, -30)
        addMaskButton.width(100)
        addMaskButton.height(50)
        addMaskButton.centerX(view.centerXAnchor)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan))
        maskImageView.isUserInteractionEnabled = true
        maskImageView.addGestureRecognizer(panGesture)
    }
    
}



extension DrawVC {
    
    func combineImages() -> UIImage {
        // Get the size of the combined image
        let size = CGSize(width: max(imageView.bounds.width, maskImageView.bounds.width),
                          height: imageView.bounds.height)
        
        // Begin an image context
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        
        // Draw the first image view's contents
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        // Translate and draw the second image view's contents below the first image
        UIGraphicsGetCurrentContext()?.translateBy(x: maskImageView.frame.origin.x, y: maskImageView.frame.origin.y-maskImageView.bounds.height/2-10)
        maskImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        // Get the combined image from the context
        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return combinedImage
    }
    
    
    func draw(){
        guard let imgg = UIImage(named: "example") else { return }
        view.addSubview(imageView)
        let scaledHeight = view.frame.width / imgg.size.width * imgg.size.height
        imageView.frame = CGRect(x: 0, y: 140, width: view.frame.width, height: scaledHeight)
        DispatchQueue.main.async { [self] in
            self.view.addSubview(self.maskImageView)
            maskImageView.frame = CGRect(x: 0, y: 0, width: imageView.bounds.width-50, height: imageView.bounds.height-50)
            maskImageView.center = imageView.center
        }
    }
    
    @objc func didPan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        switch gesture.state {
        case .began:
            // Store the initial center of the moving image
            initialCenter = maskImageView.center
        case .changed:
            // Update the position of the moving image based on the gesture translation
            maskImageView.center = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
        case .ended, .cancelled:
            // If the pan ends, you can implement logic to snap the moving image back or perform additional actions
            // For your scenario, you might determine the direction of the swipe and decide what to do next
            let velocity = gesture.velocity(in: view)
            if velocity.x > 0 {
                // Swiped to the right
                // Implement code to move the image view to a new position or perform specific actions
                // Example: movingImageView.center.x = someNewPosition
            } else if velocity.x < 0 {
                // Swiped to the left
                // Implement code to move the image view to a different position or perform specific actions
                // Example: movingImageView.center.x = someOtherPosition
            }
            
            // You might also want to implement additional logic based on the swipe speed, distance, etc.
        default:
            break
        }
    }
    
    
}
