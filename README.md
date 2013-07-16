Firefox session recovery
========================

A tool thaht helps you to recover your opened tabs

Warning
=======

* You MUST NOT restart Firefox again, otherwise the session backup file (sessionstore.bak) will be overwritten.

Requirements
============

* [Ruby](http://www.ruby-lang.org/) and [Bundler gem](http://gembundler.com/)

Usage
=====

1.  You open Firefox and discover that all the tabs get lost.
2.  Open the History menu. If the 'Restore Previous Session' option is greyed out, continue reading.
3.  Open the Help menu and click on 'Troubleshooting Information'.
4.  Click the button 'Open Containing Folder' next to 'Profile Directory'.
5.  Quit Firefox.
6.  Backup the profile folder in a safe place (in case of...).
7.  Delete the sessionstore.js file and rename the file sessionstore.bak by sessionstore.js.
8.  Start Firefox. If your tabs are not recovered, continue reading.
9.  Copy sessionstore.bak file into the folder containing this README file.
10. Open a [terminal](http://en.wikipedia.org/wiki/Terminal_emulator) and launch recovery.rb script (type 'ruby /path/to/this/folder/recovery.rb').
11. Replace the sessionstore.js file (into the profile folder) by the generated one (close to this README file).
