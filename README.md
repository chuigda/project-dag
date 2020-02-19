# project-dag
一个为文本 RPG 游戏设计的 DSL，主要用于和 xyy 的 [GalTextEngine](https://github.com/HoshinoTented/GalTextEngine) 进行“军备竞赛”，不过其本身的完成度远超预期。

## 设计思想
* 一个 RPG 游戏由若干个场景 `scene` 组成
* 每一个场景中有一段描述 `desc` 以及一堆选项 `choices`
  * `desc` 可以是给定的常量，这样它在整个游戏里就是一成不变的
  * `desc` 也可以由 `lambda` 表达式求值得到。 `lambda` 表达式有能力访问游戏的全局状态表 `game-env`，能改变某些状态，或者根据状态返回不同的 `desc`，参见 `game-with-env.rkt`
  * 为了方便话痨游戏，同时减少游戏的状态总数， `desc` 可以是嵌套了任意层的 `list`，参见 `big-gossip.rkt`
* 选择一个 `choice` 会让游戏移动到下一个 `scene`
  * 同理，移动到哪一个 `scene` 也可以由一个 `lambda` 表达式决定，同样参见 `game-with-env.rkt`
