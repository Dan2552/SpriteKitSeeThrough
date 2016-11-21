Pod::Spec.new do |s|
  s.name             = 'SpriteKitSeeThrough'
  s.version          = '0.1.0'
  s.summary          = 'Inverted circular mask SpriteKit node'

  s.description      = <<-DESC
InvertedCircleMaskNode allows you to create a SpriteKit node that can act as an inverted circular mask. It can be used, for example, to be able to allow the player to see behind walls if your character is behind a wall.

This is possible by using an image of a transparent (alpha 0) circle within a rectangle of the size of the scene. Behind the scenes, this little library will pre-generate this image for you given a position and radius so you don't have to create any assets manually.
                       DESC

  s.homepage         = 'https://github.com/Dan2552/SpriteKitSeeThrough'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Inkpen' => 'dan2552@gmail.com' }
  s.source           = { :git => 'https://github.com/Dan2552/SpriteKitSeeThrough.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Dan2552'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SpriteKitSeeThrough/Classes/**/*'

  s.frameworks = 'UIKit', 'SpriteKit'
end
