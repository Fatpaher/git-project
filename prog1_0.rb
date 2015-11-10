require "CSV"
human_movie = []
human_others = []
human_black = []


def writing_to_files(file_name,human_array, headers = nil)
  CSV.open(file_name, "wb", write_headers: true, headers: headers) do |csv|
      human_array.each do |human_line|
      csv << human_line
    end
  end
end

#model,code,color,category,price,weight колонки в файле silly_humans.csv

CSV.foreach("./silly_humans.csv", {:headers => true, :header_converters => :symbol}) do |line|
  if line[:color] == 'black'
    human_black << line
  else
    if line[:category] == 'Movies'
      human_movie << line
    else
      human_others << line
    end
  end
end

# 0,3,5 колонки оставляем по ТЗ
human_black.map! do |line|
  [line[:model],  line[:category], line[:weight]]
end

headers = File.readlines("./silly_humans.csv").first.strip.split(',')

writing_to_files("./awsome_people.csv", human_black, [:model, :category, :weight])
writing_to_files("./movie_lovers.csv", human_movie, headers)
writing_to_files("./not_so_silly_humans.csv", human_others, headers)
