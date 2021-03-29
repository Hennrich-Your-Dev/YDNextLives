//
//  LiveShimmerTableViewCell.swift
//  YDNextLives
//
//  Created by Douglas Hennrich on 28/03/21.
//

import UIKit

class LiveShimmerTableViewCell: UITableViewCell {
  // MARK: Properties

  // MARK: Components
  let containerView = UIView()
  let photoImageView = UIView()
  let dateLabel = UIView()
  let nameLabel = UIView()
  let descriptionLabel = UIView()
  let descriptionLabel2 = UIView()
  let scheduleButton = UIView()

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

  // MARK: Actions
  func shimmerCell() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.photoImageView.startShimmer()
      self.dateLabel.startShimmer()
      self.nameLabel.startShimmer()
      self.descriptionLabel.startShimmer()
      self.descriptionLabel2.startShimmer()
      self.scheduleButton.startShimmer()
    }
  }
}

// MARK: Layout
extension LiveShimmerTableViewCell {
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
    photoImageView.layer.cornerRadius = 3
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
    dateLabel.backgroundColor = UIColor.Zeplin.graySurface
    dateLabel.layer.cornerRadius = 3
    containerView.addSubview(dateLabel)

    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
      dateLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 12),
      dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
      dateLabel.heightAnchor.constraint(equalToConstant: 12)
    ])
  }

  // Name
  private func createNameLabel() {
    nameLabel.backgroundColor = UIColor.Zeplin.graySurface
    nameLabel.layer.cornerRadius = 3
    containerView.addSubview(nameLabel)

    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
      nameLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
      nameLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
      nameLabel.heightAnchor.constraint(equalToConstant: 20)
    ])
  }

  // Description
  private func createDescriptionLabel() {
    descriptionLabel.backgroundColor = UIColor.Zeplin.graySurface
    descriptionLabel.layer.cornerRadius = 3
    containerView.addSubview(descriptionLabel)

    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
      descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
      descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
      descriptionLabel.heightAnchor.constraint(equalToConstant: 12)
    ])

    descriptionLabel2.backgroundColor = UIColor.Zeplin.graySurface
    descriptionLabel2.layer.cornerRadius = 3
    containerView.addSubview(descriptionLabel2)

    descriptionLabel2.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      descriptionLabel2.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
      descriptionLabel2.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
      descriptionLabel2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -108),
      descriptionLabel2.heightAnchor.constraint(equalToConstant: 12)
    ])
  }

  // Schedule Button
  private func createScheduleButton() {
    scheduleButton.backgroundColor = UIColor.Zeplin.graySurface
    scheduleButton.layer.cornerRadius = 3
    containerView.addSubview(scheduleButton)

    scheduleButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      scheduleButton.heightAnchor.constraint(equalToConstant: 20),
      scheduleButton.widthAnchor.constraint(equalToConstant: 90),
      scheduleButton.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
      scheduleButton.bottomAnchor.constraint(
        equalTo: containerView.bottomAnchor,
        constant: -16
      )
    ])
  }
}
