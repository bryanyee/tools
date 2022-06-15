# Save a file
file_name = 'test_file.json'
file = File.open(File.join(Dir.pwd, "/tmp/#{file_name}"), "w+") do |f|
 f << 'test string'
end


# Run migration with a specific version
db:migrate VERSION=20080906120000

# Rollback migration with a specific version
rails db:migrate:down VERSION=20080906120000
