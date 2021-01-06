//
//  PromotionViewController.swift
//  AvitoTestTask
//
//  Created by Мехрафруз on 06.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit

struct PromotionCollectionViewAlertModel {
    let title: String
    let price: String
}

final class PromotionViewController: UIViewController {
    
    private let output: PromotionViewOutput
    
    private let exitButton = UIButton()
    private let chooseButton = UIButton()
    
    private let promotionCollectionView: UICollectionView = {
        var viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.alwaysBounceVertical = true
        viewLayout.minimumLineSpacing = 11
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    init(output: PromotionViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewChild()
        view.backgroundColor = .white
    }
    
    
    private func setupViewChild() {
        promotionCollectionView.dataSource = self
        promotionCollectionView.delegate = self
        promotionCollectionView.register(PromotionCollectionViewCell.self,
                                         forCellWithReuseIdentifier: PromotionCollectionViewCell.identifier)
        promotionCollectionView.register(PromotionHeaderCollectionReusableView.self,
                                         forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                         withReuseIdentifier: PromotionHeaderCollectionReusableView.identifier)
        setupLitleButton(button: exitButton, image: UIImage(named: "CloseIconTemplate")!)
        setupButton(button: chooseButton, title: "Продолжить без изменений", color: ColorPalette.lightBlue , textColor: ColorPalette.blue)
        chooseButton.addTarget(self, action: #selector(tapChooseButton), for: .touchUpInside)
        [promotionCollectionView, exitButton, chooseButton].forEach{
            view.addSubview($0)
        }
        addConstraints()
    }
    
    private func addConstraints(){
        [promotionCollectionView, exitButton, chooseButton].forEach {
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            exitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            exitButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            exitButton.widthAnchor.constraint(equalToConstant: 30),
            exitButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        NSLayoutConstraint.activate([
            promotionCollectionView.topAnchor.constraint(equalTo: exitButton.topAnchor, constant: 40),
            promotionCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            promotionCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            promotionCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            chooseButton.heightAnchor.constraint(equalToConstant: 50),
            chooseButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            chooseButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            chooseButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -0.035*UIScreen.main.bounds.height),
        ])
        
    }
    
    func setupLitleButton(button: UIButton, image: UIImage) {
        let image = image
        button.setBackgroundImage( image, for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
    }
    
    func setupButton(button: UIButton, title: String, color: UIColor, textColor: UIColor){
        button.setTitle(title, for: UIControl.State.normal)
        button.setTitleColor(textColor, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont(name: "Lato-Regular", size: 16)
        button.backgroundColor = color
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.shadowRadius = 1.0
        button.layer.shadowOpacity = 0.3
        button.layer.masksToBounds = false
        button.layer.shadowOffset = CGSize(width: 0, height: 0.5)
    }
    
    @objc func tapChooseButton () {
        if chooseButton.titleLabel?.text == "Продолжить без изменений" {
            showAlert(reason: "не выбрана", price: "")
        } else {
            let model = output.getSelectedPromotion()
            showAlert(reason: model.title, price: model.price)
        }
    }
    
}

extension PromotionViewController: PromotionViewInput{
    func update() {
        promotionCollectionView.reloadData()
    }
    
    
}

extension PromotionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        output.itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotionCollectionViewCell.identifier,
                                                            for: indexPath) as? PromotionCollectionViewCell else {
                                                                return .init()
        }
        let item = output.item(at: indexPath.row)
        cell.configure(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PromotionHeaderCollectionReusableView.identifier, for: indexPath) as? PromotionHeaderCollectionReusableView else {
            return .init()
        }
        let headerData = output.header()
        header.configure(with: headerData)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size: CGSize = CGSize(width: 0, height: 0)
        if indexPath.row == 0{
            size = CGSize(width: UIScreen.main.bounds.width-40, height: 185)
        }
        if indexPath.row == 1{
            size = CGSize(width: UIScreen.main.bounds.width-40, height: 155)
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PromotionCollectionViewCell else {
            return
        }
        let item = output.didSelectItem(at: indexPath.row)
        cell.configure(with: item)
        if item.buttonIsActive{
            setupButton(button: chooseButton, title: "Выбрать", color: ColorPalette.blue, textColor: .white)
        } else if !item.buttonIsActive{
            setupButton(button: chooseButton, title: "Продолжить без изменений", color: ColorPalette.lightBlue , textColor: ColorPalette.blue)
        }
        
    }
 
}

extension PromotionViewController: AlertDisplayer{
    func showAlert(reason: String, price: String){
        let title = "Услуга продвижения \(reason)"
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: title , message: price, actions: [action])
    }
}

