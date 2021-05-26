;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2021 Liāu, Kiong-Gē <gliao.tw@pm.me>
;;;
;;; This file is not part of GNU Guix (yet).
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

(define-module (lkg packages java)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix hg-download)
  #:use-module (guix git-download)
  #:use-module (guix svn-download)
  #:use-module ((guix build utils) #:select (alist-replace))
  #:use-module (guix utils)
  #:use-module (guix build-system ant)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages)
  #:use-module (gnu packages attr)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages certs)
  #:use-module (gnu packages cpio)
  #:use-module (gnu packages cups)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages elf) 
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages ghostscript) ;lcms
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages groovy)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages icu4c)
  #:use-module (gnu packages image)
  #:use-module (gnu packages java-compression)
  #:use-module (gnu packages java)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages linux)     ;alsa
  #:use-module (gnu packages maths)
  #:use-module (gnu packages maven)
  #:use-module (gnu packages maven-parent-pom)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages nss)
  #:use-module (gnu packages onc-rpc)
  #:use-module (gnu packages web)
  #:use-module (gnu packages wget)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages popt)
  #:use-module (gnu packages kerberos)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages texinfo)
  #:use-module ((srfi srfi-1) #:select (fold alist-delete))
  #:use-module (srfi srfi-11)
  #:use-module (ice-9 match))


(define-public openjdk15
  (package
    (inherit openjdk14)
    (name "openjdk")
    (version "15.0")
    (source (origin
              (method url-fetch)
              (uri "https://github.com/openjdk/jdk/archive/refs/tags/jdk-15-ga.tar.gz")
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "04nq17rml83030j1yf2ss2dq3yq38swcgxm9ansqz675wll3hvpq"))
              (modules '((guix build utils)))
              (snippet
               `(begin
                  ;; The m4 macro uses 'help' to search for builtins, which is
                  ;; not available in bash-minimal
                  (substitute* "make/autoconf/basic.m4"
                    (("if help") "if command -v"))
                  (for-each delete-file (find-files "." ".*.(bin|exe|jar)$"))
                  #t))))
    (inputs
     `(("alsa-lib" ,alsa-lib)
       ("cups" ,cups)
       ("fontconfig" ,fontconfig)
       ("freetype" ,freetype)
       ("giflib" ,giflib)
       ("lcms" ,lcms)
       ("libjpeg" ,libjpeg-turbo)
       ("libpng" ,libpng)
       ("libx11" ,libx11)
       ("libxext" ,libxext)
       ("libxrandr" ,libxrandr)
       ("libxrender" ,libxrender)
       ("libxt" ,libxt)
       ("libxtst" ,libxtst)))
    (native-inputs
     `(("autoconf" ,autoconf)
       ("make@4.2" ,gnu-make-4.2)
       ("openjdk14:jdk" ,openjdk14 "jdk")
       ("pkg-config" ,pkg-config)
       ("unzip" ,unzip)
       ("which" ,which)
       ("zip" ,zip)))
    (home-page "https://openjdk.java.net/projects/jdk/15")))
