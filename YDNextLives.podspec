#
#  Be sure to run `pod spec lint YDNextLives.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "YDNextLives"
  spec.version      = "1.0.10"
  spec.summary      = "A short description of YDNextLives."
  spec.homepage     = "https://yourdev.com.br"
  spec.license      = "MIT"

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.author             = { "Douglas Hennrich" => "douglashennrich@yourdev.com.br" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.platform     = :ios, "11.0"
  spec.swift_version    = "5.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source       = { :git => "git@github.com:Hennrich-Your-Dev/YDNextLives.git", :tag => "#{spec.version}" }

  spec.info_plist = {
    "NSCalendarsUsageDescription" => "Permissão para salvar eventos em sua agenda",
    "NSContactsUsageDescription" => "Permissão para poder compartilhar com contatos"
  }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source_files     = "YDNextLives/**/*.{h,m,swift}"

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  spec.dependency "YDExtensions", "~> 1.0.42"
  spec.dependency "YDB2WAssets", "~> 1.0.33"
  spec.dependency "YDUtilities", "~> 1.0.10"
  spec.dependency "YDB2WServices", "~> 1.1.0"
  spec.dependency "YDB2WIntegration", "~> 1.1.0"
  spec.dependency "YDB2WComponents", "~> 1.1.0"

end
