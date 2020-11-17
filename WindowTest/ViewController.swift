//
//  ViewController.swift
//  WindowTest
//
//  Created by Bandi, Anirudh on 11/16/20.
//

import UIKit


class ViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGreen
        
        
        label.text = "This is the key window"
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("laying out subviews")
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Just added a small delay to see the addition of the banner window clearly
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

            // height of the Banner window
            let height: CGFloat = 100
            
            guard let window = self.view.window,
                  let windowScene = window.windowScene,
                  let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow })
            else { return }
            
            // accessing the key window and changing its frame so that the window's content is not
            // blocked by the banner window that is going to be above it
            let size = keyWindow.frame.size
            keyWindow.frame = CGRect(origin: CGPoint(x: 0, y: height), size: CGSize(width: size.width, height: size.height - height))
            
            // Creating a banner window
            let bannerWindow = UIWindow(windowScene: windowScene)
            bannerWindow.frame = CGRect(origin: .zero, size: CGSize(width: size.width, height: height))
            bannerWindow.isHidden = false
            
            // Creating a banner view and adding it to the banner window
            let bannerView = UIView(frame: .zero)
            bannerView.backgroundColor = .systemPink
            bannerView.translatesAutoresizingMaskIntoConstraints = false
            
            bannerWindow.addSubview(bannerView)
            bannerWindow.windowLevel = keyWindow.windowLevel + 1
            NSLayoutConstraint.activate([
                bannerView.leadingAnchor.constraint(equalTo: bannerWindow.leadingAnchor),
                bannerView.trailingAnchor.constraint(equalTo: bannerWindow.trailingAnchor),
                bannerView.heightAnchor.constraint(equalToConstant: height),
                bannerView.bottomAnchor.constraint(equalTo: bannerWindow.bottomAnchor),
            ])
            
            // Keeping a reference to the banner window to prevent it from being deallocated
            appDelegate.bannerWindow = bannerWindow
        }
      
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        print("Trait collection changed")
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        print("will transition to new collection")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        print("will transtion to size: \(size)")
    }
}

