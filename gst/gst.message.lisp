;;; ----------------------------------------------------------------------------
;;; gst.message.lisp
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
;;; GstMessage
;;;
;;; Lightweight objects to signal the application of pipeline events
;;;
;;; Synopsis
;;;
;;;     GstMessage
;;; ----------------------------------------------------------------------------

(in-package :gst)

(define-g-enum "GstMessageType" gst-message-type
  (:export t
   :type-initializer "gst_message_type_get_type")
  (:unknown 0)
  (:eos #.(ash 1 0))
  (:error #.(ash 1 1))
  (:warning #.(ash 1 2))
  (:info #.(ash 1 3))
  (:tag #.(ash 1 4))
  (:buffering #.(ash 1 5))
  (:state-changed #.(ash 1 6))
  (:state-dirty #.(ash 1 7))
  (:step-done #.(ash 1 8))
  (:clock-provide #.(ash 1 9))
  (:clock-lost #.(ash 1 10))
  (:new-clock #.(ash 1 11))
  (:structure-change #.(ash 1 12))
  (:stream-status #.(ash 1 13))
  (:application #.(ash 1 14))
  (:element #.(ash 1 15))
  (:segment-start #.(ash 1 16))
  (:segment-done #.(ash 1 17))
  (:duration-changed #.(ash 1 18))
  (:latency #.(ash 1 19))
  (:async-start #.(ash 1 20))
  (:async-done #.(ash 1 21))
  (:request-state #.(ash 1 22))
  (:step-start #.(ash 1 23))
  (:qos #.(ash 1 24))
  (:progress #.(ash 1 25))
  (:toc #.(ash 1 26))
  (:reset-time #.(ash 1 27))
  (:stream-start #.(ash 1 28))
  (:need-context #.(ash 1 29))
  (:have-context #.(ash 1 30))
  (:extended #.(ash 1 31))
  (:device-added #.(+ (ash 1 31) 1))
  (:device-removed #.(+ (ash 1 31) 2))
  (:property-notify #.(+ (ash 1 31) 3))
  (:stream-collection #.(+ (ash 1 31) 4))
  (:streams-selected #.(+ (ash 1 31) 5))
  (:redirect #.(+ (ash 1 31) 6))
  (:any #xffffffff))

(define-g-enum "GstState" gst-state
  (:export t
   :type-initializer "gst_state_get_type")
  :void-pending
  :null
  :ready
  :paused
  :playing)

;;; ----------------------------------------------------------------------------
;;; struct GstMessage
;;; ----------------------------------------------------------------------------

(define-g-boxed-cstruct gst-message "GstMessage"
  (mini-object (:struct gst-mini-object-cstruct))
  ;; (mini-object (g-boxed-foreign gst-mini-object))
  (type gst-message-type)
  (timestamp :uint64)
  (src :pointer)
  ;; (src (g-object gst-object))
  (seqnum :uint32))

;;; ----------------------------------------------------------------------------
;;; gst_message_parse_state_changed ()
;;; ----------------------------------------------------------------------------

(defcfun ("gst_message_parse_state_changed" %gst-message-parse-state-changed) :void
  (message :pointer)
  (oldstate :pointer)
  (newstate :pointer)
  (pending :pointer))

(defun gst-message-parse-state-changed (message)
  (with-foreign-object (states 'gst-state 3)
    (%gst-message-parse-state-changed
     message
     (mem-aptr states 'gst-state 0)
     (mem-aptr states 'gst-state 1)
     (mem-aptr states 'gst-state 2))
    (values
     (mem-aref states 'gst-state 0)
     (mem-aref states 'gst-state 1)
     (mem-aref states 'gst-state 2))))

(export 'gst-message-parse-state-changed)

;;; ----------------------------------------------------------------------------
;;; gst_is_video_overlay_prepare_window_handle_message ()
;;; ----------------------------------------------------------------------------

(defcfun ("gst_is_video_overlay_prepare_window_handle_message" gst-is-video-overlay-prepare-window-handle-message) :boolean
  (message :pointer))

(export 'gst-is-video-overlay-prepare-window-handle-message)

;;; --- End of file gst.message.lisp -------------------------------------------
