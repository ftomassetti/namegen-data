namegen-data
============

This project contains lists of names. These lists of names are intended as input for name generators, such as [namegen-haskell](https://github.com/ftomassetti/namegen-haskell).

Cities names
============

A list of cities from all countries was obtained from https://www.maxmind.com/en/worldcities.
The file was processed with an application written in Haskell (see the Haskell directory for details).
The files generated are:

directory _citynames_:

* citynames_ch.txt  
* citynames_de.txt  
* citynames_eg.txt  
* citynames_es.txt  
* citynames_fr.txt  
* citynames_it.txt  
* citynames_jp.txt  
* citynames_pl.txt

Each of these files contain tens of thousands of names.

Person names
============

A list of person names was obtained from DBPedia.
DBPedia was queries with an application written in Ruby (see the Ruby directory for details).
The files generated are:

directory _personnames_:

* Arabic_female.txt
* Arabic_male.txt
* Dutch_female.txt
* Dutch_male.txt
* Finnish_female.txt
* Finnish_male.txt
* French_female.txt
* French_male.txt
* German_female.txt
* German_male.txt
* Italian_female.txt
* Italian_male.txt
* Japanese_female.txt
* Japanese_male.txt
* Norwegian_female.txt
* Norwegian_male.txt

Each of these files contain tens of names.
