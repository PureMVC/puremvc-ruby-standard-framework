require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'rubygems'

spec = Gem::Specification.new do |s| 
  s.name = "PureMVC_Ruby"
  s.version = "1.0.0"
  s.author = "Jake Dempsey"
  s.email = "jake.dempsey@puremvc.org"
  s.homepage = "http://trac.puremvc.org/PureMVC_Ruby/"
  s.platform = Gem::Platform::RUBY
  s.summary = "PureMVC is a lightweight framework for creating applications based upon the classic Model-View-Controller design meta-pattern. This is the specific implementation for the Ruby language based on the Standard Version AS3 reference."
  s.files = FileList["src/**/*"].to_a << "puremvc_ruby.rb"
  s.require_path = "."
  s.has_rdoc = true
  s.extra_rdoc_files = ["version.txt"]
end

Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end