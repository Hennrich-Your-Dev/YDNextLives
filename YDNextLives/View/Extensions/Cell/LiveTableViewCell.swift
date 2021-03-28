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

  // MARK: Components
  let photoImageView = UIImageView()
  let dateLabel = UILabel()
  let nameLabel = UILabel()
  let descriptionLabel = UILabel()
  let scheduleButton = UIButton()

  // MARK: Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none

    contentView.backgroundColor = UIColor.Zeplin.white
    contentView.layer.applyShadow(alpha: 0.08, y: 6, blur: 20, spread: -1)
    contentView.layer.cornerRadius = 6
    contentView.layer.masksToBounds = false

    contentView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: topAnchor),
      contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
      contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
    ])

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
  }

  // MARK: Actions
  private func setStyle(actived: Bool) {
    dateLabel.textColor = actived ? UIColor.Zeplin.redNight : UIColor.Zeplin.grayNight
    scheduleButton.tintColor = actived ? UIColor.Zeplin.redBranding : UIColor.Zeplin.grayNight
    scheduleButton.setTitleColor(
      actived ? UIColor.Zeplin.redBranding : UIColor.Zeplin.grayNight,
      for: .normal
    )
    scheduleButton.isEnabled = actived
  }

  func config() {

  }
}

// MARK: Layout
extension LiveTableViewCell {
  func setUpLayout() {
    createPhotoImageView()
    createDateLabel()
    createNameLabel()
    createDescriptionLabel()
    createScheduleButton()
  }

  // Photo
  private func createPhotoImageView() {
    photoImageView.layer.cornerRadius = 4
    photoImageView.backgroundColor = UIColor.Zeplin.grayDisabled
    contentView.addSubview(photoImageView)

    photoImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      photoImageView.widthAnchor.constraint(equalToConstant: 116),
      photoImageView.heightAnchor.constraint(equalToConstant: 116),
      photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
    ])
  }

  // Date
  private func createDateLabel() {
    dateLabel.textColor = UIColor.Zeplin.redNight
    dateLabel.font = .systemFont(ofSize: 12, weight: .bold)
    dateLabel.textAlignment = .left
    contentView.addSubview(dateLabel)

    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
      dateLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 12),
      dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
      dateLabel.heightAnchor.constraint(equalToConstant: 14)
    ])
  }

  // Name
  private func createNameLabel() {
    nameLabel.textColor = UIColor.Zeplin.black
    nameLabel.font = .systemFont(ofSize: 16, weight: .bold)
    nameLabel.textAlignment = .left
    contentView.addSubview(nameLabel)

    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
      nameLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
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
    contentView.addSubview(descriptionLabel)

    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
      descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
      descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
    ])
  }

  // Schedule Button
  private func createScheduleButton() {
    scheduleButton.tintColor = UIColor.Zeplin.redBranding
    scheduleButton.setTitleColor(UIColor.Zeplin.redBranding, for: .normal)
    scheduleButton.setTitle("adicionar", for: .normal)
    scheduleButton.setImage(Icons.scheduleLive, for: .normal)
    scheduleButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 0)

    contentView.addSubview(scheduleButton)

    scheduleButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      scheduleButton.heightAnchor.constraint(equalToConstant: 40),
      scheduleButton.widthAnchor.constraint(equalToConstant: 90),
      scheduleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      scheduleButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 3)
    ])
  }
}
