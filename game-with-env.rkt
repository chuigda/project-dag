#lang racket

(require "dagc.rkt")

(define game
 (build-game "开除员工与副作用"
             "ICEY <icey@icey.tech>"
             'CC0
             '("朴实" "无华" "枯燥" "副作用")
             "这个游戏，就是这么地有副作用，且枯燥"
             (scenes
               (scene 1 "无聊的周一，朱一旦请睁眼，今天你要开除员工吗？"
                        (choices (choice "开除"
                                         ; 这里不再使用一个常量来决定移动到哪一个场景
                                         ; 而是使用一个 lambda，根据游戏环境 game-env 中的 'cnt
                                         ; 确定移动到那个状态
                                         (lambda (game-env) (if (= (game-env 'get 'cnt) 3)
                                                                ; 如果已经开除了三个员工，就此收手
                                                                3
                                                                ; 否则继续开除，已经开除的员工数量+1
                                                                (begin
                                                                  (game-env 'set 'cnt 
                                                                            (+ (game-env 'get 'cnt) 
                                                                               1))
                                                                  2))))
                                 (choice "不开除" 4)))
               (scene 2
                 ; 这里也不再使用常量作为 desc，而是根据 game-env 中的 'cnt 更新desc
                 ; 注意：不建议在场景描述生成器里改变game-env，否则可能造成存档问题
                 (lambda (game-env)
                   (begin
                     (string-append "无聊的周一，翻开我名下的杂志，随便指了一名十佳员工，"
                                    "吩咐人事经理把他辞退。\n"
                                    "你已经开除了 " (~a (game-env 'get 'cnt)) " 个员工。")))
                 (choices (choice "继续" 1)))
               (scene 3 "辞退的够多了，再这样下去，公司迟早要完旦"  game-over)
               (scene 4 "有钱人的快乐，往往就是这么朴实无华，且枯燥" game-over))
             ; 初始化动作，设置游戏环境中 'cnt 初始为 0
             ; 初始化动作可以有多个，从上向下依次执行
             (lambda (game-env) (game-env 'set 'cnt 0))))

; 存档系统演示
(define game-result (play-game game))
; 如果玩家在作出选择时输入了 save，游戏暂停保存，play-game 会返回继续游戏所需的所有信息
(if (pair? game-result)
    ; 使用 load-game 就可以读档接着玩
    (load-game game game-result)
    (void))
