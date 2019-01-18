require "json"
require "csv"

json_file_path = "json/ase/ase_1.json"
csv_file_path = "csv/ase/ase_1.csv"

def except_classroom_some(key)
  key != "classroom" && key != "evaluation_method"
end


CSV.open(csv_file_path, "w") do |csv| #open new file for write
  JSON.parse(File.open(json_file_path).read).each do |hash| #open json to parse
    #write value to file
    case hash.keys
    when "evaluation_method"
      puts "#{hash.keys}です　なので飛ばします。\n"
    when "metadata"
      puts "#{hash.keys}です\n"
    else
      puts "#{hash.keys}です\n"
      csv << hash.values
    end
  end
end
