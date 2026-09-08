;; title: msv
;; version:
;; summary:
;; description:

;; traits
;;

;; token definitions
;;

;; constants
;;define the contract owner 
(define-constant contract-owner tx-sender)

;;define the error codes
(define-constant err-owner-only (err u100))
(define-constant err-already-locked (err u101))
(define-constant err-more-votes-than-members-required (err u102))
(define-constant err-not-a-member (err u103))
(define-constant err-votes-required-not-met (err u104))
;;

;; data vars
;;define the variables
(define-data-var members (list 100 principal) (list))
(define-data-var votes-required uint u1)

;;

;; data maps
;;define the map
(define-map votes { member: principal, recipient: principal } { decision: bool })
;;

;; public functions
;;

;; read only functions
;;

;; private functions
;;

