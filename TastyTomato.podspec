Pod::Spec.new do |s|
  s.name = "TastyTomato"
  s.version = "0.0.1"
  s.summary = "The Tasty Tomato."
  s.description = <<-DESC 
                  Get all the awesome custom UI elements that 
                  resmio uses to make your App really beautiful!
                  DESC
  s.homepage = "https://github.com/resmio/TastyTomato"
  s.license = { 
    :type => "MIT",
    :file => "LICENSE"
  }
  s.authors = {
    "Jan Nash" => "jan@resmio.com" 
  }
  s.platform = :ios, "8.0"
  s.source = {
    :git => "https://github.com/resmio/TastyTomato.git",
    :tag => "v#{s.version}"
  }
  s.source_files = "TastyTomato/**/*.swift"
  # s.resources = "TastyTomato/Code/CoreData/MPDataModel.{xcdatamodeld,xcdatamodel}"
  s.public_header_files = []
end