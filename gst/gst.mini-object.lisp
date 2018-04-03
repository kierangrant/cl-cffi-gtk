;;; ----------------------------------------------------------------------------
;;; gst.mini-object.lisp
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
;;; GstMiniObject
;;;
;;; Lightweight base class for the GStreamer object hierarchy
;;;
;;; Synopsis
;;;
;;;     GstMiniObject
;;; ----------------------------------------------------------------------------

(in-package :gst)

;;; ----------------------------------------------------------------------------
;;; struct GstMiniObject
;;; ----------------------------------------------------------------------------

(define-g-boxed-cstruct gst-mini-object "GstMiniObject"
  (type g-type)
  (refcount :int)
  (lockstate :int)
  (flags :uint)
  (copy :pointer)
  (dispose :pointer)
  (free :pointer)
  (n-qdata :uint)
  (qdata :pointer))

;;; ----------------------------------------------------------------------------
;;; gst_mini_object_unref ()
;;; ----------------------------------------------------------------------------

(defcfun ("gst_mini_object_unref" gst-mini-object-unref) :void
  (mini-object :pointer))

(export 'gst-mini-object-unref)

;;; --- End of file gst.mini-object.lisp ---------------------------------------
