# A fork from flat's guix channel

This is a fork of [FlatWhatson's channel][flatwhatson-guix]. 

## Packages

### gccemacs-pgtk-lkg
This package merge with master and pgtk branch with `face-attribeute` function replaced, 
the motivation of `gccemacs-face-buffer-local-first.patch` can be found at [emacs-devel-disucssion][emacs-devel-fbl]

### libgccjit-11

An updated `libgccjit` package based on `gcc-11`. 

## Usage

### via load-path

The simplest way to use this channel is to temporarily add it to Guix's
load-path:

``` shell
git clone https://github.com/GongYiLiao/guix-channel.git
guix install -L ./guix-channel gccemacs-pgtk-lkg
```

### via channels.scm

WIP


## License

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program.  If not, see <http://www.gnu.org/licenses/>.

See [COPYING](COPYING) for details.

[guix]: https://guix.gnu.org/
[guix-channel]: https://guix.gnu.org/manual/en/html_node/Channels.html
[gccemacs]: https://www.emacswiki.org/emacs/GccEmacs
[masm11-pgtk]: https://github.com/masm11/emacs/tree/pgtk
[flatwhatson-pgtk]: https://github.com/flatwhatson/emacs/tree/pgtk-nativecomp
[flatwhatson-guix]: https://github.com/flatwhatson/guix-channel
[emacs-devel-fbl]: https://mail.gnu.org/archive/html/emacs-devel/2021-03/msg01425.html
