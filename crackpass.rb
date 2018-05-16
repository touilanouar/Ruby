require_relative 'PBKDF2'
# Array of acceptable characters
chars = 'a'.upto('z').to_a + 0.upto(9).to_a

# Von der kommandozeile die parameter einlesen

eingabe = ARGV[0]
f1 = ARGV[1]
f2 = ARGV[2]
option = ARGV[3]

#salt , Passwort, iteration durch splitten bestimmen

hash = eingabe.split('.')
salt = hash[0]
hashpass = hash[1]
iteration = hash[2].to_i

# methode um die hashwerte der wörte zu bestimmen
def hash(salt, password, iteration)
   hashedValue = PBKDF2.new do |x|
    x.password = password
    x.salt = salt
    x.iterations = iteration
   end
  hashedValue.hex_string
end

# test von bullshit.txt
def test_bullshit(f1,hashpass,salt,iteration,option)
  succes = nil
  counter = 1
  lines = File.foreach(f1).count
  begin
    File.open(f1).each do |line|
      if option == "-v"
        frsch = counter * (100.0/lines)
        printf("\r%15s: [%-100s]","#{line.chomp}", "=" * (frsch))
      end
      sleep(0.1)
      if cracked?(hashpass, line.chomp,salt,iteration,option)
        return succes = line
      end
      counter += 1
    end
    puts""
    succes
  rescue => err
  puts "Exception: #{err}"
  end
end
# bullshit transformieren und in transform.txt schreiben danach testen von transform.txt
def test_transform(f1,f2,hashpass,salt,iteration,option)
  succes = nil
  begin
    datastring = ""
    File.open(f1).each do |line|
          datastring = datastring + line.gsub("a","4")
    end

    file2 = File.new(f2,"w")
    file2.write(datastring)
    file2.close
    counter = 1
    lines = File.foreach(f2).count
    File.open(f2).each do |line|
      if option == "-v"
      fr = counter * (100.0/lines)
      printf("\r%15s: [%-100s]","#{line.chomp}", "=" * (fr))
      end
      if cracked?(hashpass, line.chomp,salt,iteration,option)
        return succes = line
      end
      counter +=1
    end
    puts ""
    succes

  rescue => err
    puts "Exception: #{err}"
  end
end
#hilfsmethode um die hashcodes zu vergleichen
def cracked?(secret_password_hash, potential_password,salt,iteration,option)
  pass = hash(salt,potential_password,iteration)
  if option =="-v"
    printf("\r%-15s","#{potential_password}")
  end
  secret_password_hash == pass


end
#brute force attack
def crack_5(secret_password_hash, chars,salt,iteration,option)
  succes = nil
  chars.each do |x|
    wort = "#{x}"
    if cracked?(secret_password_hash, wort,salt,iteration,option)
      return succes = wort
    end
    chars.each do |y|
      wort = "#{x}#{y}"
      if cracked?(secret_password_hash, wort,salt,iteration,option)
        return succes = wort
      end
      chars.each do |z|
        wort = "#{x}#{y}#{z}"
        if cracked?(secret_password_hash, wort,salt,iteration,option)
          return succes = wort
        end
        chars.each do |w|
          wort = "#{x}#{y}#{z}#{w}"
          if cracked?(secret_password_hash, wort,salt,iteration,option)
            return succes = wort
          end
          chars.each do |q|
            wort = "#{x}#{y}#{z}#{w}#{q}"
            if cracked?(secret_password_hash, wort,salt,iteration,option)
              return succes = wort
            end
          end
          succes
        end
        succes
      end
      succes
    end
    succes
  end
  succes

end

#Organisation der Schritte
def main(f1,f2,hashpass,salt,iteration,chars,option)
  puts "bullshit.txt testen ........."
  pwd = test_bullshit(f1,hashpass,salt,iteration,option)
  unless pwd.nil?
    puts"Password gefunden : #{pwd.strip}"
  else
    puts"kein passwort gefunden !"
    puts "transform.txt testen ........."
    pwd = test_transform(f1,f2,hashpass,salt,iteration,option)
    unless pwd.nil?
      puts"Password gefunden : #{pwd.strip}"
    else
      puts "kein passwort gefunden !"
      puts "Brute force attack start ......"
      pwd = crack_5(hashpass, chars,salt,iteration,option)
      unless pwd.nil?
        puts"Password gefunden : #{pwd.strip}"
      else
        puts "kein passwort gefunden !"
      end
    end
  end
end
# programm start
main(f1,f2,hashpass,salt,iteration,chars,option)
