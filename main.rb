require "json"
require "csv"

json_file_path = "json/ase/ase_2.json"
csv_file_path = "csv/ase/ase_2.csv"

CSV.open(csv_file_path, "w") do |csv| #open new file for write
  JSON.parse(File.open(json_file_path).read).each do |hash| #open json to parse
    #write value to file
    csv << hash.values
    puts hash.keys
  end
end
