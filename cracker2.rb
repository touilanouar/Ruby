require_relative 'PBKDF2'

class Cracker

attr_reader :salt, :hashedPwd, :bullshitFile , :transformationFile

  def initialize(salt,hashedPwd,bullshitFile,transformationFile)
    @salt = salt
    @hashedPwd = hashedPwd
    @bullshitFile = bullshitFile
    @transformationFile = transformationFile
  end



  def compareTo_bullshit
          ret = nil
          File.open(@bullshitFile, "r") do |file|
          while(bullshit = file.gets)

              if hash(@salt , bullshit.strip, 1000).eql? @hashedPwd
                  return ret = bullshit
              end

          end
        ret
   end
  end

  def compareToTransformed_bullshit
    ret = nil
    File.open(@bullshitFile, "r") do |file|
    while(bullshit = file.gets)

        transformedBullshit = transform_bullshit(bullshit.strip)

          if hash(@salt,transformedBullshit, 1000).strip.eql? @hashedPwd
            return   ret = transformedBullshit
          end

    end
   ret
  end
end

 def transform_bullshit(bullshit)
      File.open(@transformationFile,"r") do |file|
      while(tranformRegex = file.gets)
        arr = tranformRegex.strip.split(',');
        bullshit=bullshit.gsub(/#{arr[0]}/,arr[1])
      end
       bullshit
    end
 end


 def theForceBeWithyou
    chars = ('A' .. 'z').to_a
    chars = (1 .. 2).flat_map{|size|
    ret = nil
      puts "testing for #{size} characters .."
      b = chars.repeated_permutation(size).map(&:join)
      b.each{|perm|
        if  hash(@salt,perm,1000).eql? @hashedPwd
          return ret = perm
        end
      }
      puts "Nothing's found"

    }
 end


  def hash(salt, password, iteration)
     hashedValue = PBKDF2.new do |x|
      x.password = password
      x.salt = salt
      x.iterations = iteration
     end
    hashedValue.hex_string
  end

 def bullshitFile_Array
    arr = []
    File.open(@bullshitFile, "r") do |file|
      while(line = file.gets)
      arr << line.strip
    end
    arr
  end
end

  def crackIt!
    puts "comparing to usual bullshit ..."
    pwd = compareTo_bullshit
    unless pwd.nil?
      puts "Password found: #{pwd.strip}"
    else
      puts "Nothing's found"
      puts "comparing to transformed bullshit ..."
      pwd = compareToTransformed_bullshit
      unless pwd.nil?
        puts "Password found: #{pwd.strip}"
       else
         puts "Nothing's found"
         puts "May the force be with you ..."
         pwd = theForceBeWithyou
          unless pwd.nil?
            puts "Password found: #{pwd.strip}"
          else
          puts "Nothing's found"
        end
       end
    end
  end

end
cracker = Cracker.new("salty","4037844e6aa2ab4a2a34df0860444714c528352dddfb3417bc56950bf3cbd012",'C:\Users\anoua\Documents\GitHub\Ruby\kj-bible.txt','C:\Users\anoua\Documents\GitHub\Ruby\transform.txt')
cracker.crackIt!





cracker.crackIt!
