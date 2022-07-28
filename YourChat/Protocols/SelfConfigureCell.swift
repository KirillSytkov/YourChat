//
//  SelfConfigurationCell.swift
//  YourChat
//
//  Created by Kirill Sytkov on 28.07.2022.
//

import Foundation

protocol SelfConfigureCell {
   static var reuseId: String { get }
   func configure<U: Hashable>(with value: U)
}
