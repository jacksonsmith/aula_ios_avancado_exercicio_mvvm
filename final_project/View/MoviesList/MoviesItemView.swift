//
//  MoviesItemView.swift
//  final_project
//
//  Created by Jackson on 23/06/23.
//

import Foundation
import UIKit
import SwiftyGif

class MoviesItemViewCell: UITableViewCell {
    lazy var imageContainer: UIImageView = {
        
        let gif = try! UIImage(gifName: "skeleton.gif")
        let view = UIImageView(gifImage: gif)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    lazy var title: UITextView = {
       let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.textColor = .black
        view.backgroundColor = .white
        
        view.font = UIFont.boldSystemFont(ofSize: 16)
        
        view.textContainer.maximumNumberOfLines = 2
        view.textContainer.lineBreakMode = .byTruncatingTail
        
        return view
    }()
    
    lazy var average: UITextView = {
        let view = UITextView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.backgroundColor = .white
        
        view.font = UIFont.systemFont(ofSize: 14)
        
        view.text = "Média: 4.5"
        
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(style: UITableViewCell.CellStyle = .default, reuseIdentifier: String?, imageURL: String, title: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.title.text = "Título: \(title)"
        
        fetchImage(imageURL: imageURL)
        setupViews()
        setupConstraints()
        setupBounds()
    }
    
    
    private func setupViews() {
        addSubview(imageContainer)
        addSubview(title)
        addSubview(average)
    }
    
    private func setupConstraints() {
        self.imageContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        self.imageContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4).isActive = true
        self.imageContainer.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.imageContainer.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        self.title.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -40).isActive = true
        self.title.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.title.leadingAnchor.constraint(equalTo: self.imageContainer.trailingAnchor, constant: 4).isActive = true
        self.title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        
        self.average.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 4).isActive = true
        self.average.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.average.leadingAnchor.constraint(equalTo: self.imageContainer.trailingAnchor, constant: 4).isActive = true
        self.average.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
    }
    
    private func setupBounds() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    private func  fetchImage(imageURL: String) {
        let url = URL(string: imageURL)
        URLSession(configuration: .default).dataTask(with: url!) { data,response,_  in
            DispatchQueue.main.async {
                let dataImage = UIImage(data: data!)
                self.imageContainer.setImage(dataImage!)
            }
        }.resume()
    }
}
