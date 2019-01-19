require "json"
require "csv"

csv_file_path = "eva_csv/hss.csv"

def eva_return(hash)
  return "なし" if hash["evaluation_method"].nil?
  return "なし" if hash["evaluation_method"].empty?

  hash["evaluation_method"]
end

def insert_element(hash, term, i, j)
  # i = 通年かどうかで決まる 基本的に0のみ
  # j = その期で授業コマ文だけ回すため
  day = !hash["metadata"][0].empty? ? hash["metadata"][i][j]["day"] : "なし"
  period = !hash["metadata"][0].empty? ? hash["metadata"][i][j]["period"] : "なし"
  classroom = !hash["metadata"][0].empty? ? hash["metadata"][i][j]["classroom"] : "なし"
  evaluation_method = eva_return(hash)
  [].push( hash["year"] ,
           hash["place"] ,
           hash["name"] ,
           hash["professor"] ,
           hash["time"] ,
           hash["category"] ,
           hash["target_grade"] ,
           hash["credit"] ,
           hash["classroom"] ,
           hash["campus"] ,
           hash["language"] ,
           hash["field_large"] ,
           hash["field_middle"] ,
           hash["field_small"] ,
           hash["level"] ,
           hash["form"] ,
           hash["open_course"] ,
           hash["full_od"] ,
           term ,
           day ,
           period ,
           classroom,
           hash["textbook"] || "なし",
           evaluation_method )
end

def json_format(csv , json_file_path, count = 0)
  JSON.parse(File.open(json_file_path).read).each do |hash| #open json to parse
    count = count + 1
    if hash["metadata"][0].empty?
      # たまにある授業時間割がない場合
      csv << insert_element(hash, hash["term"], 0, 0)
    elsif hash["term"].include?("通年")
      k = 0
      l = 0
      hash["metadata"][0].map do
        csv << insert_element(hash, "春学期", 0, k)
        puts "通年0 #{insert_element(hash, "春学期", 0, k)}"
        k = k + 1
      end
      hash["metadata"][1].map do
        csv << insert_element(hash, "秋学期", 1, l)
        puts "通年1 #{insert_element(hash, "秋学期", 1, l)}"
        l = l + 1
      end
    elsif hash["metadata"][0].length > 1
      # 通年以外(春か秋かのみ) かつ 2コマ以上 の場合 ※ただし、微積などの場合は通年であり かつ 半期ごとに２コマ以上あるのでその場合は、注意する。
      next if hash["term"].include?("通年")
      j = 0
      hash["metadata"][0].map do
        puts "通年以外(春か秋かのみ) かつ 2コマ以上 の場合"
        csv << insert_element(hash, hash["term"], 0, j)
        j = j + 1
      end
    else
      next if hash["term"].include?("通年") || hash["metadata"][0].length > 1
      csv << insert_element(hash, hash["term"], 0, 0)
    end
    puts "#{count}\n"
  end
end


CSV.open(csv_file_path, "w") do |csv| #open new file for write
  (1..11).each do |i|
    json_format(csv, "json/hss/hss_#{i}.json")
    puts "#{i}"
  end
end
