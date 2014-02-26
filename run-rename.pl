#!/usr/bin/perl -w

# run-rename.pl
# Main script of 'Name Via Torrent' project
# Copyright (C) 2014 David Helkowski
# License: CC BY-NC-ND 3.0, license.txt, http://creativecommons.org/licenses/by-nc-nd/3.0/

use strict;

my $err = '';

eval('use Net::BitTorrent::Torrent;');
if( $@ ) {
  $err .= "The CPAN module Net::BitTorrent::Torrent must be installed to use this script.\n\n";
}

my $fname = $ARGV[0] || 'example.torrent';
my $dir   = $ARGV[1] || 'example_files';

if( ! -e $fname ) {
  $err .= "Torrent file [$fname] does not exist.\n";
  if( !$ARGV[0] ) {
    $err .= "Perhaps you meant to specify your torrent file on the command line?\n";
  }
  $err .= "\n";
}
if( ( ! -d $dir ) && $ARGV[1] ) {
  $err .= "Directory containing files [$dir] does not exist.\n";
  #if( !$ARGV[1] ) {
  #  $err .= "Perhaps you meant to specify your a directory of where your files to rename are?\n";
  #}
  $err .= "\n";
}
my $head = "Name Via Torrent Version 1.0\n----------------------------\n";
if( !$ARGV[0] || $err ) {
  $err .= "Rename some files from a torrent:\n";
  $err .= "./run-rename.pl some_torrent.torrent /some_path/folder_containing_files_to_rename\n\n";
  
  $err .= "Dump out CRC information from a torrent file:\n";
  $err .= "./run-rename.pl some_torrent.torrent\n\n";
  
  $err = $head . $err;
  print STDERR $err;
  if( $ARGV[0] ) {
    exit;
  }
}

my $showinfo = 0;
if( $ARGV[0] && !$ARGV[1] ) {
  $showinfo = 1;
}

print $head;

my $torrent = new Net::BitTorrent::Torrent( { Path => $fname, BaseDir => 'z:\\' } );

my $files = $torrent->files();

my %crchash;
if( !@$files ) {
  print "No files found in torrent [$fname]\n";
  exit;
}
my $torcnt = 0;
for my $file ( @$files ) {
  $torcnt++;
  my $path = $file->path();
  $path =~ s/Z:[\/]//i;
  print "File:$path\n" if( $showinfo );
  if( $path =~ m|.+\\(.+)| ) {
    $path = $1;
  }
  while( $path =~ m|\[([A-Z0-9]{8})\]|g ) {
    print "CRC:$1\n" if( $showinfo );
    $crchash{ $1 } = $path;
  }
}
print "Number of files found in torrent: $torcnt\n";

if( $showinfo ) {
  exit;
}

opendir( DIR, $dir );
my @files2 = readdir( DIR );
closedir( DIR );

if( !@files2 ) {
  print "No files in dir $dir\n";
  exit;
}

my $matchcnt = 0;
my $rencnt = 0;
my $ok = 0;
LOOP1:
for my $file ( @files2 ) {
  next if( $file =~ m|^\.+$| );
  my $found = 0;
  while( $file =~ m|\[([A-Z0-9]{8})\]|g ) {
    my $hash = $1;
    $found = 1;
    if( $crchash{ $hash } ) {
      my $destname = $crchash{ $hash };
      if( $destname eq $file ) {
        $ok++;
        next LOOP1;
      }
      $rencnt++;
    }
  }
  if( $found ) {
    $matchcnt++;
  }
}
if( $ok == $torcnt ) {
  print "All files named correctly\n";
  exit;
}
if( $ok ) {
  print "Files found named correctly: $ok\n";
}
print "Can rename $rencnt/$matchcnt in directory\n";

LOOP:
for my $file ( @files2 ) {
  next if( $file =~ m|^\.+$| );
  my $found = 0;
  while( $file =~ m|\[([A-Z0-9]{8})\]|g ) {
    my $hash = $1;
    $found = 1;
    if( $crchash{ $hash } ) {
      my $destname = $crchash{ $hash };
      next LOOP if( $destname eq $file );
      print "Rename $file to $destname?\n\n";
      my $yn = <STDIN>;
      if( $yn =~ m|[yY]| ) {
        rename( "$dir/$file", "$dir/$destname" );
        next LOOP;
      }
    }
  }
  if( !$found ) {
    print "No match found for $file\n";
  }
  #print "$file\n";
}

