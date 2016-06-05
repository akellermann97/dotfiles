# Dormio's dotfiles
Here are some of the dotfiles I use for various programs. Right now you can find dotfiles for
- i3 (Window Manager)
- Neovim and Vim (Text Editors)
- i3 blocks (status_command for i3)
- Rofi (which is a replacement for dmenu)
- i3-gaps (a fork of i3 that adds gaps)
- Termite which is my choice of terminal emulator if I'm not on Mac OS X

### Dependencies for i3
- I use rofi as a replacement for demenu, it's a personal preference, as they both operate almost exactly the same.
- i3blocks instead of the regular i3 status, but I haven't done much with it.

## Dependencies for Nvim/vim
- Vim Plug (needs to be installed for the rest of the file to work. Once installed everything else should operate as expected.)
- Python3 needs to be installed in order deoplete to work

#### Some notes
These files haven't been tested on a variety of machines, so you may find that some things do not work
straight out of the box.

#### Known Issues
Stuff like the .Xresources is Linux specific, and serves no purpose on a machine
running MAC OS X

the .zshrc was created and maintained on a Mac, so the directories for certain
things needs to be changed in order for someone to use it on Linux

All of the linux based dotfiles are at the moment Fedora specific, because it's
the distribution of my choice.
