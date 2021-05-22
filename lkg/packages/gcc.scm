;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2021 Liāu, Kiong-Gē <gliao.tw@pm.me>
;;;
;;; This file is NOT part of GNU Guix.
;;;
;;; This program is free software: you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define-module (lkg packages gcc)
  #:use-module (guix packages)
  #:use-module (guix memoization)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (gnu packages gcc)
  #:use-module (srfi srfi-1))

(define-public libgccjit-11
  (package
    (inherit gcc-11)
    (name "libgccjit")
    (outputs (delete "lib" (package-outputs gcc)))
    (properties (alist-delete 'hidden? (package-properties gcc)))
    (arguments
     (substitute-keyword-arguments `(#:modules ((guix build gnu-build-system)
                                                (guix build utils)
                                                (ice-9 regex)
                                                (srfi srfi-1)
                                                (srfi srfi-26))
                                     ,@(package-arguments gcc))
       ((#:configure-flags flags)
        `(append `("--enable-host-shared"
                   ,(string-append "--enable-languages=jit"))
                 (remove (cut string-match "--enable-languages.*" <>)
                         ,flags)))
       ((#:phases phases)
        `(modify-phases ,phases
           (add-after 'install 'remove-broken-or-conflicting-files
             (lambda* (#:key outputs #:allow-other-keys)
               (for-each delete-file
                         (find-files (string-append (assoc-ref outputs "out") "/bin")
                                     ".*(c\\+\\+|cpp|g\\+\\+|gcov|gcc|gcc-.*)"))
               #t))))))
    (synopsis "GCC library generating machine code on-the-fly at runtime")
    (description
     "This package is part of the GNU Compiler Collection and provides an
embeddable library for generating machine code on-the-fly at runtime.  This
shared library can then be dynamically-linked into bytecode interpreters and
other such programs that want to generate machine code on-the-fly at run-time.
It can also be used for ahead-of-time code generation for building standalone
compilers.  The just-in-time (jit) part of the name is now something of a
misnomer.")))
