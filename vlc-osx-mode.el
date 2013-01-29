;;; vlc-osx-mode.el --- Minor mode for controlling VLC from Emacs on OSX (via
;;; AppleScript)

;; Copyright (C) 2013 Hans Engel

;; Authors: Hans Engel <engel@engel.uk.to>
;; Keywords: vlc mac osx

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(defun vlc-osx-run-applescript (code)
  (let ((escaped-code (shell-quote-argument code)))
    (shell-command (concat "osascript -e "
                           escaped-code
                           " &")
                   nil)))

(defun vlc-osx-run-simple-command (cmd)
  (vlc-osx-run-applescript (concat "tell application \"VLC\" to "
                                   cmd)))

(defun vlc-osx-play-pause ()
  (interactive)
  (vlc-osx-run-simple-command "play"))

(defun vlc-osx-stop ()
  (interactive)
  (vlc-osx-run-simple-command "stop"))

(defvar vlc-osx-mode-map (make-sparse-keymap)
  "vlc-osx-mode keymap")

(define-key vlc-osx-mode-map
  (kbd "C-c C-v C-p") 'vlc-osx-play-pause)
(define-key vlc-osx-mode-map
  (kbd "C-c C-v C-s") 'vlc-osx-stop)

(define-minor-mode vlc-osx-mode
  "VLC OSX mode" nil " VLC" vlc-osx-mode-map)

(provide 'vlc-osx-mode)

;;; vlc-osx-mode.el ends here
