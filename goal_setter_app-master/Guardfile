guard :rspec, cmd: 'spring rspec' do
  watch(%r{^spec/}) { "spec" }
  watch(%r{^app/}) { "spec" }
  watch('config/routes.rb') { "spec" }
end
