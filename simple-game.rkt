#lang racket

(require "dagc.rkt")

(play-game
 (build-game "朴实无华且枯燥"
             "ICEY <icey@icey.tech>"
             'CC0
             '("朴实" "无华" "枯燥")
             "这个游戏，就是这么地朴实无华，且枯燥"
             (scenes
               (scene 1 "这个游戏是不是很枯燥"
                      (choices (choice "枯燥" 2)
                               (choice "不枯燥" 3)))
               (scene 2 "无聊的周一，翻开我名下的杂志，随便指了一名十佳员工，吩咐人事经理把他辞退。" 
                      game-over)
               (scene 3 "你看，这就是你的不对了" game-over))))
