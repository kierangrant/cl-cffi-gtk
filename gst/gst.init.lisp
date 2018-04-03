;;; ----------------------------------------------------------------------------
;;; gst.init.lisp
;;;
;;; The documentation of this file is taken from the GStreamer Core 1.0
;;; Reference Manual Version 1.14.0 and modified to document the Lisp binding to
;;; the GStreamer library.  See <https://gstreamer.freedesktop.org>.
;;;
;;; Copyright (C) 2018 Olof-Joachim Frahm
;;;
;;; This program is free software: you can redistribute it and/or modify
;;; it under the terms of the GNU Lesser General Public License for Lisp
;;; as published by the Free Software Foundation, either version 3 of the
;;; License, or (at your option) any later version and with a preamble to
;;; the GNU Lesser General Public License that clarifies the terms for use
;;; with Lisp programs and is referred as the LLGPL.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU Lesser General Public License for more details.
;;;
;;; You should have received a copy of the GNU Lesser General Public
;;; License along with this program and the preamble to the Gnu Lesser
;;; General Public License.  If not, see <http://www.gnu.org/licenses/>
;;; and <http://opensource.franz.com/preamble.html>.
;;; ----------------------------------------------------------------------------

(in-package :gst)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (pushnew :gst *features*))

(glib::at-init ()
  (eval-when (:compile-toplevel :load-toplevel :execute)
    (define-foreign-library gst
      (t "libgstreamer-1.0.so"))
    (define-foreign-library gst-base
      (t "libgstbase-1.0.so"))
    (define-foreign-library gst-video
      (t "libgstvideo-1.0.so")))
  (unless (foreign-library-loaded-p 'gst)
    (use-foreign-library gst))
  (unless (foreign-library-loaded-p 'gst-base)
    (use-foreign-library gst-base))
  (unless (foreign-library-loaded-p 'gst-video)
    (use-foreign-library gst-video)))

(defcfun ("gst_init_check" %gst-init-check) :boolean
  (argc (:pointer :int))
  (argv (:pointer (:pointer :string)))
  (err :pointer))

;; TODO: this should possibly have an option to pass arguments that will
;; influence GStreamer behaviour, but will require to defer the
;; initialisation call to after all of that is known
(defun %gst-init ()
  (let* ((binary #+ccl (car ccl:*command-line-argument-list*)
                 #+sbcl (car sb-ext:*posix-argv*)
                 ;; TODO: better fallback option, or error out
                 #-(or ccl sbcl) "/usr/bin/sbcl")
         (args `(,binary "--gst-disable-segtrap" "--gst-disable-registry-fork")))
    (with-g-error (err)
      (%gst-init-check
       (foreign-alloc :int :initial-element 3)
       (foreign-alloc :pointer :initial-element
                      (foreign-alloc :string :initial-contents args))
       err))))

(glib::at-init () (%gst-init))

;;; --- End of file gst.init.lisp ----------------------------------------------
