# Pokebot

Pokemon desmume bot. This is an autoit bot that attaches to desmume, detects game state, and sends input to control the game. It's inferior to OCR and memory based bots but I'm making a point on the internet, guys. If you care about metaphilosology behind this throwaway bot read Why below.

## Behavior

The bot will continuously move left and right until entering an encounter. Upon detecting an encounter, fight will always be selected, and the bot will rotate around the move list in a clockwise fashion to avoid issues with disable, pp exhausted, etc. As Nas muses about life until you die.

## Fainting

Fainting is detected, and a new pokemon will be selected. When exhausting PP, the pokemon use "struggle" which in turn causes damage to the attacking pokemon. It is suggested to exhaust all funds (leet balls of catching, infinihealz, status pwn++) before using this bot for long durations.

## Black out

Blacking out after hours of non healing is expected. The pokecenter return directions indicate a comma separated list of directions to take and the milliseconds the bot should go in that direction. The default is set right before victory road, a quick jaunt from the entrance.

## Tricks

Use lucky egg on the expected primary participating pokemon for max xp potential

Use Exp Share with lowest pokemon you want to level

There are a few parts of the game where followers autoheal. This areas are great for egg+share to leave overnight to get 2 pokemon maxed. Be aware of EV, however, it is likely worth getting to 100 and downgrading EV if desired since it should save more time.

# Why

"But narfman0, why not just cheat to get my pokemans level infinity with 2^16 ev and teh pwnzorz everythingearz?" Look buddy you can't go skating through life cheating everything can you? Life takes hard work sometimes, and sometimes dumb engineers redirect their hard work to creating neato image recognizing/ocring/ai/memory reading bots that shift the "job" to the computer, where all work should take place.

This bot is image recognition-only bot. If I have time in the next 3 days before my lecture ill make an OCRing only bot, and I've made a ton of memory reading bots so meh. Hopefully you learn stuff? That makes it all better, right?

# Install

Install AutoIT 3.x or above

# Usage

Ensure game is loaded, fast forward is set 4x for maximum potential (press = a few times), window size is 1x

Execute pokebot.au3 with the appropriate architecture for your machine (if on 64 bit OS, "Run Script (x64)")

Use the UI or pause via keyboard with the "pause" key. Close via system tray when desired.

It is recommended to leave the game on fast forward. The bot uses PixelSearch and ImageSearch and should be left at 1x resolution. Horizontal or Vertical windows are fine. Do not use anything other than 1x - it may look like its working ok, but is untested and unnecessarily CPU intensive.