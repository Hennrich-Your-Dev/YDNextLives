//
//  LiveShimmerTableViewCell.swift
//  YDNextLives
//
//  Created by Douglas Hennrich on 28/03/21.
//

import UIKit

class LiveShimmerTableViewCell: UITableViewCell {
  // MARK: Properties
  var shimmerViews: [UIView] = []

  // MARK: Components
  let containerView = UIView()
  let photoImageViewShimmer = UIView()
  let dateLabelShimmer = UIView()
  let nameLabelShimmer = UIView()
  let descriptionLabelShimmer = UIView()
  let descriptionLabel2Shimmer = UIView()
  let scheduleButtonShimmer = UIView()

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
      self.shimmerViews.forEach { $0.startShimmer() }
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
    
    shimmerViews.append(
      contentsOf: [
        photoImageViewShimmer,
        dateLabelShimmer,
        nameLabelShimmer,
        descriptionLabelShimmer,
        descriptionLabel2Shimmer,
        scheduleButtonShimmer
      ]
    )
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
    photoImageViewShimmer.layer.cornerRadius = 3
    photoImageViewShimmer.backgroundColor = UIColor.Zeplin.graySurface
    containerView.addSubview(photoImageViewShimmer)

    photoImageViewShimmer.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      photoImageViewShimmer.widthAnchor.constraint(equalToConstant: 126),
      photoImageViewShimmer.heightAnchor.constraint(equalToConstant: 126),
      photoImageViewShimmer.topAnchor
        .constraint(equalTo: containerView.topAnchor, constant: 14),
      photoImageViewShimmer.leadingAnchor.constraint(
        equalTo: containerView.leadingAnchor,
        constant: 10
      ),
      photoImageViewShimmer.bottomAnchor.constraint(
        equalTo: containerView.bottomAnchor,
        constant: -20
      )
    ])
  }

  // Date
  private func createDateLabel() {
    dateLabelShimmer.backgroundColor = UIColor.Zeplin.graySurface
    dateLabelShimmer.layer.cornerRadius = 3
    containerView.addSubview(dateLabelShimmer)

    dateLabelShimmer.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      dateLabelShimmer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
      dateLabelShimmer.leadingAnchor.constraint(
        equalTo: photoImageViewShimmer.trailingAnchor,
        constant: 12
      ),
      dateLabelShimmer.trailingAnchor.constraint(
        equalTo: containerView.trailingAnchor,
        constant: -12
      ),
      dateLabelShimmer.heightAnchor.constraint(equalToConstant: 12)
    ])
  }

  // Name
  private func createNameLabel() {
    nameLabelShimmer.backgroundColor = UIColor.Zeplin.graySurface
    nameLabelShimmer.layer.cornerRadius = 3
    containerView.addSubview(nameLabelShimmer)

    nameLabelShimmer.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nameLabelShimmer.topAnchor.constraint(equalTo: dateLabelShimmer.bottomAnchor, constant: 10),
      nameLabelShimmer.leadingAnchor.constraint(equalTo: dateLabelShimmer.leadingAnchor),
      nameLabelShimmer.trailingAnchor.constraint(equalTo: dateLabelShimmer.trailingAnchor),
      nameLabelShimmer.heightAnchor.constraint(equalToConstant: 20)
    ])
  }

  // Description
  private func createDescriptionLabel() {
    descriptionLabelShimmer.backgroundColor = UIColor.Zeplin.graySurface
    descriptionLabelShimmer.layer.cornerRadius = 3
    containerView.addSubview(descriptionLabelShimmer)

    descriptionLabelShimmer.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      descriptionLabelShimmer.topAnchor.constraint(
        equalTo: nameLabelShimmer.bottomAnchor,
        constant: 4
      ),
      descriptionLabelShimmer.leadingAnchor.constraint(equalTo: nameLabelShimmer.leadingAnchor),
      descriptionLabelShimmer.trailingAnchor.constraint(equalTo: nameLabelShimmer.trailingAnchor),
      descriptionLabelShimmer.heightAnchor.constraint(equalToConstant: 12)
    ])

    descriptionLabel2Shimmer.backgroundColor = UIColor.Zeplin.graySurface
    descriptionLabel2Shimmer.layer.cornerRadius = 3
    containerView.addSubview(descriptionLabel2Shimmer)

    descriptionLabel2Shimmer.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      descriptionLabel2Shimmer.topAnchor.constraint(
        equalTo: descriptionLabelShimmer.bottomAnchor,
        constant: 4
      ),
      descriptionLabel2Shimmer.leadingAnchor.constraint(equalTo: nameLabelShimmer.leadingAnchor),
      descriptionLabel2Shimmer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -108),
      descriptionLabel2Shimmer.heightAnchor.constraint(equalToConstant: 12)
    ])
  }

  // Schedule Button
  private func createScheduleButton() {
    scheduleButtonShimmer.backgroundColor = UIColor.Zeplin.graySurface
    scheduleButtonShimmer.layer.cornerRadius = 3
    containerView.addSubview(scheduleButtonShimmer)

    scheduleButtonShimmer.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      scheduleButtonShimmer.heightAnchor.constraint(equalToConstant: 20),
      scheduleButtonShimmer.widthAnchor.constraint(equalToConstant: 90),
      scheduleButtonShimmer.trailingAnchor.constraint(equalTo: dateLabelShimmer.trailingAnchor),
      scheduleButtonShimmer.bottomAnchor.constraint(
        equalTo: containerView.bottomAnchor,
        constant: -16
      )
    ])
  }
}
