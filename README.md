objC-syllable-counter
=====================

A helper class to count the number of syllables in a word and in a series of words. ARC compatible. 

This is the objective-c port of the Ruby port created by [Mark Joslin](https://github.com/joslinm). The original script in php can be found [here](http://www.russellmcveigh.info/content/html/syllablecounter.php).

To Use
------
To get RegexKitLite working, go to the project target, other linker flags, and add '-licucore'. Also link the libicucore.A.dylib library in build phases. Since RegexKitLite is not ARC compatible, add the '-fno-objc-arc' flag in the compile sources.

There are two class methods, one to count the syllables in a words, and one to count syllables in multiple words.

`int syllable_count = [SyllableCounter SyllableCountForWord:@"happy"]`

`int syllable_count = [SyllableCounter SyllableCountForWords:@"coding is fun"]`