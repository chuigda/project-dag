#lang racket

(require srfi/1)
(require srfi/2)

(provide choice scene build-game play-game scenes choices game-over say)

(define (display-twr s)
  (let ([chars (string->list s)])
    (define (display-twr-iter chars)
      (if (null? chars)
          void
          (begin
            (write-char (car chars))
            (sleep 0.05)
            (flush-output)
            (display-twr-iter (cdr chars)))))
    (display-twr-iter chars)))

(define (display-flush s)
  (begin
    (display s)
    (flush-output)))

(define (display-twr-pause s)
  (begin
    (display-twr s)
    (read-line)))

(define scenes list)
(define choices list)
(define game-over null)

(struct choice (desc branch))

(struct scene (id desc choices))

(struct game (name author license topics desc scenes inits))

(define (build-game name author license topics desc scenes . inits)
  (game name author license topics desc scenes inits))

(define (create-game-env)
  (let ([vars (make-hash)])
    (lambda (message . body)
      (cond [(equal? message 'set)
             (hash-set! vars (car body) (cadr body))]
            [(equal? message 'get)
             (hash-ref vars (car body) null)]))))

(define (enumerate list)
  (define (enumerate-int list counter)
    (if (null? list) 
        null
        (cons (cons counter (car list))
              (enumerate-int (cdr list) (+ counter 1)))))
  (enumerate-int list 0))

(define (play-game game)
  (let ([name (game-name game)]
        [author (game-author game)]
        [license (game-license game)]
        [topics (game-topics game)]
        [desc (game-desc game)]
        [scenes (game-scenes game)]
        [inits (game-inits game)]
        [game-env (create-game-env)])
    (call/cc
     (lambda (exit^)
       (define (read-choice choices)
         (define (read-choice-loop)
           (let ([idx (string->number (string-trim (read-line)))])
             (cond [(false? idx)
                    (begin (displayln "please input a positive integer")
                           (read-choice-loop))]
                   [(< idx 1)
                    (begin (displayln "please input a positive integer")
                           (read-choice-loop))]
                   [(> idx (length choices))
                    (begin (displayln "input too big: no such choice")
                           (read-choice-loop))]
                   [else (list-ref choices (- idx 1))])))
            (read-choice-loop))
       (define (display-desc desc)
         (cond [(list? desc) (for-each display-desc desc)]
               [(procedure? desc) (display-desc (desc game-env))]
               [else (display-twr-pause desc)]))
       (define (play-game-int scene)
         (let ([id (scene-id scene)]
               [desc (scene-desc scene)]
               [choices (scene-choices scene)])
           (display-desc desc)
           (if (null? choices)
               (exit^ "game exited.")
               (begin
                 (for-each
                  (lambda (p)
                    (let ([idx (car p)]
                          [choice (cdr p)])
                      (displayln (string-append "  " (~a (+ 1 idx)) ". " (choice-desc choice)))))
                  (enumerate choices))
                 (display-flush "choice> ")
                 (let* ([choice (read-choice choices)]
                        [branch (choice-branch choice)]
                        [branch-actual (if (procedure? branch) (branch game-env) branch)]
                        [next-scene (find (lambda (scene) (= (scene-id scene) branch-actual))
                                          scenes)])
                   (cond [(false? next-scene)
                          (exit^ (string-append "sanity check failed: scene "
                                                (~a branch-actual)
                                                " does not exist"))]
                         [else (play-game-int next-scene)]))))))
       (begin
         (for-each (lambda (init) (init game-env)) inits)
         (displayln name)
         (displayln (string-append "created by: " author))
         (play-game-int (car scenes)))))))

(define (say x y) (string-append x "：「" y "」"))
