def procdir(dirname)
  data = ''
  begin
    d = Dir.new(dirname)
  rescue => error
    #puts "ERROR: #{error.message}";
    return data;
  end
  Dir.foreach(dirname) do |dir| 
    dirpath = dirname + '/' + dir
    if File.directory?(dirpath) && !File.symlink?(dirpath) then
      if dir != '.' && dir != '..' then
            data += procdir(dirpath)
      end
    else
      $files << dirpath;
      data += dirpath
    end
  end
  return data
end

$files = [];

n = ARGV.size
if (n==0) 
  puts "Bad arguments. Please enter the name of the directory, for example:\r\n ruby main.rb /home/kim/Homework/"
else 
  procdir(ARGV[0])
end

#..Filtering
filter = []
$files.each do |x|
  next if (/(.*([dD][oO][cC])$)|(.*([pP][dD][fF])$)/ === x)
  filter << x
end

#..Sorted
sort_files = filter.sort
puts sort_files.join("\n")

#..Save to file
file = File.new('list.txt', 'w')
file.write(sort_files.join("\n"))
file.close