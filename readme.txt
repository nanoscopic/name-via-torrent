Name Via Torrent 1.0
Copyright (C) 2014 David Helkowski
License: CC BY-NC-ND 3.0, license.txt, http://creativecommons.org/licenses/by-nc-nd/3.0/

The included run-rename.pl perl script was created to helpfully rename a bunch of files that you have proper naming about via a torrent file. 
This is down by using CRC information embedded in filenames within torrent files. Note that not this is only really true for certain types of files,
such as anime fansub releases, so it may not yet be suitable for your desired use. See Todos.

Contact information:
I can be contacted at name-via-torrent@codechild.com if you wish to for any reason. Please send a short thank you my way if this script is helpful to you.

Known features/bugs:
- The module does not compute CRC of files; it depends on existing named files having CRCs in their name, as well as torrent files having the same. Kind of limited.
- Some torrent files spit out errors ( the errors come from the underlying Net::BitTorrent:Torrent dependency )

Todo:
- Create and use an embedded perl torrent parser so that there are no external dependencies
- Use MD5 file hashes if they are present in the torrent
- If filenames contain no CRC and no MD5 hashes are present, default to using filesizes and SHA1 fragment hashes to identify files

Version History:
1.0: Initial release to github

Interesting Links:
- http://www.tvrename.com/about.html
  This program includes a tab that will rename files based on SHA1 fragment hashes
  Source code here: http://code.google.com/p/tvrename/
  The file that processes the torrent files is here: http://code.google.com/p/tvrename/source/browse/trunk/TVRename%23/Utility/BT.cs
  
- http://cpansearch.perl.org/src/QANTINS/BitTorrent-V0.1/lib/BitTorrent.pm
  BitTorrent CPAN package that hashishly reads torrent files.
  With a bit of work I was able to further hack it to extract the 20-byte SHA1 fragment hashes.
  The code is rather... ugly...
  
- http://search.cpan.org/~aristotle/Bencode-1.4/lib/Bencode.pm
  Bencode module; can theoretically rip apart torrent files well.
  Source on github: https://github.com/ap/Bencode/blob/master/lib/Bencode.pm
  
- http://search.cpan.org/~orclev/Convert-Bencode-1.03/lib/Convert/Bencode.pm
  Another Bencode CPAN module
  
- https://wiki.theory.org/BitTorrentSpecification
  Explanation of the structure of torrent files.
  Note the lack of CRC being mentioned anywhere.