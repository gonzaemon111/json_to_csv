require "csv"

ALL_COURCES = %w(
  ase
  cms
  cse
  edu
  fse
  hss
  hum
  pse
  sils
  sps
  sss
).freeze

def row_evaluate(eva)
  return nil if eva == "なし"
  puts "row[23].class : #{eva.class}"
  # puts "row[23].to_a.class : #{eva.to_a.class}"
  puts "eva : #{eva}"
  eva
end

# ALL_COURCES.map do |cource|
  CSV.foreach("eva_csv/ase.csv") do |row|
    # (name: row[0], sales_date: row[1], price: row[2])
    puts "#{row[0]} #{row[1]} #{row[2]} #{row[3]} #{row[4]} #{row[5]} #{row[6]} #{row[7]} #{row[8]} #{row[9]}"
    puts "#{row[10]} #{row[11]} #{row[12]} #{row[13]} #{row[14]} #{row[15]} #{row[16]} #{row[17]} #{row[18]} #{row[19]}"
    puts "#{row[20]} #{row[21]} #{row[22]} #{row_evaluate(row[23])}"

    puts "---------- \n"
    puts "row : #{row}"
    puts "---------- \n"
  end
# end