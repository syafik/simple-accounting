require 'rdoc/task'

RDoc::Task.new :api do |rdoc|
  rdoc.main = "README.rdoc"
  rdoc.rdoc_files.include("README.rdoc", "app/controller/api/*.rb")
  rdoc.title = "App Documentation"
  rdoc.options << "--all"
end
