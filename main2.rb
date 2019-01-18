require "json"
require "csv"

csv_file_path = "csv/ase/ase_1.csv"

def insert_element(value, term, i, j)
  # i = 通年かどうかで決まる 基本的に0のみ
  # j = その期で授業コマ文だけ回すため
  [].push( value[0] ,
           value[1] ,
           value[2] ,
           value[3] ,
           value[4] ,
           value[5] ,
           value[6] ,
           value[7] ,
           value[8] ,
           value[9] ,
           value[10] ,
           value[11] ,
           value[12] ,
           value[13] ,
           value[14] ,
           value[15] ,
           value[16] ,
           value[17] ,
           term ,
           value[19][i][j]["day"] ,
           value[19][i][j]["period"] ,
           value[19][i][j]["classroom"],
           value[20] )
end

def json_format(csv , json_file_path = "json/ase/ase_1.json", count = 0)
  # puts JSON.parse(File.open(json_file_path).read)
  JSON.parse(File.open(json_file_path).read).each do |hash| #open json to parse
    count = count + 1
    puts "#{hash.values} ----"
    if hash.values[18].include?("通年")
      # 
      puts "hash.values[18].include?(\"通年\")を通ってますね"
    elsif hash.values[19][0].length > 1
      # 通年以外(春か秋かのみ) かつ 2コマ以上 の場合
      # ただし、微積などの場合は通年であり かつ 半期ごとに２コマ以上あるのでその場合は、注意する。
      next if hash.values[18].include?("通年")
      j = 0
      hash.values[19][0].map do
        # csv << insert_element(hash.values, hash.values["term"], 0, j)
        puts "insert_element(hash.values, hash.values[\"term\"], 0, j)  : #{insert_element(hash.values, hash.values[18], 0, j).class}"
        j = j + 1
      end
    else
      puts "else文ですね"
      # csv << insert_element(hash.values, hash.values["term"], 0, 0)
    end
    puts "#{count}\n"
  end
end


CSV.open(csv_file_path, "w") do |csv| #open new file for write
  json_format(csv)
end
