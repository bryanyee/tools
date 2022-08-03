# Save a file
file_name = 'test_file.json'
file = File.open(File.join(Dir.pwd, "/tmp/#{file_name}"), "w+") do |f|
 f << 'test string'
end


# Run migration with a specific version
db:migrate VERSION=20080906120000

# Rollback migration with a specific version
rails db:migrate:down VERSION=20080906120000


# Include Rails path helpers in a Rails console
include Rails.application.routes.url_helpers


# Update gem to a specific version
# https://stackoverflow.com/a/71630969
# Specify the gem version in the gemfile, then run `bundle install`
# e.g.
# gem "rspec-rails", "~>3.9"
