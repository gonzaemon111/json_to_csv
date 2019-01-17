require "json"
require "csv"

level,form,open_cource,full_od,term,day,period,classroom

csv_file_path = "csv/ase/ase_1.csv"

def insert_element(value, term, i, j)
  [].push value["year"]
    .push value["place"]
    .push value["name"]
    .push value["professor"]
    .push value["category"]
    .push value["target_grade"]
    .push value["credit"]
    .push value["campus"]
    .push value["language"]
    .push value["field_large"]
    .push value["field_middle"]
    .push value["field_small"]
    .push value["level"]
    .push value["form"]
    .push value["open_cource"]
    .push value["full_od"]
    .push term
    .push value[i][j]["day"]
    .push value[i][j]["period"]
    .push value[i][j]["classroom"]
    .push value["textbook"]
end

def json_format(csv , json_file_path = "json/ase/ase_1.json", count = 0)
  # puts JSON.parse(File.open(json_file_path).read)
  JSON.parse(File.open(json_file_path).read).each do |hash| #open json to parse
    count = count + 1
    puts "#{hash.values} ----"
    if hash.values[18].include?("通年")
      # 
    elsif hash.values[19][0].length > 1
      next if hash.values[18].include?("通年")
      hash.values[19].map do
      end
    else
      puts "else文ですね"
      csv << insert_element(hash.values, hash.values["term"], 0, 0)
    end
    puts "#{count}\n"
  end
end


CSV.open(csv_file_path, "w") do |csv| #open new file for write
  json_format(csv)
end
