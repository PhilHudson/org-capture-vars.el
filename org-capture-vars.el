;;; org-capture-vars.el --- User-defined capture variables and prompts for Org
;;
;; Filename: org-capture-vars.el
;; Description: User-defined capture variables and prompts for Org
;; Author: David Zuber <http://storax.github.io>
;; Maintainer: Phil Hudson <phil.hudson@iname.com>
;; Copyright (C) 2016, David Zuber, all rights reserved.
;; Created: 2016-05-27 13:57:49
;; Version: 0.1
;; Last-Updated: Fri May 27 21:16:11 2016 (+0100)
;;           By: Phil Hudson
;; URL:
;; Keywords: org-mode capture
;; Compatibility: GNU Emacs 24.5.1
;;
;; Features that might be required by this library:
;;
;;   None
;;
;;; This file is NOT part of GNU Emacs
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; License
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;; User-defined capture variables and prompts for Org.
;;
;; For use with Org capture mode’s %(...) Lisp escape syntax.
;;
;;     %(ocv/prmt PROMPT VARIABLE &optional DEFAULT COMPLETIONS)
;;
;; For example, you might define an Org capture template for capturing
;; JIRA tickets like this:
;;
;;     * JIRA Ticket %(ocv/prmt "JIRA Ticket No." 'jr-no)
;;       I have to do the following stuff:
;;     ** Triage %(progn jr-no)
;;
;; to be prompted for the JIRA ticket number to enter. Your entered text
;; will be stored in buffer-local variable 'jr-no'. If you enter, say,
;; "4321" at the prompt, your capture output will look like:
;;
;;     * JIRA Ticket 4321
;;       I have to do the following stuff:
;;     ** Triage 4321
;;
;; The optional third argument lets you specify an initial default input
;; value.
;;
;; If you have a list of completions you want to offer, you can pass that
;; as the optional fourth argument:
;;
;;     * Next meeting at %(ocv/prmt "Location" 'mtg-loc "the usual place" 'mtg-locs)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Installation:
;;
;; Put org-capture-vars.el in a directory in your `load-path'.
;; For example, to have `load-path' include the directory ~/elisp/,
;; set it in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And then add the following to your ~/.emacs startup file.
;;
;;     (with-eval-after-load 'org-capture (require 'org-capture-vars))
;;
;; That will be sufficient.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change log:
;;
;; 2016-05-27BST13:57
;;      * First released.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Acknowledgements:
;;
;; Very slightly modified from an original idea and implementation code by
;; David Zuber found at:
;;
;; http://storax.github.io/blog/2016/05/02/org-capture-tricks/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Require

(eval-and-compile (require 'org)) ; for `org-completing-read'

;;; Code:

(defvar ocv/capture-prmt-history nil
  "History of prompt answers for Org capture.")

(defun ocv/prmt (prompt variable &optional default history)
  "PROMPT for string, save it to VARIABLE and insert it.

Optional argument DEFAULT, a string, is the default input value, if any.
Optional argument HISTORY, a symbol bound to a completion list (of strings)
to offer.  It defaults to `ocv/capture-prmt-history'."
  (set (make-local-variable variable)
       (let* ((history (or history 'ocv/capture-prmt-history))
              (hist-list (symbol-value history)))
         (org-completing-read
          (concat prompt ": ") hist-list nil nil nil history default))))

(provide 'org-capture-vars)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; org-capture-vars.el ends here
