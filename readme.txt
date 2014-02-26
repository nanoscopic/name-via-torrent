Name Via Torrent 1.0
Copyright (C) 2014 David Helkowski
License: CC BY-NC-ND 3.0, license.txt, http://creativecommons.org/licenses/by-nc-nd/3.0/

The included run-rename.pl perl script was created to helpfully rename a bunch of files that you have proper
naming about via a torrent file. This is possible by way of embedded CRC hash information within torrent files.
Note that not all torrent files have such embedded hash information, so this may not always be possible or work.

Contact information:
I can be contacted at name-via-torrent@codechild.com if you wish to for any reason. Please send a short thank you
my way if this script is helpful to you.

Known bugs:
- Some torrent files spit out errors ( the errors come from the underlying Net::BitTorrent:Torrent dependency )

Todo:
- Update the script to use CRC values embedded in filenames using square brackets if they exist and the torrent itself
  does not have CRC values.

Version History:
1.0: Initial release to github