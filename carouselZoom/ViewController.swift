//
//  ViewController.swift
//  carouselZoom
//
//  Created by Jorge MR on 08/02/18.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var array : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isPagingEnabled = true
        createZoomView()
    array = ["image1","image2","image3","image4","image1"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! PageCollectionViewCell
        cell.imageView.image = UIImage(named: array[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    
    //REGRESA el tamaño de cada celda
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showZoomView(image: array[indexPath.row])
    }
    
    var selectedImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "image1")
        iv.isUserInteractionEnabled = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var swipeDown : UISwipeGestureRecognizer = {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        return swipeDown
    }()
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        print("Swipe down")
    }
    
    var backView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var scrollZoomView : UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.minimumZoomScale = 1.0
        sv.maximumZoomScale = 6.0
        return sv
    }()
    
    func showZoomView(image: String){
        backView.isHidden = false
        selectedImageView.isHidden = false
        scrollZoomView.isHidden = false
    }
    
    func hideZoomView(){
        backView.isHidden = true
        selectedImageView.isHidden = true
        scrollZoomView.isHidden = true
    }
    
    func createZoomView(){
        
        scrollZoomView.delegate = self
        
        self.view.addSubview(backView)
        self.view.addSubview(scrollZoomView)
        scrollZoomView.addSubview(selectedImageView)
        swipeDown.delegate = self
        selectedImageView.addGestureRecognizer(swipeDown)
        
        backView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        backView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        backView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        backView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
       
        scrollZoomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollZoomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollZoomView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollZoomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
        selectedImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        selectedImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
        selectedImageView.leadingAnchor.constraint(equalTo: scrollZoomView.leadingAnchor).isActive = true
        selectedImageView.trailingAnchor.constraint(equalTo: scrollZoomView.trailingAnchor).isActive = true
        var constant = self.view.frame.height / 4
        selectedImageView.topAnchor.constraint(equalTo: scrollZoomView.topAnchor,constant: constant).isActive = true
        constant *= -1
        selectedImageView.bottomAnchor.constraint(equalTo: scrollZoomView.bottomAnchor,constant: constant).isActive = true
        
        
        
        hideZoomView()
    }
    
    func dimissZoomView(){
        hideZoomView()
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return selectedImageView
    }
    

    

}

