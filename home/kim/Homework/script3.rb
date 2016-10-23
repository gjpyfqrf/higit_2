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
            #puts "DIRECTORY: #{dirpath}" ;
            data += procdir(dirpath)
      end
    else
        if !(/(.*([dD][oO][cC])$)|(.*([pP][dD][fF])$)/ === dirpath) then
           puts "   files: #{dirpath}";
        end   
      data += dirpath
    end
  end
  return data
end

puts("...... start .......");
procdir('/home/kim/Homework/');