require 'digest'

#testen mittels kj-bible.txt
def test_pass(value,salt)
  File.foreach('C:\Users\anoua\Documents\GitHub\Ruby\kj-bible.txt') do |word|
    kelma =salt+ (Digest::MD5.hexdigest (word.chomp))
    if kelma == value
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
# test mittels transform.txt
def test_pass_transform(value,salt)
  File.foreach('C:\Users\anoua\Documents\GitHub\Ruby\transform.txt') do |word|
    kelma =salt+ (Digest::MD5.hexdigest (word.chomp))
    if kelma == value
      return puts '[+] Found Password: ' + word
    end
    end
  puts '[-] Password Not Found'#end
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
