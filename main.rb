require "json"
require "csv"

csv_file_path = "csv/sss.csv"

def insert_element(value, term, i, j)
  # i = 通年かどうかで決まる 基本的に0のみ
  # j = その期で授業コマ文だけ回すため
  day = !value[19][0].empty? ? value[19][i][j]["day"] : "なし"
  period = !value[19][0].empty? ? value[19][i][j]["period"] : "なし"
  classroom = !value[19][0].empty? ? value[19][i][j]["classroom"] : "なし"
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
           day ,
           period ,
           classroom,
           value[20] )
end

def json_format(csv , json_file_path, count = 0)
  JSON.parse(File.open(json_file_path).read).each do |hash| #open json to parse
    count = count + 1
    if hash.values[19][0].empty?
      # たまにある授業時間割がない場合
      csv << insert_element(hash.values, hash.values[18], 0, 0)
    elsif hash.values[18].include?("通年")
      k = 0
      l = 0
      hash.values[19][0].map do
        csv << insert_element(hash.values, "春学期", 0, k)
        puts "通年0 #{insert_element(hash.values, "春学期", 0, k)}"
        k = k + 1
      end
      hash.values[19][1].map do
        csv << insert_element(hash.values, "秋学期", 1, l)
        puts "通年1 #{insert_element(hash.values, "秋学期", 1, l)}"
        l = l + 1
      end
    elsif hash.values[19][0].length > 1
      # 通年以外(春か秋かのみ) かつ 2コマ以上 の場合 ※ただし、微積などの場合は通年であり かつ 半期ごとに２コマ以上あるのでその場合は、注意する。
      next if hash.values[18].include?("通年")
      j = 0
      hash.values[19][0].map do
        puts "通年以外(春か秋かのみ) かつ 2コマ以上 の場合"
        csv << insert_element(hash.values, hash.values[18], 0, j)
        j = j + 1
      end
    else
      puts "else文ですね"
      next if hash.values[18].include?("通年") || hash.values[19][0].length > 1
      csv << insert_element(hash.values, hash.values[18], 0, 0)
    end
    puts "#{count}\n"
  end
end


CSV.open(csv_file_path, "w") do |csv| #open new file for write
  (1..6).each do |i|
    json_format(csv, "json/sss/sss_#{i}.json")
    puts "#{i}"
  end
end
