//
//  LiveTableViewCell.swift
//  YDNextLives
//
//  Created by Douglas Hennrich on 27/03/21.
//

import UIKit

import YDExtensions
import YDB2WAssets

class LiveTableViewCell: UITableViewCell {
  // MARK: Properties
  var callback: (() -> Void)?

  // MARK: Components
  let containerView = UIView()
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
    dateLabel.text = nil
    nameLabel.text = nil
    descriptionLabel.text = nil
    callback = nil
  }

  // MARK: Actions
  func setStyle(actived: Bool) {
    dateLabel.textColor = actived ? UIColor.Zeplin.redNight : UIColor.Zeplin.grayLight
    scheduleButton.tintColor = actived ? UIColor.Zeplin.grayNight : UIColor.Zeplin.redBranding

    scheduleButton.setAttributedTitle(
      NSAttributedString(
        string: "adicionar",
        attributes: [
          NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
          NSAttributedString.Key.foregroundColor: actived ? UIColor.Zeplin.grayNight : UIColor.Zeplin.redBranding
        ]
      ),
      for: .normal)
    scheduleButton.isEnabled = !actived
  }

  func config(withLive live: NextLive) {
    photoImageView.setImage(live.photo)
    dateLabel.text = live.formatedDate
    nameLabel.text = live.name
    descriptionLabel.text = live.description
    setStyle(actived: live.isAvailable)
  }

  func shimmerCell() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.photoImageView.startShimmer()
      self.dateLabel.startShimmer()
      self.nameLabel.startShimmer()
      self.descriptionLabel.startShimmer()
      self.scheduleButton.startShimmer()
    }
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
    containerView.backgroundColor = UIColor.Zeplin.white
    containerView.layer.applyShadow(alpha: 0.08, y: 6, blur: 20, spread: -1)
    containerView.layer.cornerRadius = 6
    containerView.layer.masksToBounds = false
    contentView.addSubview(containerView)

    containerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
    ])
  }

  // Photo
  private func createPhotoImageView() {
    photoImageView.layer.cornerRadius = 4
    photoImageView.layer.masksToBounds = true
    photoImageView.backgroundColor = UIColor.Zeplin.graySurface
    containerView.addSubview(photoImageView)

    photoImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      photoImageView.widthAnchor.constraint(equalToConstant: 116),
      photoImageView.heightAnchor.constraint(equalToConstant: 116),
      photoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
      photoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
      photoImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
    ])
  }

  // Date
  private func createDateLabel() {
    dateLabel.textColor = UIColor.Zeplin.grayLight
    dateLabel.font = .systemFont(ofSize: 12, weight: .bold)
    dateLabel.textAlignment = .left
    containerView.addSubview(dateLabel)

    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
      dateLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 12),
      dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
      dateLabel.heightAnchor.constraint(equalToConstant: 14)
    ])
  }

  // Name
  private func createNameLabel() {
    nameLabel.textColor = UIColor.Zeplin.black
    nameLabel.font = .systemFont(ofSize: 16, weight: .bold)
    nameLabel.textAlignment = .left
    containerView.addSubview(nameLabel)

    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
      nameLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
      nameLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
      nameLabel.heightAnchor.constraint(equalToConstant: 19)
    ])
  }

  // Description
  private func createDescriptionLabel() {
    descriptionLabel.textColor = UIColor.Zeplin.grayLight
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
