# Save a file
file_name = 'test_file.json'
file = File.open(File.join(Dir.pwd, "/tmp/#{file_name}"), "w+") do |f|
 f << 'test string'
end
