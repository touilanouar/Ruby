require 'digest'

# Array of acceptable characters
chars = 'a'.upto('z').to_a + 0.upto(9).to_a

#convert to MD5 Hash code
def md5(password)
  Digest::MD5.hexdigest(password)
end

#testen with kj-bible.txt
def test_pass(value,salt)
  File.foreach('C:\Users\anoua\Documents\GitHub\Ruby\kj-bible.txt') do |word|
    kelma =salt+ (Digest::MD5.hexdigest (word.chomp))
    if kelma == value
      return puts '[+] Found Password: ' + word
      break;
    end
    end
  puts '[-] Password Not Found'#end
end

# transformation
def trans_txt()
  datastring = ""
  File.foreach('C:\Users\anoua\Documents\GitHub\Ruby\bullshit.txt') do |word|
    datastring = datastring + word.gsub("a","3")
    end
    data = File.new('C:\Users\anoua\Documents\GitHub\Ruby\transform.txt', "w")
    data.write(datastring)
    data.close
    puts"Datei transformed..."
end

# test with transform.txt
def test_pass_transform(value,salt)
  File.foreach('C:\Users\anoua\Documents\GitHub\Ruby\transform.txt') do |word|
    kelma =salt+ (Digest::MD5.hexdigest (word.chomp))
    if kelma == value
      return puts '[+] Found Password: ' + word
      break;
    end
    end
  puts '[-] Password Not Found'#end
end

# Compares the given hash to the md5 hash of the given potential password
def cracked?(secret_password_hash, potential_password,salt)
  pass = (salt + md5(potential_password))
  puts pass
  secret_password_hash == pass
end

################################################################################
# Brute Force Attempt (5 chars max)
################################################################################
def crack_3(secret_password_hash, chars,salt)
  chars.each do |x|
    wort = "#{x}"
    return puts '[+] 1 char Found Password:'+ wort if cracked?(secret_password_hash, wort,salt)
    chars.each do |y|
      wort = "#{x}#{y}"
      return puts '[+] 2 char Found Password:'+ wort if cracked?(secret_password_hash, wort,salt)
      chars.each do |z|
        wort = "#{x}#{y}#{z}"
        return puts '[+] 3 char Found Password:'+ wort if cracked?(secret_password_hash, wort,salt)
        chars.each do |w|
          wort = "#{x}#{y}#{z}#{w}"
          return puts '[+] 4 char Found Password:'+ wort if cracked?(secret_password_hash, wort,salt)
          chars.each do |q|
            wort = "#{x}#{y}#{z}#{w}#{q}"
            return puts '[+] 5 char Found Password:'+ wort if cracked?(secret_password_hash, wort,salt)
          end
        end
      end
    end
  end
  puts "fehler"
end

  	puts 'Password eingeben :'
    eingabe = gets.chomp
    salt = eingabe[0, 2]
    puts"**************Testing words from 'kj-bible.txt'...********************"
    test_pass(eingabe,salt)
    puts"'********************bullshit.txt'...transformation to 'test.txt'*******"
    trans_txt()
    puts"**************Testing words from 'transform.txt'...********************"
    test_pass_transform(eingabe,salt)
    puts"**************BRUTE FORCE...********************"
    crack_3(eingabe, chars,salt)
