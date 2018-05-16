require 'digest'
require_relative 'PBKDF2'
$found = false
# Array of acceptable characters
chars = 'a'.upto('z').to_a + 0.upto(9).to_a
#PBKDF2 hash funktion
def hash(salt, password, iteration)
   hashedValue = PBKDF2.new do |x|
    x.password = password
    x.salt = salt
    x.iterations = iteration
   end
  hashedValue.hex_string
end
#convert to MD5 Hash code
def md5(password)
  Digest::MD5.hexdigest(password)
end

#testen with kj-bible.txt
def test_pass(value,salt,iteration)
  File.foreach('C:\Users\anoua\Documents\GitHub\Ruby\kj-bible.txt') do |word|
    kelma =hash(salt,word.chomp,iteration)
    if kelma == value
      $found = true
      return puts '[+] Found Password: ' + word

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
      $found = true
    end
    end
  puts '[-] Password Not Found'#end
end

# Compares the given hash to the md5 hash of the given potential password
def cracked?(secret_password_hash, potential_password,salt)
  pass = hash(salt,potential_password,1000)
  secret_password_hash == pass

end

################################################################################
# Brute Force Attempt (5 chars max)
################################################################################
def crack_5(secret_password_hash, chars,salt)
  chars.each do |x|
    wort = "#{x}"
    return puts '[+] 1 char Found Password:' + wort if cracked?(secret_password_hash, wort,salt)
    chars.each do |y|
      wort = "#{x}#{y}"
      return puts '[+] 2 char Found Password:'  + wort if cracked?(secret_password_hash, wort,salt)
      chars.each do |z|
        wort = "#{x}#{y}#{z}"
        return puts '[+] 3 char Found Password:'  + wort if cracked?(secret_password_hash, wort,salt)
        chars.each do |w|
          wort = "#{x}#{y}#{z}#{w}"
          return puts '[+] 4 char Found Password:'  + wort if cracked?(secret_password_hash, wort,salt)
          chars.each do |q|
            wort = "#{x}#{y}#{z}#{w}#{q}"
            return puts '[+] 5 char Found Password:'  + wort if cracked?(secret_password_hash, wort,salt)
          end
        end
      end
    end
  end
  puts "fehler"
end
    #hash("salt","4037844e6aa2ab4a2a34df0860444714c528352dddfb3417bc56950bf3cbd012",1000)
  	puts 'Password eingeben :'
    eingabe = gets.chomp
    text = eingabe.split('|')
    $salt = text[0].chomp
    $hashpass = text[1].chomp
    $iteration = text[2].chomp
#    puts"**************Testing words from 'kj-bible.txt'...********************"
#  test_pass(pwd,$salt,$iteration.to_i)
#    puts"'********************bullshit.txt'...transformation to 'test.txt'*******"
#    trans_txt()
#    puts"**************Testing words from 'transform.txt'...********************"
#    test_pass_transform(eingabe,salt)
#    puts"**************BRUTE FORCE...********************"
  #  if !$found
#    test_pass($hashpass,$salt,$iteration.to_i)
#  end
    if !$found
      crack_5($hashpass, chars,$salt)
    end
