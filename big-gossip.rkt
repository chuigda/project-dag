#lang racket

(require "dagc.rkt")

(play-game
 (build-game "朴实无华且话痨"
             "ICEY <icey@icey.tech>"
             'CC0
             '("朴实" "无华" "话痨")
             "有钱人的游戏，就是这么地朴实无华，且话痨"
             (scenes
               (scene 1 
                      ; 这个代码即文档很明确了吧
                      ; 通常来说，desc 中的每一“项”会被单独打印到一行，并且打印完成后要求用户回车
                      ; 可以运行一下试试看
                      (list "实践表明，人类也许喜欢话痨"
                            "这一点是从很多 Galgame 和 RPG 上得出的"
                            "你像 Free Friends 2"
                            "你像 Fate Stay Night"
                            "又如星野野的蜜汁 Galgame"
                            "对话占据了大部分内容"
                            "而实际上的选择只占据一小部分"
                            "而有的时候选择甚至对游戏的发展没有影响"
                            "为了顺应这种话痨的需求，我们增加了"
                            (lambda (game-env) (list "甚至是这种"
                                                     (lambda (game-env) "套娃形式的")))
                            "话痨模式支持"
                            "你问我为什么要支持这种无聊的套娃？"
                            "因为 我  疯~~~~~~ 了！"
                            "好吧，祝你玩的愉快")
                      (choices (choice "好的，多谢" 2)))
               (scene 2 "游戏结束" game-over))))
