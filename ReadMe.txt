Gives your new soldiers red armor. 
When soldiers reach a threshold rank or number of missions or kills they get their original colors back.

---
Configurable options:
Threshold, Mode (rank/missions/kills), PrimaryColor, SecondaryColor and ExcludeCharacterPool (whether you want characters from the pool to get red paint).

---
Known issues/shortcomings:
Uses a simple name comparison to check if a soldier is in the character pool, so a randomly named soldier will get the armor color of a pool character if one exists with the same name.
Adding the mod to an ongoing mission won't recolor any rookie soldiers until after the mission.
Ignores the unit templates used by character creation whatever those do.

---
Compability notes:
Does not override any classes.
UIScreenListener on UIAfterAction, UIArmory_Promotion, UIArmory_PromotionPsiOp and UIStrategyMap.