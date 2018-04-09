;;; ----------------------------------------------------------------------------
;;; gst.element.lisp
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
;;; GstElement
;;;
;;; Abstract base class for all pipeline elements
;;;
;;; Synopsis
;;;
;;;     GstElement
;;; ----------------------------------------------------------------------------

(in-package :gst)

;;; ----------------------------------------------------------------------------
;;; struct GstElement
;;; ----------------------------------------------------------------------------

(eval-when (:compile-toplevel :load-toplevel :execute)
  (register-object-type "GstElement" 'gst-element))

(define-g-object-class "GstElement" gst-element
  (:superclass gst-object
   :export t
   :interfaces nil
   :type-initializer "gst_element_get_type")
  ())

;;; ----------------------------------------------------------------------------
;;; enum GstStateChangeReturn
;;; ----------------------------------------------------------------------------

(define-g-enum "GstStateChangeReturn" gst-state-change-return
  (:export t
   :type-initializer "gst_state_change_return_get_type")
  :failure
  :success
  :async
  :no-preroll)

;;; ----------------------------------------------------------------------------
;;; enum GstState
;;; ----------------------------------------------------------------------------

(define-g-enum "GstState" gst-state
  (:export t
   :type-initializer "gst_state_get_type")
  :void-pending
  :null
  :ready
  :paused
  :playing)

;;; ----------------------------------------------------------------------------
;;; gst_element_set_state ()
;;; ----------------------------------------------------------------------------

(defcfun ("gst_element_set_state" gst-element-set-state) gst-state-change-return
  (element (g-object gst-element))
  (state gst-state))

(export 'gst-element-set-state)

;;; ----------------------------------------------------------------------------
;;; gst_element_get_state ()
;;; ----------------------------------------------------------------------------

(defcfun ("gst_element_get_state" %gst-element-get-state) gst-state-change-return
  (element (g-object gst-element))
  (state (:pointer gst-state))
  (pending (:pointer gst-state))
  (timeout :uint64))

(defun gst-element-get-state (element timeout)
  (with-foreign-objects ((state 'gst-state)
                         (pending 'gst-state))
    (let* ((return (%gst-element-get-state element state pending timeout))
           (available (not (eq return :async))))
      (values
       return
       (and available (mem-ref state 'gst-state))
       (and available (mem-ref pending 'gst-state))))))

(export 'gst-element-get-state)

;;; ----------------------------------------------------------------------------
;;; enum GstFormat
;;; ----------------------------------------------------------------------------

(define-g-enum "GstFormat" gst-format
  (:export t
   :type-initializer "gst_format_get_type")
  :undefined
  :default
  :bytes
  :time
  :buffers
  :percent)

(define-g-flags "GstSeekFlags" gst-seek-flags
  (:export t
   :type-initializer "gst_seek_flags_get_type")
  (:none 0)
  (:flush #.(ash 1 0))
  (:accurate #.(ash 1 1))
  (:key-unit #.(ash 1 2))
  (:segment #.(ash 1 3))
  (:trickmode #.(ash 1 4))
  (:skip #.(ash 1 4))
  (:snap-before #.(ash 1 5))
  (:snap-after #.(ash 1 6))
  (:snap-nearest #.(logior (ash 1 5) (ash 1 6)))
  (:trickmode-key-units #.(ash 1 7))
  (:trickmode-no-audio #.(ash 1 8)))

;;; ----------------------------------------------------------------------------
;;; gst_element_seek_simple ()
;;; ----------------------------------------------------------------------------

(defcfun ("gst_element_seek_simple" gst-element-seek-simple) :boolean
  (element (g-object gst-element))
  (format gst-format)
  (seek-flags gst-seek-flags)
  (seek-pos :int64))

(export 'gst-element-seek-simple)

;;; ----------------------------------------------------------------------------
;;; gst_element_query_position ()
;;; ----------------------------------------------------------------------------

(defcfun ("gst_element_query_position" %gst-element-query-position) :boolean
  (element (g-object gst-element))
  (format gst-format)
  (cur (:pointer :int64)))

(defun gst-element-query-position (element format)
  (with-foreign-object (cur :int64)
    (when (%gst-element-query-position element format cur)
      (mem-ref cur :int64))))

(export 'gst-element-query-position)

;;; ----------------------------------------------------------------------------
;;; gst_element_query_duration ()
;;; ----------------------------------------------------------------------------

(defcfun ("gst_element_query_duration" %gst-element-query-duration) :boolean
  (element (g-object gst-element))
  (format gst-format)
  (duration (:pointer :int64)))

(defun gst-element-query-duration (element format)
  (with-foreign-object (duration :int64)
    (when (%gst-element-query-duration element format duration)
      (mem-ref duration :int64))))

(export 'gst-element-query-duration)

;;; --- End of file gst.element.lisp -------------------------------------------
