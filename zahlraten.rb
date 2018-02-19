#kontrolle ob es um den richtigen zahl geht
schleife = 3
Zahl = 29
  p "Sie haben #{schleife} Versuche "
while schleife >0
    p "Bitte zahl zum raten eingeben :"
  eingabe = gets
  eingabe = eingabe.to_i
  #eingabe = eingabe.to_i
  if eingabe > 29
    p "zahl ist grösse"
    p "Sie haben noch #{schleife - 1} Versuche "
  elsif eingabe< 29
    p "zahl ist zu klein"
    p "Sie haben noch #{schleife - 1} Versuche "
  elsif eingabe == Zahl
    p "zahl : #{eingabe} ist richtig"
    schleife = 0
  else eingabe == -1
    schleife = 0
  end
  schleife -= 1
end
