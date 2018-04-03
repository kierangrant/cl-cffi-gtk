;;; ----------------------------------------------------------------------------
;;; cl-cffi-gtk.asd
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

(defsystem :cl-cffi-gtk-gst
  :name :cl-cffi-gtk-gst
  :version "1.10.4"                     ; Version of the library
  :author "Olof-Joachim Frahm"
  :license "LLGPL"
  :description "A Lisp binding to GStreamer"
  :serial t
  :components
  ((:file "gst.package")
   (:file "gst.init")

   (:file "gst.version")                ; Version Information
   (:file "gst.element")
   (:file "gst.bin")
   (:file "gst.object")
   (:file "gst.bus")
   (:file "gst.pipeline")

   (:file "gst.mini-object")
   (:file "gst.message")

   (:file "gst.element-factory")
   (:file "gst.video-overlay")

   (:file "gst.parse")
   )
  :depends-on (:cl-cffi-gtk-glib
               :cl-cffi-gtk-gobject
               :cffi
               :bordeaux-threads
               :alexandria
               :iterate
               :trivial-features))

;;; --- End of file cl-cffi-gtk-gst.asd ----------------------------------------
