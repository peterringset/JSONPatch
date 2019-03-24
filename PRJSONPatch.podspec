# coding: utf-8
#
#  Be sure to run `pod spec lint JSONPatch.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "PRJSONPatch"
  s.version      = "1.0.1"
  s.summary      = "A Swift μ-framework for creating RFC6902-compliant JSON patch objects"
  s.description  = <<-DESC
                   A Swift µ-framework for creating RFC6902-compliant JSON patch objects.

                   The framework uses the built in Codable protocol to convert from Swift enum to json objects.
                   DESC

  s.homepage     = "https://github.com/peterringset/JSONPatch"

  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "peterringset" => "peter@ringset.no" }

  s.source       = { :git => "https://github.com/peterringset/JSONPatch.git", :tag => "#{s.version}" }
  s.source_files = "JSONPatch", "JSONPatch/**/*.{h,swift}"

  s.swift_version= '4.2'

  s.ios.deployment_target  = '9.0'
  s.osx.deployment_target  = '10.10'
end
