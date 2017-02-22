Pod::Spec.new do |s|
  s.name             = "RecordButton"
  s.version          = "1.0.2"
  s.summary          = "A Record Button in Swift."
  s.description      = <<-DESC
    A Modulair Record Button in Swift. It shows you the recording process when recording. It's great for a video recorder app with a fixed/maximum length like snapchat, vine, instragram.
                       DESC
  s.homepage         = "https://github.com/samuelbeek/RecordButton"
  s.screenshots      = "http://i.imgur.com/WTO3KLC.png"
  s.license          = 'MIT'
  s.author           = { "samuelbeek" => "samuel.beek@gmail.com" }
  s.source           = { :git => "https://github.com/samuelbeek/RecordButton.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/samuelbeek'
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'
  s.frameworks = 'UIKit'
end
