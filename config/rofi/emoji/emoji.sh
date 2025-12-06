#!/usr/bin/env bash

dir="$HOME/.config/rofi"
theme='style-1'

# Create emoji list with common emojis
emoji_list="😀 Grinning Face
😃 Grinning Face with Big Eyes
😄 Grinning Face with Smiling Eyes
😁 Beaming Face with Smiling Eyes
😅 Grinning Face with Sweat
😂 Face with Tears of Joy
🤣 Rolling on the Floor Laughing
😊 Smiling Face with Smiling Eyes
😇 Smiling Face with Halo
🙂 Slightly Smiling Face
🙃 Upside-Down Face
😉 Winking Face
😌 Relieved Face
😍 Smiling Face with Heart-Eyes
🥰 Smiling Face with Hearts
😘 Face Blowing a Kiss
😗 Kissing Face
😙 Kissing Face with Smiling Eyes
😚 Kissing Face with Closed Eyes
😋 Face Savoring Food
😛 Face with Tongue
😝 Squinting Face with Tongue
😜 Winking Face with Tongue
🤪 Zany Face
🤨 Face with Raised Eyebrow
🧐 Face with Monocle
🤓 Nerd Face
😎 Smiling Face with Sunglasses
🤩 Star-Struck
🥳 Partying Face
😏 Smirking Face
😒 Unamused Face
😞 Disappointed Face
😔 Pensive Face
😟 Worried Face
😕 Confused Face
🙁 Slightly Frowning Face
☹️ Frowning Face
😣 Persevering Face
😖 Confounded Face
😫 Tired Face
😩 Weary Face
🥺 Pleading Face
😢 Crying Face
😭 Loudly Crying Face
😤 Face with Steam From Nose
😠 Angry Face
😡 Pouting Face
🤬 Face with Symbols on Mouth
🤯 Exploding Head
😳 Flushed Face
🥵 Hot Face
🥶 Cold Face
😱 Face Screaming in Fear
😨 Fearful Face
😰 Anxious Face with Sweat
😥 Sad but Relieved Face
😓 Downcast Face with Sweat
🤗 Hugging Face
🤔 Thinking Face
🤭 Face with Hand Over Mouth
🤫 Shushing Face
🤥 Lying Face
😶 Face Without Mouth
😐 Neutral Face
😑 Expressionless Face
😬 Grimacing Face
🙄 Face with Rolling Eyes
😯 Hushed Face
😦 Frowning Face with Open Mouth
😧 Anguished Face
😮 Face with Open Mouth
😲 Astonished Face
🥱 Yawning Face
😴 Sleeping Face
🤤 Drooling Face
😪 Sleepy Face
😵 Dizzy Face
🤐 Zipper-Mouth Face
🥴 Woozy Face
🤢 Nauseated Face
🤮 Face Vomiting
🤧 Sneezing Face
😷 Face with Medical Mask
🤒 Face with Thermometer
🤕 Face with Head-Bandage
🤑 Money-Mouth Face
🤠 Cowboy Hat Face
👍 Thumbs Up
👎 Thumbs Down
👏 Clapping Hands
🙌 Raising Hands
👐 Open Hands
🤲 Palms Up Together
🤝 Handshake
🙏 Folded Hands
✌️ Victory Hand
🤞 Crossed Fingers
🤟 Love-You Gesture
🤘 Sign of the Horns
👌 OK Hand
🤏 Pinching Hand
👈 Backhand Index Pointing Left
👉 Backhand Index Pointing Right
👆 Backhand Index Pointing Up
👇 Backhand Index Pointing Down
☝️ Index Pointing Up
✋ Raised Hand
🤚 Raised Back of Hand
🖐️ Hand with Fingers Splayed
🖖 Vulcan Salute
👋 Waving Hand
🤙 Call Me Hand
💪 Flexed Biceps
🦾 Mechanical Arm
🖕 Middle Finger
✍️ Writing Hand
🙏 Folded Hands
❤️ Red Heart
🧡 Orange Heart
💛 Yellow Heart
💚 Green Heart
💙 Blue Heart
💜 Purple Heart
🖤 Black Heart
🤍 White Heart
🤎 Brown Heart
💔 Broken Heart
❣️ Heart Exclamation
💕 Two Hearts
💞 Revolving Hearts
💓 Beating Heart
💗 Growing Heart
💖 Sparkling Heart
💘 Heart with Arrow
💝 Heart with Ribbon
💟 Heart Decoration
⭐ Star
🌟 Glowing Star
✨ Sparkles
⚡ High Voltage
🔥 Fire
💥 Collision
💫 Dizzy
💦 Sweat Droplets
💨 Dashing Away
🕊️ Dove
🦅 Eagle
🦆 Duck
🦉 Owl
🐧 Penguin
🐦 Bird
🐤 Baby Chick
🐣 Hatching Chick
🐥 Front-Facing Baby Chick
🦋 Butterfly
🐛 Bug
🐌 Snail
🐞 Lady Beetle
🐜 Ant
🦗 Cricket
🕷️ Spider
🕸️ Spider Web
🦂 Scorpion
🐢 Turtle
🐍 Snake
🦎 Lizard
🦖 T-Rex
🦕 Sauropod
🐙 Octopus
🦑 Squid
🦐 Shrimp
🦞 Lobster
🦀 Crab
🐡 Blowfish
🐠 Tropical Fish
🐟 Fish
🐬 Dolphin
🐳 Spouting Whale
🐋 Whale
🦈 Shark
🐊 Crocodile
🐅 Tiger
🐆 Leopard
🦓 Zebra
🦍 Gorilla
🦧 Orangutan
🐘 Elephant
🦛 Hippopotamus
🦏 Rhinoceros
🐪 Camel
🐫 Two-Hump Camel
🦒 Giraffe
🦘 Kangaroo
🐃 Water Buffalo
🐂 Ox
🐄 Cow
🐎 Horse
🐖 Pig
🐏 Ram
🐑 Ewe
🐐 Goat
🦌 Deer
🐕 Dog
🐩 Poodle
🦮 Guide Dog
🐕‍🦺 Service Dog
🐈 Cat
🐈‍⬛ Black Cat
🦁 Lion
🐯 Tiger Face
🐱 Cat Face
🐶 Dog Face
🐺 Wolf
🦊 Fox
🦝 Raccoon
🐻 Bear
🐨 Koala
🐼 Panda
🦥 Sloth
🦦 Otter
🦨 Skunk
🦘 Kangaroo
🦡 Badger
🐾 Paw Prints
🍎 Red Apple
🍊 Tangerine
🍋 Lemon
🍌 Banana
🍉 Watermelon
🍇 Grapes
🍓 Strawberry
🫐 Blueberries
🍈 Melon
🍒 Cherries
🍑 Peach
🥭 Mango
🍍 Pineapple
🥥 Coconut
🥝 Kiwi Fruit
🍅 Tomato
🍆 Eggplant
🥑 Avocado
🥦 Broccoli
🥬 Leafy Green
🥒 Cucumber
🌶️ Hot Pepper
🫑 Bell Pepper
🌽 Ear of Corn
🥕 Carrot
🫒 Olive
🧄 Garlic
🧅 Onion
🥔 Potato
🍠 Roasted Sweet Potato
🥐 Croissant
🥯 Bagel
🍞 Bread
🥖 Baguette Bread
🥨 Pretzel
🧀 Cheese Wedge
🥚 Egg
🍳 Cooking
🧈 Butter
🥞 Pancakes
🧇 Waffle
🥓 Bacon
🥩 Cut of Meat
🍗 Poultry Leg
🍖 Meat on Bone
🦴 Bone
🌭 Hot Dog
🍔 Hamburger
🍟 French Fries
🍕 Pizza
🥪 Sandwich
🥙 Stuffed Flatbread
🧆 Falafel
🌮 Taco
🌯 Burrito
🫔 Tamale
🥗 Green Salad
🥘 Shallow Pan of Food
🫕 Fondue
🥫 Canned Food
🍝 Spaghetti
🍜 Steaming Bowl
🍲 Pot of Food
🍛 Curry Rice
🍣 Sushi
🍱 Bento Box
🥟 Dumpling
🦪 Oyster
🍤 Fried Shrimp
🍙 Rice Ball
🍚 Cooked Rice
🍘 Rice Cracker
🍥 Fish Cake with Swirl
🥠 Fortune Cookie
🥮 Moon Cake
🍢 Oden
🍡 Dango
🍧 Shaved Ice
🍨 Ice Cream
🍦 Soft Ice Cream
🥧 Pie
🧁 Cupcake
🍰 Shortcake
🎂 Birthday Cake
🍮 Custard
🍭 Lollipop
🍬 Candy
🍫 Chocolate Bar
🍿 Popcorn
🍩 Doughnut
🍪 Cookie
🌰 Chestnut
🥜 Peanuts
🍯 Honey Pot
🥛 Glass of Milk
🍼 Baby Bottle
☕ Hot Beverage
🫖 Teapot
🍵 Teacup Without Handle
🍶 Sake
🍾 Bottle with Popping Cork
🍷 Wine Glass
🍸 Cocktail Glass
🍹 Tropical Drink
🍺 Beer Mug
🍻 Clinking Beer Mugs
🥂 Clinking Glasses
🥃 Tumbler Glass
🥤 Cup with Straw
🧋 Bubble Tea
🧃 Beverage Box
🧉 Mate
🧊 Ice
⚽ Soccer Ball
🏀 Basketball
🏈 American Football
⚾ Baseball
🥎 Softball
🎾 Tennis
🏐 Volleyball
🏉 Rugby Football
🥏 Flying Disc
🎱 Pool 8 Ball
🪀 Yo-Yo
🏓 Ping Pong
🏸 Badminton
🏒 Ice Hockey
🏑 Field Hockey
🥍 Lacrosse
🏏 Cricket Game
🥅 Goal Net
⛳ Flag in Hole
🪁 Kite
🏹 Bow and Arrow
🎣 Fishing Pole
🤿 Diving Mask
🥊 Boxing Glove
🥋 Martial Arts Uniform
🎽 Running Shirt
🛹 Skateboard
🛼 Roller Skate
🛷 Sled
⛸️ Ice Skate
🥌 Curling Stone
🎿 Skis
⛷️ Skier
🏂 Snowboarder
🪂 Parachute
🏋️ Person Lifting Weights
🤼 People Wrestling
🤸 Person Cartwheeling
⛹️ Person Bouncing Ball
🤺 Person Fencing
🤾 Person Playing Handball
🏌️ Person Golfing
🏇 Horse Racing
🧘 Person in Lotus Position
🏄 Person Surfing
🏊 Person Swimming
🤽 Person Playing Water Polo
🚣 Person Rowing Boat
🧗 Person Climbing
🚵 Person Mountain Biking
🚴 Person Biking
🏆 Trophy
🥇 1st Place Medal
🥈 2nd Place Medal
🥉 3rd Place Medal
🏅 Sports Medal
🎖️ Military Medal
🏵️ Rosette
🎗️ Reminder Ribbon
🎫 Ticket
🎟️ Admission Tickets
🎪 Circus Tent
🤹 Person Juggling
🎭 Performing Arts
🩰 Ballet Shoes
🎨 Artist Palette
🎬 Clapper Board
🎤 Microphone
🎧 Headphone
🎼 Musical Score
🎹 Musical Keyboard
🥁 Drum
🪘 Long Drum
🎷 Saxophone
🎺 Trumpet
🎸 Guitar
🪕 Banjo
🎻 Violin
🎲 Game Die
♟️ Chess Pawn
🎯 Direct Hit
🎳 Bowling
🎮 Video Game
🎰 Slot Machine
🧩 Puzzle Piece
🚗 Automobile
🚕 Taxi
🚙 Sport Utility Vehicle
🚌 Bus
🚎 Trolleybus
🏎️ Racing Car
🚓 Police Car
🚑 Ambulance
🚒 Fire Engine
🚐 Minibus
🛻 Pickup Truck
🚚 Delivery Truck
🚛 Articulated Lorry
🚜 Tractor
🛴 Kick Scooter
🦽 Manual Wheelchair
🦼 Motorized Wheelchair
🛺 Auto Rickshaw
🚲 Bicycle
🛵 Motor Scooter
🏍️ Motorcycle
🛞 Wheel
✈️ Airplane
🛩️ Small Airplane
🛫 Airplane Departure
🛬 Airplane Arrival
🪂 Parachute
💺 Seat
🚁 Helicopter
🚟 Suspension Railway
🚠 Mountain Cableway
🚡 Aerial Tramway
🛰️ Satellite
🚀 Rocket
🛸 Flying Saucer
🚉 Station
🚞 Mountain Railway
🚝 Monorail
🚄 High-Speed Train
🚅 Bullet Train
🚈 Light Rail
🚂 Locomotive
🚆 Train
🚇 Metro
🚊 Tram
🚃 Railway Car
🚋 Tram Car
🚌 Bus
🚍 Oncoming Bus
🚎 Trolleybus
🚐 Minibus
🚑 Ambulance
🚒 Fire Engine
🚓 Police Car
🚔 Oncoming Police Car
🚕 Taxi
🚖 Oncoming Taxi
🚗 Automobile
🚘 Oncoming Automobile
🚙 Sport Utility Vehicle
🛻 Pickup Truck
🚚 Delivery Truck
🚛 Articulated Lorry
🚜 Tractor
🏁 Chequered Flag
🚩 Triangular Flag
🎌 Crossed Flags
🏴 Black Flag
🏳️ White Flag
🏳️‍🌈 Rainbow Flag
🏳️‍⚧️ Transgender Flag
🏴‍☠️ Pirate Flag
⌚ Watch
📱 Mobile Phone
📲 Mobile Phone with Arrow
💻 Laptop
⌨️ Keyboard
🖥️ Desktop Computer
🖨️ Printer
🖱️ Computer Mouse
🖲️ Trackball
🕹️ Joystick
🗜️ Clamp
💽 Computer Disk
💾 Floppy Disk
💿 Optical Disk
📀 DVD
📼 Videocassette
📷 Camera
📸 Camera with Flash
📹 Video Camera
🎥 Movie Camera
📽️ Film Projector
🎞️ Film Frames
📞 Telephone Receiver
☎️ Telephone
📟 Pager
📠 Fax Machine
📺 Television
📻 Radio
🎙️ Studio Microphone
🎚️ Level Slider
🎛️ Control Knobs
🧭 Compass
⏱️ Stopwatch
⏲️ Timer Clock
⏰ Alarm Clock
🕰️ Mantelpiece Clock
⌛ Hourglass Done
⏳ Hourglass Not Done
📡 Satellite Antenna
🔋 Battery
🔌 Electric Plug
💡 Light Bulb
🔦 Flashlight
🕯️ Candle
🪔 Diya Lamp
🧯 Fire Extinguisher
🛢️ Oil Drum
💸 Money with Wings
💵 Dollar Banknote
💴 Yen Banknote
💶 Euro Banknote
💷 Pound Banknote
💰 Money Bag
💳 Credit Card
💎 Gem Stone
⚖️ Balance Scale
🧰 Toolbox
🔧 Wrench
🔨 Hammer
⚒️ Hammer and Pick
🛠️ Hammer and Wrench
⛏️ Pick
🔩 Nut and Bolt
⚙️ Gear
🧱 Brick
⛓️ Chains
🧲 Magnet
🔫 Pistol
💣 Bomb
🧨 Firecracker
🪓 Axe
🔪 Kitchen Knife
🗡️ Dagger
⚔️ Crossed Swords
🛡️ Shield
🚬 Cigarette
⚰️ Coffin
🪦 Headstone
⚱️ Funeral Urn
🏺 Amphora
🔮 Crystal Ball
📿 Prayer Beads
🧿 Nazar Amulet
💈 Barber Pole
⚗️ Alembic
🔭 Telescope
🔬 Microscope
🕳️ Hole
🩹 Adhesive Bandage
🩺 Stethoscope
💊 Pill
💉 Syringe
🩸 Drop of Blood
🧬 DNA
🦠 Microbe
🧫 Petri Dish
🧪 Test Tube
🌡️ Thermometer
🧹 Broom
🧺 Basket
🧻 Roll of Paper
🚽 Toilet
🚰 Potable Water
🚿 Shower
🛁 Bathtub
🛀 Person Taking Bath
🧼 Soap
🪒 Razor
🧽 Sponge
🧴 Lotion Bottle
🛎️ Bellhop Bell
🔑 Key
🗝️ Old Key
🚪 Door
🪑 Chair
🛋️ Couch and Lamp
🛏️ Bed
🛌 Person in Bed
🧸 Teddy Bear
🖼️ Framed Picture
🪞 Mirror
🪟 Window
🛍️ Shopping Bags
🛒 Shopping Cart
🎁 Wrapped Gift
🎈 Balloon
🎏 Carp Streamer
🎀 Ribbon
🎊 Confetti Ball
🎉 Party Popper
🎎 Japanese Dolls
🏮 Red Paper Lantern
🎐 Wind Chime
🧧 Red Envelope
✉️ Envelope
📩 Envelope with Arrow
📨 Incoming Envelope
📧 E-Mail
💌 Love Letter
📥 Inbox Tray
📤 Outbox Tray
📦 Package
🏷️ Label
📪 Closed Mailbox with Lowered Flag
📫 Closed Mailbox with Raised Flag
📬 Open Mailbox with Raised Flag
📭 Open Mailbox with Lowered Flag
📮 Postbox
🗳️ Ballot Box with Ballot
✏️ Pencil
✒️ Black Nib
🖋️ Fountain Pen
🖊️ Pen
🖌️ Paintbrush
🖍️ Crayon
📝 Memo
💼 Briefcase
📁 File Folder
📂 Open File Folder
🗂️ Card Index Dividers
📅 Calendar
📆 Tear-Off Calendar
🗒️ Spiral Notepad
🗓️ Spiral Calendar
📇 Card Index
📈 Chart Increasing
📉 Chart Decreasing
📊 Bar Chart
📋 Clipboard
📌 Pushpin
📍 Round Pushpin
📎 Paperclip
🖇️ Linked Paperclips
📏 Straight Ruler
📐 Triangular Ruler
✂️ Scissors
🗃️ Card File Box
🗄️ File Cabinet
🗑️ Wastebasket
🔒 Locked
🔓 Unlocked
🔏 Locked with Pen
🔐 Locked with Key
🔑 Key
🗝️ Old Key
🔨 Hammer
🪓 Axe
⛏️ Pick
⚒️ Hammer and Pick
🛠️ Hammer and Wrench
🗡️ Dagger
⚔️ Crossed Swords
🔫 Pistol
🪃 Boomerang
🏹 Bow and Arrow
🛡️ Shield
🪚 Carpentry Saw
🔧 Wrench
🪛 Screwdriver
🔩 Nut and Bolt
⚙️ Gear
🗜️ Clamp
⚖️ Balance Scale
🦯 White Cane
🔗 Link
⛓️ Chains
🪝 Hook
🧰 Toolbox
🧲 Magnet
🪜 Ladder
⚗️ Alembic
🧪 Test Tube
🧫 Petri Dish
🧬 DNA
🔬 Microscope
🔭 Telescope
📡 Satellite Antenna
💉 Syringe
🩸 Drop of Blood
💊 Pill
🩹 Adhesive Bandage
🩺 Stethoscope
🌡️ Thermometer
🧹 Broom
🪠 Plunger
🧺 Basket
🧻 Roll of Paper
🪣 Bucket
🧼 Soap
🪥 Toothbrush
🧽 Sponge
🧴 Lotion Bottle
🛁 Bathtub
🪒 Razor
🧷 Safety Pin
🧹 Broom
🧺 Basket
🧻 Roll of Paper
🧼 Soap
🧽 Sponge
🧴 Lotion Bottle
✅ Check Mark Button
✔️ Check Mark
❌ Cross Mark
❎ Cross Mark Button
➕ Plus
➖ Minus
➗ Division Sign
✖️ Multiplication Sign
♾️ Infinity
💯 Hundred Points
🔢 Input Numbers
🔣 Input Symbols
🔤 Input Latin Letters
🔡 Input Latin Lowercase
🔠 Input Latin Uppercase
🆗 OK Button
🆕 NEW Button
🆙 UP! Button
🆒 COOL Button
🆓 FREE Button
ℹ️ Information
🆔 ID Button
Ⓜ️ Circled M
🆖 NG Button
🆘 SOS Button
🆚 VS Button
🈁 Japanese Here Button
🈂️ Japanese Service Charge Button
🈷️ Japanese Monthly Amount Button
🈶 Japanese Not Free of Charge Button
🈯 Japanese Reserved Button
🉐 Japanese Bargain Button
🈹 Japanese Discount Button
🈚 Japanese Free of Charge Button
🈲 Japanese Prohibited Button
🉑 Japanese Acceptable Button
🈸 Japanese Application Button
🈴 Japanese Passing Grade Button
🈳 Japanese Vacancy Button
㊗️ Japanese Congratulations Button
㊙️ Japanese Secret Button
🈺 Japanese Open for Business Button
🈵 Japanese No Vacancy Button
🔴 Red Circle
🟠 Orange Circle
🟡 Yellow Circle
🟢 Green Circle
🔵 Blue Circle
🟣 Purple Circle
🟤 Brown Circle
⚫ Black Circle
⚪ White Circle
🟥 Red Square
🟧 Orange Square
🟨 Yellow Square
🟩 Green Square
🟦 Blue Square
🟪 Purple Square
🟫 Brown Square
⬛ Black Large Square
⬜ White Large Square
◼️ Black Medium Square
◻️ White Medium Square
◾ Black Medium-Small Square
◽ White Medium-Small Square
▪️ Black Small Square
▫️ White Small Square
🔶 Large Orange Diamond
🔷 Large Blue Diamond
🔸 Small Orange Diamond
🔹 Small Blue Diamond
🔺 Red Triangle Pointed Up
🔻 Red Triangle Pointed Down
💠 Diamond with a Dot
🔘 Radio Button
🔳 White Square Button
🔲 Black Square Button"

# Show emoji picker using rofi
selected=$(echo "$emoji_list" | rofi -dmenu -i -p "Emoji" -theme ${dir}/${theme}.rasi -format 's')

# Extract just the emoji (first character) and copy to clipboard
if [ -n "$selected" ]; then
    emoji=$(echo "$selected" | awk '{print $1}')
    echo -n "$emoji" | wl-copy
    notify-send "Emoji Copied" "$emoji"
fi
