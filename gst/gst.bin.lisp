;;; ----------------------------------------------------------------------------
;;; gst.bin.lisp
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
;;;
;;; GstBin
;;;
;;; Base class and element that can contain other elements
;;;
;;; Synopsis
;;;
;;;     GstBin
;;;
;;;     gtk_bin_new
;;;     gtk_bin_add
;;;     gst_bin_remove
;;;     gst_bin_get_by_name
;;;     gst_bin_get_by_name_recurse_up
;;;     gst_bin_get_by_interface
;;;     gst_bin_iterate_elements
;;;     gst_bin_iterate_sorted
;;;     gst_bin_iterate_recurse
;;;     gst_bin_iterate_sinks
;;;     gst_bin_iterate_sources
;;;     gst_bin_iterate_all_by_interface
;;;     gst_bin_recalculate_latency
;;;     gst_bin_set_suppressed_flags
;;;     gst_bin_get_suppressed_flags
;;; ----------------------------------------------------------------------------

(in-package :gst)

;;; ----------------------------------------------------------------------------
;;; struct GstBin
;;; ----------------------------------------------------------------------------

(eval-when (:compile-toplevel :load-toplevel :execute)
  (register-object-type "GstBin" 'gst-bin))

(define-g-object-class "GstBin" gst-bin
  (:superclass gst-element
   :export t
   :interfaces nil ;; TODO: GstChildProxy
   :type-initializer "gst_bin_get_type")
  ())

;;; --- End of file gst.bin.lisp -----------------------------------------------
