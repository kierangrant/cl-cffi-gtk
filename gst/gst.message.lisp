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

(define-g-flags "GstMessageType" gst-message-type
  (:export t
   :type-initializer "gst_message_type_get_type")
  (:gst-message-unknown 0)
  (:gst-message-eos #.(ash 1 0))
  (:gst-message-error #.(ash 1 1))
  (:gst-message-warning #.(ash 1 2))
  (:gst-message-info #.(ash 1 3))
  (:gst-message-tag #.(ash 1 4))
  (:gst-message-buffering #.(ash 1 5))
  (:gst-message-state-changed #.(ash 1 6))
  (:gst-message-state-dirty #.(ash 1 7))
  (:gst-message-step-done #.(ash 1 8))
  (:gst-message-clock-provide #.(ash 1 9))
  (:gst-message-clock-lost #.(ash 1 10))
  (:gst-message-new-clock #.(ash 1 11))
  (:gst-message-structure-change #.(ash 1 12))
  (:gst-message-stream-status #.(ash 1 13))
  (:gst-message-application #.(ash 1 14))
  (:gst-message-element #.(ash 1 15))
  (:gst-message-segment-start #.(ash 1 16))
  (:gst-message-segment-done #.(ash 1 17))
  (:gst-message-duration-changed #.(ash 1 18))
  (:gst-message-latency #.(ash 1 19))
  (:gst-message-async-start #.(ash 1 20))
  (:gst-message-async-done #.(ash 1 21))
  (:gst-message-request-state #.(ash 1 22))
  (:gst-message-step-start #.(ash 1 23))
  (:gst-message-qos #.(ash 1 24))
  (:gst-message-progress #.(ash 1 25))
  (:gst-message-toc #.(ash 1 26))
  (:gst-message-reset-time #.(ash 1 27))
  (:gst-message-stream-start #.(ash 1 28))
  (:gst-message-need-context #.(ash 1 29))
  (:gst-message-have-context #.(ash 1 30))
  (:gst-message-extended #.(ash 1 31))
  (:gst-message-device-added #.(+ (ash 1 31) 1))
  (:gst-message-device-removed #.(+ (ash 1 31) 2))
  (:gst-message-property-notify #.(+ (ash 1 31) 3))
  (:gst-message-stream-collection #.(+ (ash 1 31) 4))
  (:gst-message-streams-selected #.(+ (ash 1 31) 5))
  (:gst-message-redirect #.(+ (ash 1 31) 6))
  (:gst-message-any #xffffffff))

;;; ----------------------------------------------------------------------------
;;; struct GstMessage
;;; ----------------------------------------------------------------------------

(define-g-boxed-cstruct gst-message "GstMessage"
  (mini-object (:struct gst-mini-object-cstruct))
  ;; (mini-object (g-boxed-foreign gst-mini-object))
  (type :int)
  (timestamp :uint64)
  (src :pointer)
  ;; (src (g-object gst-object))
  (seqnum :uint32))

;;; ----------------------------------------------------------------------------
;;; gst_is_video_overlay_prepare_window_handle_message ()
;;; ----------------------------------------------------------------------------

(defcfun ("gst_is_video_overlay_prepare_window_handle_message" gst-is-video-overlay-prepare-window-handle-message) :boolean
  (message :pointer))

(export 'gst-is-video-overlay-prepare-window-handle-message)

;;; --- End of file gst.message.lisp -------------------------------------------
