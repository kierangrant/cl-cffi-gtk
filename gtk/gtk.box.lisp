;;; ----------------------------------------------------------------------------
;;; gtk.box.lisp
;;;
;;; Copyright (C) 2009 - 2011 Kalyanov Dmitry
;;; Copyright (C) 2011 - 2012 Dr. Dieter Kaiser
;;;
;;; This file contains code from a fork of cl-gtk2.
;;; See http://common-lisp.net/project/cl-gtk2/
;;;
;;; The documentation has been copied from the GTK 2.2.2 Reference Manual
;;; See http://www.gtk.org.
;;;
;;; ----------------------------------------------------------------------------
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
;;; GtkBox
;;; 
;;; A container box
;;; 	
;;; Synopsis
;;; 
;;;     GtkBox
;;;     gtk_box_new
;;;     gtk_box_pack_start
;;;     gtk_box_pack_end
;;;     gtk_box_get_homogeneous
;;;     gtk_box_set_homogeneous
;;;     gtk_box_get_spacing
;;;     gtk_box_set_spacing
;;;     gtk_box_reorder_child
;;;     gtk_box_query_child_packing
;;;     gtk_box_set_child_packing
;;; 
;;; Object Hierarchy
;;; 
;;;   GObject
;;;    +----GInitiallyUnowned
;;;          +----GtkWidget
;;;                +----GtkContainer
;;;                      +----GtkBox
;;;                            +----GtkAppChooserWidget
;;;                            +----GtkButtonBox
;;;                            +----GtkColorSelection
;;;                            +----GtkFileChooserButton
;;;                            +----GtkFileChooserWidget
;;;                            +----GtkFontChooserWidget
;;;                            +----GtkFontSelection
;;;                            +----GtkHBox
;;;                            +----GtkInfoBar
;;;                            +----GtkRecentChooserWidget
;;;                            +----GtkStatusbar
;;;                            +----GtkVBox
;;; 
;;; Implemented Interfaces
;;; 
;;; GtkBox implements AtkImplementorIface, GtkBuildable and GtkOrientable.
;;;
;;; Properties
;;; 
;;;   "homogeneous"              gboolean              : Read / Write
;;;   "spacing"                  gint                  : Read / Write
;;; 
;;; Child Properties
;;; 
;;;   "expand"                   gboolean              : Read / Write
;;;   "fill"                     gboolean              : Read / Write
;;;   "pack-type"                GtkPackType           : Read / Write
;;;   "padding"                  guint                 : Read / Write
;;;   "position"                 gint                  : Read / Write
;;; 
;;; Description
;;; 
;;; The GtkBox widget organizes child widgets into a rectangular area.
;;; 
;;; The rectangular area of a GtkBox is organized into either a single row or a
;;; single column of child widgets depending upon the orientation. Thus, all
;;; children of a GtkBox are allocated one dimension in common, which is the
;;; height of a row, or the width of a column.
;;; 
;;; GtkBox uses a notion of packing. Packing refers to adding widgets with
;;; reference to a particular position in a GtkContainer. For a GtkBox, there
;;; are two reference positions: the start and the end of the box. For a
;;; vertical GtkBox, the start is defined as the top of the box and the end is
;;; defined as the bottom. For a horizontal GtkBox the start is defined as the
;;; left side and the end is defined as the right side.
;;; 
;;; Use repeated calls to gtk_box_pack_start() to pack widgets into a GtkBox
;;; from start to end. Use gtk_box_pack_end() to add widgets from end to start.
;;; You may intersperse these calls and add widgets from both ends of the same
;;; GtkBox.
;;; 
;;; Because GtkBox is a GtkContainer, you may also use gtk_container_add() to
;;; insert widgets into the box, and they will be packed with the default values
;;; for "expand" and "fill". Use gtk_container_remove() to remove widgets from
;;; the GtkBox.
;;; 
;;; Use gtk_box_set_homogeneous() to specify whether or not all children of the
;;; GtkBox are forced to get the same amount of space.
;;; 
;;; Use gtk_box_set_spacing() to determine how much space will be minimally
;;; placed between all children in the GtkBox. Note that spacing is added
;;; between the children, while padding added by gtk_box_pack_start() or
;;; gtk_box_pack_end() is added on either side of the widget it belongs to.
;;; 
;;; Use gtk_box_reorder_child() to move a GtkBox child to a different place in
;;; the box.
;;; 
;;; Use gtk_box_set_child_packing() to reset the "expand", "fill" and "padding"
;;; child properties. Use gtk_box_query_child_packing() to query these fields.
;;; 
;;; Note
;;; 
;;; Note that a single-row or single-column GtkGrid provides exactly the same
;;; functionality as GtkBox.
;;; ---------------------------------------------------------------------------- 

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; struct GtkBox
;;; 
;;; struct GtkBox;
;;; ----------------------------------------------------------------------------

