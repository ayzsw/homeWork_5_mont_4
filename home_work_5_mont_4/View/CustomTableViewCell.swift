//
//  CustomTableViewCell.swift
//  home_work_5_mont_4
//
//  Created by Аяз on 2/6/23.
//

import UIKit
import Kingfisher

class CustomTableViewCell: UITableViewCell {
    
    private let bgView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var  titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .systemFont(ofSize: 20, weight: .semibold)
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var image: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 100
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        updateUI()
    }
    
    private func updateUI() {
        contentView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(100)
        }
        
        bgView.addSubview(image)
        image.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview().inset(5)
            make.width.equalTo(100)
        }
        
        image.layer.cornerRadius = image.frame.height / 2.5
        
        bgView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(10)
            make.trailing.equalTo(image.snp.leading).inset(10)
        }
        
        bgView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.bottom.equalToSuperview().inset(5)
            make.trailing.equalTo(image.snp.leading).inset(-10)
        }
    }
    
    func updateInfo(model: Product) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        image.kf.setImage(with: URL(string: model.thumbnail!))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
