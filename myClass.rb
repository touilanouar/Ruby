#Klassen definieren
class MyClass
  puts "Hallo"
  attr_reader :name
  attr_writer :name
  # das muss ich noch verstehen warum und was das tut
  def initialize(name); @name = name; end

end
# wie mein man ein objekt von der klassse erzeugt
c = MyClass.new('Anouar')
# zugriff auf die attribute der klasse  
c.name = 'Touil'
puts c.name
