;;; ----------------------------------------------------------------------------
;;; gst.pipeline.lisp
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
;;; GstPipeline
;;;
;;; Top-level bin with clocking and bus management functionality.
;;;
;;; Synopsis
;;;
;;;     GstPipeline
;;; ----------------------------------------------------------------------------

(in-package :gst)

;;; ----------------------------------------------------------------------------
;;; struct GstPipeline
;;; ----------------------------------------------------------------------------

(eval-when (:compile-toplevel :load-toplevel :execute)
  (register-object-type "GstPipeline" 'gst-pipeline))

(define-g-object-class "GstPipeline" gst-pipeline
  (:superclass gst-bin
   :export t
   :interfaces nil ;; TODO: GstChildProxy
   :type-initializer "gst_pipeline_get_type")
  ())

;;; ----------------------------------------------------------------------------
;;; gst_pipeline_get_bus ()
;;; ----------------------------------------------------------------------------

(defcfun ("gst_pipeline_get_bus" gst-pipeline-get-bus) (g-object gst-bus)
  (pipeline (g-object gst-pipeline)))

(export 'gst-pipeline-get-bus)

;;; --- End of file gst.pipeline.lisp ------------------------------------------
