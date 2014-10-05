require 'rubygems'
require 'sparql/client'

def clean(s)
  index = s.index " "
  unless index
    s
  else
    s[0...index]
  end
end

def get_names(category, lang)
  query = """SELECT ?label WHERE {
   ?subject rdfs:label ?label .
   ?subject dcterms:subject <http://dbpedia.org/resource/Category:#{category}> .
   FILTER(LANG(?label) = \"\" || LANGMATCHES(LANG(?label), \"#{lang}\"))
  }"""
  client = SPARQL::Client.new("http://dbpedia.org/sparql")
  result = client.query(query)
  names = []
  result.each do |e|
    names << (clean (e.first[1].value))
  end
  names
end

def save_names(category, lang, filename)
  names = get_names(category, lang)
  puts "[#{lang}] #{category} : saving #{names.count} names in #{filename}"
  File.open(filename, 'w') do |file| 
    file.write(names.join "\n")
    file.write("\n")
  end
end

countries = [
  { :lang => "Italian",   :code => "it"}, 
  { :lang => "French",    :code => "fr"}, 
  { :lang => "German",    :code => "de"}, 
  { :lang => "Japanese",  :code => "en"}, 
  { :lang => "Dutch",     :code => "nl"}, 
  { :lang => "Norwegian", :code => "en"}, 
  { :lang => "Finnish",   :code => "en"}, 
  { :lang => "Arabic",    :code => "en"}
]

countries.each do |country|
  save_names("#{country[:lang]}_masculine_given_names",country[:code],"../personnames/#{country[:lang]}_male.txt")
  save_names("#{country[:lang]}_feminine_given_names",country[:code],"../personnames/#{country[:lang]}_female.txt")
end