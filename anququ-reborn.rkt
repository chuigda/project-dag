#lang racket

(require "dagc.rkt")

(define (unknown-says sth) (say "？？？" sth))
(define (lxz-says sth) (say "凌筱竹师妹" sth))
(define (me-says sth) (say "Anqur" sth))

(define anququ-reborn
  (build-game 
    "重生实验室之安去去太强：偏二甲肼"
    "ICEY <icey@icey.tech>"
    'CC0
    '("重生" "无敌流" "安去去")
    (string-append "他累死累活，在科研领域作出顶级贡献，成果却被导师和师兄窃取。"
                   "因为常年劳累，他最终悲愤交加，病倒在工作台上！他仇恨，他不甘，"
                   "这一世，荣华富贵靠自己，我命由我不由天！")
    (scenes (scene 1 (list (unknown-says "师兄，快醒醒")
                           (me-says "唔... 我这是...")
                           (unknown-says "师兄，你的实验结果跑出来了")
                           (me-says "嗯，好...")
                           "抬起沉重的脑袋，下意识地看了下时间"
                           (me-says "今天是一月四日！？")
                           "我这是，重生了！？"
                           (unknown-says "是啊师兄，离DDL还有三天，快一起加油吧！")
                           "凌筱竹师妹的声音一直是这么温柔体贴，充满正能量"
                           "如果师妹对自己的感情是真的就好了..."
                           "上一世，就是这个平时对自己温柔体贴的师妹，被导师安排在身边"
                           "像一个间谍一样，窃取自己的研究进度"
                           (me-says "嗯...")
                           "... 那么，这一次，我会让你们知道，欺侮我的代价！"
                           (me-says "好的，（假装在看数据），那么我去把系统完善一下，你先去休息吧")
                           (lxz-says "诶？今天不用我帮忙调试了吗？")
                           (me-says "嗯，不用了，大致的优化思路我已经有了")
                           (lxz-says "可是DDL的话...")
                           "要怎么做呢")
                     (choices (choice "让师妹帮忙"   2)
                              (choice "谢绝师妹帮忙" 3)))
            (scene 2 (list "要是断然拒绝的话，会被那个老毒物怀疑的吧... "
                           (me-says "那你就留下来吧")
                           (lxz-says "好哒，我去给师兄泡茶"))
                     game-over)
            (scene 3 (list "不行，接下来是研究的关键部分"
                           "无论如何这部分内容不能被窃取"
                           "否则上一世的悲剧又会重演了"
                           (me-says "不用担心，接下来的事情我有把握")
                           (lxz-says "这样啊，那好吧")
                           "师妹脸上一脸失望的表情")
                     game-over)
            )))

(play-game anququ-reborn)
