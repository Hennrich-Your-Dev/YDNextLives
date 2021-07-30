//
//  LiveTableViewCell.swift
//  YDNextLives
//
//  Created by Douglas Hennrich on 27/03/21.
//

import UIKit

import YDExtensions
import YDB2WAssets
import YDB2WModels

class LiveTableViewCell: UITableViewCell {
  // MARK: Properties
  var callback: (() -> Void)?

  // MARK: Components
  let containerView = UIView()
  
  let photoBackgroundView = UIView()
  let photoPlaceImage = UIImageView()
  let photoImageView = UIImageView()
  
  let dateLabel = UILabel()
  let nameLabel = UILabel()
  let descriptionLabel = UILabel()
  
  let scheduleButton = UIButton()

  // MARK: Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    backgroundColor = .clear
    contentView.backgroundColor = .clear
    setUpLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    photoImageView.image = nil
    photoPlaceImage.isHidden = false
    dateLabel.text = nil
    nameLabel.text = nil
    descriptionLabel.text = nil
    callback = nil
  }

  // MARK: Actions
  func setStyle(isAvailable: Bool, isLive: Bool) {
    dateLabel.textColor = isAvailable ? UIColor.Zeplin.grayLight: UIColor.Zeplin.redNight
    scheduleButton.tintColor = isAvailable ? UIColor.Zeplin.redBranding : UIColor.Zeplin.grayLight
    dateLabel.textColor = isLive ?
      UIColor.Zeplin.redNight :
      UIColor.Zeplin.grayLight

    scheduleButton.setAttributedTitle(
      NSAttributedString(
        string: isAvailable ? "adicionar" :
          isLive ? "adicionar" : "adicionado",
        attributes: [
          NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
          NSAttributedString.Key.foregroundColor: isAvailable ? UIColor.Zeplin.redBranding : UIColor.Zeplin.grayNight
        ]
      ),
      for: .normal
    )
    scheduleButton.isEnabled = isAvailable
  }

  func config(withLive live: YDSpaceyComponentNextLive) {
    photoImageView.setImage(
      live.photo
    ) { [weak self] success in
      guard let self = self else { return }
      guard success != nil else { return }
      self.photoPlaceImage.isHidden = true
    }
    
    dateLabel.text = live.formatedDate
    nameLabel.text = live.name
    descriptionLabel.text = live.description
    
    setStyle(isAvailable: live.isAvailable, isLive: live.isLive)
  }

  @objc func onButtonAction() {
    callback?()
  }
}

// MARK: Layout
extension LiveTableViewCell {
  func setUpLayout() {
    createContainerView()
    createPhotoImageView()
    createDateLabel()
    createNameLabel()
    createDescriptionLabel()
    createScheduleButton()
  }

  // Container
  private func createContainerView() {
    containerView.backgroundColor = Zeplin.white
    containerView.layer.applyShadow(alpha: 0.08, y: 6, blur: 20, spread: -1)
    containerView.layer.cornerRadius = 6
    containerView.layer.masksToBounds = false
    contentView.addSubview(containerView)

    containerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      containerView.trailingAnchor
        .constraint(equalTo: contentView.trailingAnchor, constant: -16)
    ])
  }

  // Photo
  private func createPhotoImageView() {
    // Container
    photoBackgroundView.layer.cornerRadius = 4
    photoBackgroundView.layer.masksToBounds = true
    photoBackgroundView.backgroundColor = UIColor.Zeplin.graySurface
    containerView.addSubview(photoBackgroundView)

    photoBackgroundView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      photoBackgroundView.widthAnchor.constraint(equalToConstant: 126),
      photoBackgroundView.heightAnchor.constraint(equalToConstant: 126),
      photoBackgroundView.topAnchor.constraint(
        equalTo: containerView.topAnchor,
        constant: 14
      ),
      photoBackgroundView.leadingAnchor.constraint(
        equalTo: containerView.leadingAnchor,
        constant: 10
      ),
      photoBackgroundView.bottomAnchor.constraint(
        equalTo: containerView.bottomAnchor,
        constant: -20
      )
    ])

    // Placeholder
    photoBackgroundView.addSubview(photoPlaceImage)
    photoPlaceImage.image = Icons.imagePlaceHolder
    photoPlaceImage.tintColor = Zeplin.grayNight
    photoPlaceImage.translatesAutoresizingMaskIntoConstraints = false
    photoPlaceImage.bindFrame(
      top: 16,
      bottom: -16,
      leading: 16,
      trailing: -16,
      toView: photoBackgroundView
    )
    
    // Image
    photoBackgroundView.addSubview(photoImageView)
    photoImageView.layer.cornerRadius = 4
    photoImageView.layer.masksToBounds = true
    photoImageView.contentMode = .scaleAspectFill

    photoImageView.translatesAutoresizingMaskIntoConstraints = false
    photoImageView.bindFrame(toView: photoBackgroundView)
  }

  // Date
  private func createDateLabel() {
    dateLabel.textColor = Zeplin.grayLight
    dateLabel.font = .systemFont(ofSize: 12, weight: .bold)
    dateLabel.textAlignment = .left
    containerView.addSubview(dateLabel)

    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
      dateLabel.leadingAnchor
        .constraint(equalTo: photoBackgroundView.trailingAnchor, constant: 12),
      dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
      dateLabel.heightAnchor.constraint(equalToConstant: 14)
    ])
  }

  // Name
  private func createNameLabel() {
    nameLabel.textColor = Zeplin.black
    nameLabel.font = .systemFont(ofSize: 16, weight: .bold)
    nameLabel.textAlignment = .left
    nameLabel.numberOfLines = 2
    containerView.addSubview(nameLabel)

    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
      nameLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
      nameLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
      nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 19)
    ])
    nameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
  }

  // Description
  private func createDescriptionLabel() {
    descriptionLabel.textColor = Zeplin.grayLight
    descriptionLabel.font = .systemFont(ofSize: 12)
    descriptionLabel.textAlignment = .left
    descriptionLabel.numberOfLines = 2
    containerView.addSubview(descriptionLabel)

    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
      descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
      descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
    ])
  }

  // Schedule Button
  private func createScheduleButton() {
    scheduleButton.tintColor = UIColor.Zeplin.redBranding
    let title = "adicionar"
    let attributeString = NSMutableAttributedString(string: title)

    attributeString.addAttributes(
      [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
        NSAttributedString.Key.foregroundColor: UIColor.Zeplin.redBranding
      ],
      range: NSRange(location: 0, length: title.utf8.count)
    )

    scheduleButton.setAttributedTitle(attributeString, for: .normal)
    scheduleButton.setImage(Icons.scheduleLive, for: .normal)
    scheduleButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    scheduleButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
    scheduleButton.contentHorizontalAlignment = .right
    containerView.addSubview(scheduleButton)

    scheduleButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      scheduleButton.heightAnchor.constraint(equalToConstant: 40),
      scheduleButton.widthAnchor.constraint(equalToConstant: 120),
      scheduleButton.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
      scheduleButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4)
    ])

    scheduleButton.addTarget(self, action: #selector(onButtonAction), for: .touchUpInside)
  }
}
