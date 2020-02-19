#lang racket

(require "dagc.rkt")

(play-game
 (build-game "开除员工与副作用"
             "ICEY <icey@icey.tech>"
             'CC0
             '("朴实" "无华" "枯燥" "副作用")
             "这个游戏，就是这么地有副作用，且枯燥"
             (scenes
               (scene 1 "周一请闭眼，朱一旦请睁眼，今天你要开除员工吗？"
                        (choices (choice "开除" 
                                         (lambda (game-env) (if (= (game-env 'get 'cnt) 3)
                                                                3
                                                                2)))
                                 (choice "不开除" 4)))
               (scene 2
                 (lambda (game-env)
                   (begin
                     (game-env 'set 'cnt (+ (game-env 'get 'cnt) 1))
                     (string-append "无聊的周一，翻开我名下的杂志,随便指了一名十佳员工，吩咐人事经理把他辞退。"
                                    "你已经开除了 " (~a (game-env 'get 'cnt)) " 个员工。")))
                 (choices (choice "继续" 1)))
               (scene 3 "辞退的够多了，再这样下去，公司迟早要完旦"  game-over)
               (scene 4 "有钱人的快乐，往往就是这么朴实无华，且枯燥" game-over))
             (lambda (game-env) (game-env 'set 'cnt 0))))
