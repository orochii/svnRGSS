# SVN RGSS Compatibility Layer

## Introduction
These are tools for easing the pains when working on RGSSS RPG Maker games and subversion control (Github, etc). The main purpose is to
- Extract scripts into their separate plain text files (extension .rb).
- Compile all binary files into YAML files, which are also simple text files.
The motive of this is because of SVN systems having an easier time when dealing with text files, while binary files are usually from hard to impossible to work with when using subversion systems and repositories.
It also includes an easy-to-use script extractor, which exposes scripts also as plain text files. As a secondary convenience this lets you use your preferred code editor instead of RPG Maker's built-in not-so-great one.

## Project setup

### Dependencies
Install the following software.
- Github Desktop (or your Git frontend of preference). https://desktop.github.com/
- Ruby. https://rubyinstaller.org/downloads/ (direct DL link: https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-3.0.3-1/rubyinstaller-3.0.3-1-x64.exe)
Use default settings for both installations.

### Project setup
After having installed Ruby, copy all files from this repository into your RPG Maker project's root file. Then run the file **install.rb** to extract all scripts.

### Usage
These are instructions based on Github Desktop.
- When working, remember to always press **fetch** in the **Github Desktop** application. Then go to the project, and double click the file **pack.rb**. 
- Make any changes in the RPG Maker editor, then after closing the editor, double click on **unpack.rb**.
- Finally, use the Github Desktop application to commit any changes made.

# Accreditations
This work is highly derivative, as it was based on work from others to cross-convert from Ruby binaries to YAML and backwards.

- bluepixelmike - https://github.com/bluepixelmike/rpg-maker-rgss
- Rakudayo - https://github.com/rakudayo/rmxp-plugin-system
- Solistra - https://github.com/Solistra/rvpacker
