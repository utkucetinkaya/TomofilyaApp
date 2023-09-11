//
//  OnboardingViewController.swift
//  TomofilyaApp
//
//  Created by Utku Çetinkaya on 6.08.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var logInSignUpButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        registerCollectionView()
        setupPageControl()
        setupCollectionView()
        
    }
        
    // MARK: - SetFunctions
    
    private func setupViews() {
        logInSignUpButton.setCorner(radius: 20)
        navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.backgroundColor = UIColor(hex: "#0F0F0F")
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = Slide.collection.count
        pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
    }
    
    private func registerCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: OnboardingCollectionViewCell.nameOfClass, bundle: nil), forCellWithReuseIdentifier: OnboardingCollectionViewCell.nameOfClass)
    }

    // MARK: - Selector Func
    @objc private func pageControlValueChanged() {
        let currentPage = pageControl.currentPage
        let xOffset = CGFloat(currentPage) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
    }
    
    // MARK: - Action
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegate,UICollectionViewDataSource

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Slide.collection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.nameOfClass, for: indexPath) as? OnboardingCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let imageName = Slide.collection[indexPath.item].imageName
        let image = UIImage(named: imageName) ?? UIImage()
        cell.setCell(image: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        self.pageControl.currentPage = index
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
      
        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        self.pageControl.currentPage = index
    }
}
