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
;;start function to called by the contract-owner to initialize the vault
(define-public (start (new-members (list 100 principal)) (new-votes-required uint)) 
    (begin 
        (asserts! (is-eq tx-sender contract-owner) err-owner-only)
        (asserts! (is-eq (len (var-get members)) u0) err-already-locked)
        (asserts! (>= (len new-members) new-votes-required) err-more-votes-than-members-required)
        (var-set members new-members)
        (var-set votes-required new-votes-required)
        (ok true)
    )
)

;;vote function
(define-public (vote (recipient principal) (decision bool)) 
    (begin 
        (asserts! (is-some (index-of? (var-get members) tx-sender)) err-not-a-member)
        (ok (map-set votes {member: tx-sender, recipient: recipient} {decision: decision}))
    )
)
;;

;; read only functions
;;

;; private functions
;;

