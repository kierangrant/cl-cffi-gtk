;;; ----------------------------------------------------------------------------
;;; gst.bus.lisp
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
;;; GstBus
;;;
;;; Asynchronous message bus subsystem
;;;
;;; Synopsis
;;;
;;;     GstBus
;;;
;;;     gst_bus_new
;;;     gst_bus_post
;;;     gst_bus_have_pending
;;;     gst_bus_peek
;;;     gst_bus_pop
;;;     gst_bus_pop_filtered
;;;     gst_bus_timed_pop
;;;     gst_bus_timed_pop_filtered
;;;     gst_bus_set_flushing
;;;     gst_bus_set_sync_handler
;;;     gst_bus_create_watch
;;;     gst_bus_add_watch_full
;;;     gst_bus_add_watch
;;;     gst_bus_remove_watch
;;;     gst_bus_poll
;;;     gst_bus_async_signal_func
;;;     gst_bus_sync_signal_handler
;;;     gst_bus_add_signal_watch
;;;     gst_bus_add_signal_watch_full
;;;     gst_bus_remove_signal_watch
;;;     gst_bus_enable_sync_message_emission
;;;     gst_bus_disable_sync_message_emission
;;; ----------------------------------------------------------------------------

(in-package :gst)

;;; ----------------------------------------------------------------------------
;;; struct GstBus
;;; ----------------------------------------------------------------------------

(eval-when (:compile-toplevel :load-toplevel :execute)
  (register-object-type "GstBus" 'gst-bus))

(define-g-object-class "GstBus" gst-bus
  (:superclass gst-object
   :export t
   :interfaces nil
   :type-initializer "gst_bus_get_type")
  ())

;;; ----------------------------------------------------------------------------
;;; enum GstBusSyncReply
;;; ----------------------------------------------------------------------------

(define-g-enum "GstBusSyncReply" gst-bus-sync-reply
  (:export t
   :type-initializer "gst_bus_sync_reply_get_type")
  :drop
  :pass
  :async)

;;; ----------------------------------------------------------------------------
;;; gst_bus_set_sync_handler ()
;;; ----------------------------------------------------------------------------

(defcallback gst-bus-sync-handler-cb gst-bus-sync-reply
    ((bus (g-object gst-bus))
     ;; (message (g-object gst-message))
     (message :pointer)
     (user-data :pointer))
  (let ((fn (glib:get-stable-pointer-value user-data)))
    (restart-case
        (funcall fn bus message)
      (return-from-gst-bus-sync-handler-cb () :async))))

(defcfun ("gst_bus_set_sync_handler" %gst-bus-set-sync-handler) :void
  (bus (g-object gst-bus))
  (func :pointer)
  (user-data :pointer)
  (notify :pointer))

(defun gst-bus-set-sync-handler (bus func)
  (%gst-bus-set-sync-handler
   bus
   (callback gst-bus-sync-handler-cb)
   (glib:allocate-stable-pointer func)
   (callback glib:stable-pointer-destroy-notify-cb)))

(export 'gst-bus-set-sync-handler)

;;; ----------------------------------------------------------------------------
;;; gst_bus_add_watch_full ()
;;; ----------------------------------------------------------------------------

(defcallback gst-bus-func-cb :boolean
    ((bus (g-object gst-bus))
     ;; (message (g-object gst-message))
     (message :pointer)
     (user-data :pointer))
  (let ((fn (glib:get-stable-pointer-value user-data)))
    (restart-case
        (funcall fn bus message)
      (return-from-gst-bus-func-cb () NIL))))

(defcfun ("gst_bus_add_watch_full" %gst-bus-add-watch-full) :uint
  (bus (g-object gst-bus))
  (priority :int)
  (func :pointer)
  (user-data :pointer)
  (notify :pointer))

(defun gst-bus-add-watch (bus priority func)
  (%gst-bus-add-watch-full
   bus
   priority
   (callback gst-bus-func-cb)
   (glib:allocate-stable-pointer func)
   (callback glib:stable-pointer-destroy-notify-cb)))

(export 'gst-bus-add-watch)

;;; --- End of file gst.bus.lisp -----------------------------------------------