;; There is a problem, if the Lisp name of the class corresponds to the
;; name of the C class. For this case the name is not registered. That causes
;; further problems.
(eval-when (:compile-toplevel :load-toplevel :execute)
  (register-object-type "GtkBox" 'gtk-box))

(define-g-object-class "GtkBox" gtk-box
                       (:superclass container
                        :export t
                        :interfaces
                        ("AtkImplementorIface" "GtkBuildable" "GtkOrientable")
                        :type-initializer "gtk_box_get_type")
                       ((homogeneous gtk-box-homogeneous "homogeneous"
                                     "gboolean" t t)
                        (spacing gtk-box-spacing "spacing" "gint" t t)))

;; These symbols are not exported by default? Why?
;(export 'gtk-box)
;(export 'gtk-box-homogeneous)
;(export 'gtk-box-spacing)

;;; ----------------------------------------------------------------------------

(define-child-property "GtkBox" gtk-box-child-expand "expand" "gboolean" t t t)

(define-child-property "GtkBox"
                       gtk-box-child-fill "fill" "gboolean" t t t)

(define-child-property "GtkBox" gtk-box-child-padding "padding" "guint" t t t)

(define-child-property "GtkBox" gtk-box-child-pack-type
                       "pack-type" "GtkPackType" t t t)

(define-child-property "GtkBox" gtk-box-child-position "position" "gint" t t t)

;;; ---------------------------------------------------------------------------- 
;;; gtk_box_new ()
;;; 
;;; GtkWidget * gtk_box_new (GtkOrientation orientation, gint spacing)
;;; 
;;; Creates a new GtkBox.
;;; 
;;; orientation :
;;; 	the box's orientation.
;;; 
;;; spacing :
;;; 	the number of pixels to place by default between children.
;;; 
;;; Returns :
;;; 	a new GtkBox.
;;; 
;;; Since 3.0
;;; ----------------------------------------------------------------------------


;;; ----------------------------------------------------------------------------
;;; gtk_box_pack_start ()
;;; 
;;; void gtk_box_pack_start (GtkBox *box,
;;;                          GtkWidget *child,
;;;                          gboolean expand,
;;;                          gboolean fill,
;;;                          guint padding)
;;; 
;;; Adds child to box, packed with reference to the start of box. The child is
;;; packed after any other child packed with reference to the start of box.
;;; 
;;; box :
;;; 	a GtkBox
;;; 
;;; child :
;;; 	the GtkWidget to be added to box
;;; 
;;; expand :
;;; 	TRUE if the new child is to be given extra space allocated to box. The
;;;     extra space will be divided evenly between all children that use this
;;;     option
;;; 
;;; fill :
;;; 	TRUE if space given to child by the expand option is actually allocated
;;;     to child, rather than just padding it. This parameter has no effect if
;;;     expand is set to FALSE. A child is always allocated the full height of
;;;     a horizontal GtkBox and the full width of a vertical GtkBox. This
;;;     option affects the other dimension.
;;; 
;;; padding :
;;; 	extra space in pixels to put between this child and its neighbors, over
;;;     and above the global amount specified by "spacing" property. If child is
;;;     a widget at one of the reference ends of box, then padding pixels are
;;;     also put between child and the reference edge of box
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_box_pack_start" %gtk-box-pack-start) :void
  (box (g-object gtk-box))
  (child (g-object widget))
  (expand :boolean)
  (fill :boolean)
  (padding :uint))

(defun gtk-box-pack-start (box child &key (expand t) (fill t) (padding 0))
  (%gtk-box-pack-start box child expand fill padding))

(export 'gtk-box-pack-start)

;;; ----------------------------------------------------------------------------
;;; gtk_box_pack_end ()
;;; 
;;; void gtk_box_pack_end (GtkBox *box,
;;;                        GtkWidget *child,
;;;                        gboolean expand,
;;;                        gboolean fill,
;;;                        guint padding)
;;; 
;;; Adds child to box, packed with reference to the end of box. The child is
;;; packed after (away from end of) any other child packed with reference to
;;; the end of box.
;;; 
;;; box :
;;; 	a GtkBox
;;; 
;;; child :
;;; 	the GtkWidget to be added to box
;;; 
;;; expand :
;;; 	TRUE if the new child is to be given extra space allocated to box. The
;;;     extra space will be divided evenly between all children of box that use
;;;     this option.
;;; 
;;; fill :
;;; 	TRUE if space given to child by the expand option is actually allocated
;;;     to child, rather than just padding it. This parameter has no effect if
;;;     expand is set to FALSE. A child is always allocated the full height of
;;;     a horizontal GtkBox and the full width of a vertical GtkBox. This
;;;     option affects the other dimension.
;;; 
;;; padding :
;;; 	extra space in pixels to put between this child and its neighbors, over
;;;     and above the global amount specified by "spacing" property. If child is
;;;     a widget at one of the reference ends of box, then padding pixels are
;;;     also put between child and the reference edge of box.
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_box_pack_end" %gtk-box-pack-end) :void
  (box (g-object gtk-box))
  (child (g-object widget))
  (expand :boolean)
  (fill :boolean)
  (padding :uint))

(defun gtk-box-pack-end (box child &key (expand t) (fill t) (padding 0))
  (%gtk-box-pack-end box child expand fill padding))

(export 'gtk-box-pack-end)

;;; ----------------------------------------------------------------------------
;;; gtk_box_get_homogeneous ()
;;; 
;;; gboolean gtk_box_get_homogeneous (GtkBox *box)
;;; 
;;; Returns whether the box is homogeneous (all children are the same size).
;;; See gtk_box_set_homogeneous().
;;; 
;;; box :
;;; 	a GtkBox
;;; 
;;; Returns :
;;; 	TRUE if the box is homogeneous.
;;; ----------------------------------------------------------------------------

(defun gtk-box-get-homogeneous (box)
  (gtk-box-homogeneous box))

(export 'gtk-box-get-homogeneous)
  
;;; ----------------------------------------------------------------------------
;;; gtk_box_set_homogeneous ()
;;; 
;;; void gtk_box_set_homogeneous (GtkBox *box, gboolean homogeneous)
;;; 
;;; Sets the "homogeneous" property of box, controlling whether or not all
;;; children of box are given equal space in the box.
;;; 
;;; box :
;;; 	a GtkBox
;;; 
;;; homogeneous :
;;; 	a boolean value, TRUE to create equal allotments, FALSE for variable
;;;     allotments
;;; ----------------------------------------------------------------------------

(defun gtk-box-set-homogeneous (box homogeneous)
  (setf (gtk-box-homogeneous box) homogeneous))

(export 'gtk-box-set-homogeneous)

;;; ----------------------------------------------------------------------------
;;; gtk_box_get_spacing ()
;;; 
;;; gint gtk_box_get_spacing (GtkBox *box)
;;; 
;;; Gets the value set by gtk_box_set_spacing().
;;; 
;;; box :
;;; 	a GtkBox
;;; 
;;; Returns :
;;; 	spacing between children
;;; ----------------------------------------------------------------------------

(defun gtk-box-get-spacing (box)
  (gtk-box-spacing box))

(export 'gtk-box-get-spacing)
  
;;; ----------------------------------------------------------------------------
;;; gtk_box_set_spacing ()
;;; 
;;; void gtk_box_set_spacing (GtkBox *box, gint spacing)
;;; 
;;; Sets the "spacing" property of box, which is the number of pixels to place
;;; between children of box.
;;; 
;;; box :
;;; 	a GtkBox
;;; 
;;; spacing :
;;; 	the number of pixels to put between children
;;; ----------------------------------------------------------------------------

(defun gtk-box-set-spacing (box spacing)
  (setf (gtk-box-spacing box) spacing))

(export 'gtk-box-set-spacing)

;;; ----------------------------------------------------------------------------
;;; gtk_box_reorder_child ()
;;; 
;;; void gtk_box_reorder_child (GtkBox *box, GtkWidget *child, gint position)
;;; 
;;; Moves child to a new position in the list of box children. The list is the
;;; children field of GtkBox, and contains both widgets packed GTK_PACK_START
;;; as well as widgets packed GTK_PACK_END, in the order that these widgets
;;; were added to box.
;;; 
;;; A widget's position in the box children list determines where the widget is
;;; packed into box. A child widget at some position in the list will be packed
;;; just after all other widgets of the same packing type that appear earlier
;;; in the list.
;;; 
;;; box :
;;; 	a GtkBox
;;; 
;;; child :
;;; 	the GtkWidget to move
;;; 
;;; position :
;;; 	the new position for child in the list of children of box, starting
;;;     from 0. If negative, indicates the end of the list
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_box_reorder_child" gtk-box-reorder-child) :void
  (box g-object)
  (child g-object)
  (position :int))

(export 'gtk-box-reorder-child)

;;; ----------------------------------------------------------------------------
;;; gtk_box_query_child_packing ()
;;; 
;;; void gtk_box_query_child_packing (GtkBox *box,
;;;                                   GtkWidget *child,
;;;                                   gboolean *expand,
;;;                                   gboolean *fill,
;;;                                   guint *padding,
;;;                                   GtkPackType *pack_type)
;;; 
;;; Obtains information about how child is packed into box.
;;; 
;;; box :
;;; 	a GtkBox
;;; 
;;; child :
;;; 	the GtkWidget of the child to query
;;; 
;;; expand :
;;; 	pointer to return location for "expand" child property.
;;; 
;;; fill :
;;; 	pointer to return location for "fill" child property.
;;; 
;;; padding :
;;; 	pointer to return location for "padding" child property.
;;; 
;;; pack_type :
;;; 	pointer to return location for "pack-type" child property.
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_box_set_child_packing ()
;;; 
;;; void gtk_box_set_child_packing (GtkBox *box,
;;;                                 GtkWidget *child,
;;;                                 gboolean expand,
;;;                                 gboolean fill,
;;;                                 guint padding,
;;;                                 GtkPackType pack_type);
;;; 
;;; Sets the way child is packed into box.
;;; 
;;; box :
;;; 	a GtkBox
;;; 
;;; child :
;;; 	the GtkWidget of the child to set
;;; 
;;; expand :
;;; 	the new value of the "expand" child property
;;; 
;;; fill :
;;; 	the new value of the "fill" child property
;;; 
;;; padding :
;;; 	the new value of the "padding" child property
;;; 
;;; pack_type :
;;; 	the new value of the "pack-type" child property
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;;
;;; Property Details
;;;
;;; ----------------------------------------------------------------------------
;;; The "homogeneous" property
;;; 
;;;   "homogeneous" gboolean              : Read / Write
;;; 
;;; Whether the children should all be the same size.
;;; 
;;; Default value: FALSE
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; The "spacing" property
;;; 
;;;   "spacing" gint                  : Read / Write
;;; 
;;; The amount of space between children.
;;; 
;;; Allowed values: >= 0
;;; 
;;; Default value: 0
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;;
;;; Child Property Details
;;;
;;; ----------------------------------------------------------------------------
;;; The "expand" child property
;;; 
;;;   "expand"                   gboolean              : Read / Write
;;; 
;;; Whether the child should receive extra space when the parent grows.
;;; 
;;; Note that the default value for this property is FALSE for GtkBox, but
;;; GtkHBox, GtkVBox and other subclasses use the old default of TRUE.
;;; 
;;; Note that the "halign", "valign", "hexpand" and "vexpand" properties are
;;; the preferred way to influence child size allocation in containers.
;;; 
;;; Default value: FALSE
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; The "fill" child property
;;; 
;;;   "fill"                     gboolean              : Read / Write
;;; 
;;; Whether the child should receive extra space when the parent grows.
;;; 
;;; Note that the "halign", "valign", "hexpand" and "vexpand" properties are
;;; the preferred way to influence child size allocation in containers.
;;; 
;;; Default value: TRUE
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; The "pack-type" child property
;;; 
;;;   "pack-type"                GtkPackType           : Read / Write
;;; 
;;; A GtkPackType indicating whether the child is packed with reference to the
;;; start or end of the parent.
;;; 
;;; Default value: GTK_PACK_START
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; The "padding" child property
;;; 
;;;   "padding"                  guint                 : Read / Write
;;; 
;;; Extra space to put between the child and its neighbors, in pixels.
;;; 
;;; Allowed values: <= G_MAXINT
;;; 
;;; Default value: 0
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; The "position" child property
;;; 
;;;   "position"                 gint                  : Read / Write
;;; 
;;; The index of the child in the parent.
;;; 
;;; Allowed values: >= G_MAXULONG
;;; 
;;; Default value: 0
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;;
;;; GtkHBox
;;; 
;;; A horizontal container box
;;; 	
;;; Synopsis
;;; 
;;; #include <gtk/gtk.h>
;;; 
;;; struct       GtkHBox;
;;; GtkWidget *  gtk_hbox_new (gboolean homogeneous, gint spacing);
;;; 
;;; Object Hierarchy
;;; 
;;;   GObject
;;;    +----GInitiallyUnowned
;;;          +----GtkWidget
;;;                +----GtkContainer
;;;                      +----GtkBox
;;;                            +----GtkHBox
;;; 
;;; Implemented Interfaces
;;; 
;;; GtkHBox implements AtkImplementorIface, GtkBuildable and GtkOrientable.
;;; Description
;;; 
;;; GtkHBox is a container that organizes child widgets into a single row.
;;; 
;;; Use the GtkBox packing interface to determine the arrangement, spacing,
;;; width, and alignment of GtkHBox children.
;;; 
;;; All children are allocated the same height.
;;; 
;;; GtkHBox has been deprecated. You can use GtkBox instead, which is a very
;;; quick and easy change. If you have derived your own classes from GtkHBox,
;;; you can simply change the inheritance to derive directly from GtkBox. No
;;; further changes are needed, since the default value of the "orientation"
;;; property is GTK_ORIENTATION_HORIZONTAL. If you want your code to be
;;; future-proof, the recommendation is to switch to GtkGrid, since GtkBox is
;;; going to be deprecated in favor of the more flexible grid widget eventually.
;;; For more information about migrating to GtkGrid, see Migrating from other
;;; containers to GtkGrid
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; struct GtkHBox
;;; 
;;; struct GtkHBox;
;;; 
;;; Warning
;;; 
;;; GtkHBox is deprecated and should not be used in newly-written code.
;;; ----------------------------------------------------------------------------

(eval-when (:compile-toplevel :load-toplevel :execute)
  (register-object-type "GtkHBox" 'gtk-h-box))

(define-g-object-class "GtkHBox" gtk-h-box
                       (:superclass gtk-box
                        :export t
                        :interfaces ("AtkImplementorIface"
                                     "GtkBuildable"
                                     "GtkOrientable")
                        :type-initializer "gtk_hbox_get_type")
                       nil)

;;; ----------------------------------------------------------------------------

(define-child-property "GtkHBox"
                       gtk-h-box-child-expand "expand" "gboolean" t t t)

(define-child-property "GtkHBox"
                       gtk-h-box-child-fill "fill" "gboolean" t t t)

(define-child-property "GtkHBox"
                       gtk-h-box-child-padding "padding" "guint" t t t)

(define-child-property "GtkHBox"
                       gtk-h-box-child-pack-type
                       "pack-type" "GtkPackType" t t t)

(define-child-property "GtkHBox"
                       gtk-h-box-child-position "position" "gint" t t t)

;;; ----------------------------------------------------------------------------
;;; gtk_hbox_new ()
;;; 
;;; GtkWidget * gtk_hbox_new (gboolean homogeneous, gint spacing)
;;; 
;;; Warning
;;; 
;;; gtk_hbox_new has been deprecated since version 3.2 and should not be used
;;; in newly-written code. You can use gtk_box_new() with
;;; GTK_ORIENTATION_HORIZONTAL instead, wich is a very quick and easy change.
;;; But the recommendation is to switch to GtkGrid, since GtkBox is going to go
;;; away eventually. See Migrating from other containers to GtkGrid.
;;; 
;;; Creates a new GtkHBox.
;;; 
;;; homogeneous :
;;; 	TRUE if all children are to be given equal space allotments.
;;; 
;;; spacing :
;;; 	the number of pixels to place by default between children.
;;; 
;;; Returns :
;;; 	a new GtkHBox.
;;; ----------------------------------------------------------------------------

(defun gtk-h-box-new (homogeneous spacing)
  (make-instance 'gtk-h-box :homogeneous homogeneous :spacing spacing))

(export 'gtk-h-box-new)

;;; ----------------------------------------------------------------------------
;;;
;;; GtkVBox
;;; 
;;; GtkVBox — A vertical container box
;;; 	
;;; Synopsis
;;; 
;;; struct       GtkVBox;
;;;
;;; GtkWidget *  gtk_vbox_new  (gboolean homogeneous, gint spacing);
;;; 
;;; Object Hierarchy
;;; 
;;;   GObject
;;;    +----GInitiallyUnowned
;;;          +----GtkWidget
;;;                +----GtkContainer
;;;                      +----GtkBox
;;;                            +----GtkVBox
;;; 
;;; Implemented Interfaces
;;; 
;;; GtkVBox implements AtkImplementorIface, GtkBuildable and GtkOrientable.
;;;
;;; Description
;;; 
;;; A GtkVBox is a container that organizes child widgets into a single column.
;;; 
;;; Use the GtkBox packing interface to determine the arrangement, spacing,
;;; height, and alignment of GtkVBox children.
;;; 
;;; All children are allocated the same width.
;;; 
;;; GtkVBox has been deprecated. You can use GtkBox instead, which is a very
;;; quick and easy change. If you have derived your own classes from GtkVBox,
;;; you can simply change the inheritance to derive directly from GtkBox, and
;;; set the "orientation" property to GTK_ORIENTATION_VERTICAL in your instance
;;; init function, with a call like:
;;; 
;;;  1 gtk_orientable_set_orientation (GTK_ORIENTABLE (object),
;;;  2                                 GTK_ORIENTATION_VERTICAL);
;;; 
;;; If you want your code to be future-proof, the recommendation is to switch
;;; to GtkGrid, since GtkBox is going to be deprecated in favor of the more
;;; flexible grid widget eventually. For more information about migrating to
;;; GtkGrid, see Migrating from other containers to GtkGrid.
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; struct GtkVBox
;;; 
;;; struct GtkVBox;
;;; 
;;; Warning
;;; 
;;; GtkVBox is deprecated and should not be used in newly-written code.
;;; ----------------------------------------------------------------------------

(eval-when (:compile-toplevel :load-toplevel :execute)
  (register-object-type "GtkVBox" 'gtk-v-box))

(define-g-object-class "GtkVBox" gtk-v-box
                       (:superclass gtk-box
                        :export t
                        :interfaces
                        ("AtkImplementorIface" "GtkBuildable" "GtkOrientable")
                        :type-initializer "gtk_vbox_get_type")
  nil)

;;; ----------------------------------------------------------------------------

(define-child-property "GtkVBox"
                       gtk-v-box-child-expand "expand" "gboolean" t t t)

(define-child-property "GtkVBox" gtk-v-box-child-fill "fill" "gboolean" t t t)

(define-child-property "GtkVBox"
                       gtk-v-box-child-padding "padding" "guint" t t t)

(define-child-property "GtkVBox"
                       gtk-v-box-child-pack-type "pack-type"
                       "GtkPackType" t t t)

(define-child-property "GtkVBox"
                       gtk-v-box-child-position "position" "gint" t t t)

;;; ----------------------------------------------------------------------------
;;; gtk_vbox_new ()
;;; 
;;; GtkWidget * gtk_vbox_new (gboolean homogeneous, gint spacing)
;;; 
;;; Warning
;;; 
;;; gtk_vbox_new has been deprecated since version 3.2 and should not be used in
;;; newly-written code. You can use gtk_box_new() with GTK_ORIENTATION_VERTICAL
;;; instead, wich is a very quick and easy change. But the recommendation is to
;;; switch to GtkGrid, since GtkBox is going to go away eventually. See
;;; Migrating from other containers to GtkGrid.
;;; 
;;; Creates a new GtkVBox.
;;; 
;;; homogeneous :
;;; 	TRUE if all children are to be given equal space allotments.
;;; 
;;; spacing :
;;; 	the number of pixels to place by default between children.
;;; 
;;; Returns :
;;; 	a new GtkVBox.
;;; ----------------------------------------------------------------------------

(defun gtk-v-box-new (homogeneous spacing)
  (make-instance 'gtk-v-box
                 :homogeneous homogeneous
                 :spacing spacing))

(export 'gtk-v-box-new)

;;; --- End of file gtk.box.lisp -----------------------------------------------