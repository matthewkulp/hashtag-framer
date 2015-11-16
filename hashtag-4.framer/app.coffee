Framer.Device.background.backgroundColor = "purple"
Framer.Device.background.backgroundColor = "#B4DCD8"

sketch = Framer.Importer.load "imported/2015.10"
Framer.Device.phone.image = ""





chatScreen = sketch.chat
chatScreen.opacity = 0

keyboard = sketch.keyboard

topics = sketch.topics
topicsEndY = topics.y

suggestedTopics = sketch.suggested
suggestedTopics.opacity = 0

notOneMore = sketch.notOneMore
notOneMoreEndY = notOneMore.y
notOneMore.opacity = 0
close = sketch.close
arrowDown = sketch.arrowDown

addTopic = sketch.addTopic
addTopicEndY = addTopic.y
addTopic.y -= notOneMore.height

create = sketch.create

hashtagTopic = sketch.hashtagTopic

nLetter = sketch.n
nLetter.opacity = 0

oLetter = sketch.o
oLetter.opacity = 0

tLetter = sketch.t
tLetter.opacity = 0

muteSymbol = sketch.mutePP

plus = sketch.plus

standWithPPAbove = sketch.standWithPPtop
standWithPPBelow = sketch.muteHiddenBar


hashtagPPRed = sketch.hashtagPP
hashtagPPGray = sketch.hashtagPPOld
atMentions = sketch.atMentions


# Blocking out create for desired entrance effect
createBlock = new Layer
	superLayer: addTopic
	x: 0
	y: 86
	width: 750
	height: 50
	backgroundColor: 'white'

closeBlock = new Layer
	superLayer: notOneMore
	x: 0
	y: 86
	width: 750
	height: 50
	backgroundColor: 'white'
	
standBlock = new Layer
	superLayer: standWithPPAbove
	x: 0
	y: 96
	width: 750
	height: 50
	backgroundColor: 'white'	


loadingCircle = sketch.loadingCircle
loadingCircle.props = 
	opacity: 0
	rotation: 45
# 	scale: .75

cellItemYDisplacement = 50
cellItemYDisplacementTime = .2
createEndY = create.y
create.y += cellItemYDisplacement

closeEndY = close.y
close.y += cellItemYDisplacement

arrowDownEndY = arrowDown.y
arrowDown.y += cellItemYDisplacement

muteSymbolEndY = muteSymbol.y
muteSymbol.y += cellItemYDisplacement

susanne = sketch.susanne2
henry1 = sketch.henry1
hannah1 = sketch.hannah1
henry2 = sketch.henry2
hannah2 = sketch.hannah2

messageArray = [susanne, henry1, hannah1, henry2, hannah2]
messageArrayReverse = [hannah2, henry2, hannah1, henry1, susanne]

compose = sketch.compose
composeEndY = compose.y
compose.y += compose.height

topicsBG = sketch.topicsBG
topicsBGBottom = sketch.topicsBGBottom

messageGroup = sketch.messageGroup

scroll = ScrollComponent.wrap(messageGroup)
scroll.props = 
	scrollHorizontal: false
	scrollY: 400

messages = sketch.messages

threeCount = sketch.threeCount
fourCount = sketch.fourCount

fourCount.opacity = 0

# Keyboard animations	
keyboardEndY = keyboard.y
keyboard.y = 1334

openKeyboard = new Animation
	layer: keyboard
	properties:
		y: keyboardEndY
	time: .4

closeKeyboard = openKeyboard.reverse()

hashtagTopicEndY = hashtagTopic.y
hashtagTopic.y += cellItemYDisplacement

topicRetractedY = -528



blinkingCursor = sketch.blinkingCursor
blinkingCursor.opacity = 0

topicsBGBottomEndY = topicsBGBottom.y



touchCircle = new Layer
	width: 30
	height: 30
	borderRadius: 30
	backgroundColor: 'lightgray'
	opacity: 0
	

touch = (xPos, yPos, time, holdTime) ->
	animationTime = .25
	scaleDelay = 0
	touchCircle.opacity = 1
	
	if (time)
		animationTime = time
	
	if (holdTime)
		scaleDelay = holdTime
		touchCircle.props = 
			scale: 2.7
			opacity: .4
		
	
	circleExpand = new Animation
		layer: touchCircle
		properties: 
			scale: 6
		curve: 'ease-out'
		time: animationTime
		delay: scaleDelay
		
	circleFade = new Animation
		layer: touchCircle
		properties:
			opacity: 0
		curve: 'ease-out'
		time: animationTime
		delay: scaleDelay
	
	touchCircle.x = xPos
	touchCircle.y = yPos
	
	circleFade.start()
	circleExpand.start()
	
	circleExpand.on "end", ->
		touchCircle.scale = 1




swipeDisplace = 190










notTagGray = sketch.notTagGray
notTagRed = sketch.notTagRed

mute = sketch.mute
mute.props = 
	opacity: 0
	scale: .8

startCursorBlink = ->
# 	Cursor blinking and moving
	blinkingCursor.opacity = 0
	visibility = 1
	i = 0
	blinkOn = ->
		if (i < 8)
			blinkingCursor.animate
				properties: 
					opacity: 1 * visibility
				time: .1
			
			blinkingCursor.on 'end', ->
				blinkOff()		
			i++
		
	blinkOff = ->
		visibility *= -1
		Utils.delay .3, ->
			blinkOn()
			
	blinkOn()





mutePP = ->
	
	openMute = new Animation
		layer: standWithPPAbove
		properties:
			x: 190
		time: .35
	
	closeMute = openMute.reverse()
	
	muteTextEnters = new Animation
		layer: mute
		properties:
			opacity: 1
			scale: 1
		time: .25
		delay: .1
	
	muteTextExits = muteTextEnters.reverse()
	
	openMute.start()
	muteTextEnters.start()
	
	openMute.on Events.AnimationEnd, ->
		muteTextExits.start()
		
		hashtagPPRed.animate
			properties:
				opacity: 0
			time: cellItemYDisplacementTime
			
		Utils.delay .2, ->
			closeMute.start()
			

		Utils.delay .48, ->			
			atMentions.animate
				properties:
					y: atMentions.y + cellItemYDisplacement
				time: cellItemYDisplacementTime
			
			muteSymbol.animate
				properties:
					y: muteSymbolEndY
				time: cellItemYDisplacementTime
				delay: .15




openAddTopic = ->
#	Change this Y to have the up and down of the interaction less dramatic.
	Utils.delay .15, ->
		topics.animate
			properties:
				y: topicRetractedY - 96 
			time: .45
		
		plus.animate
			properties:
				y: plus.y + cellItemYDisplacement
			time: cellItemYDisplacementTime
			delay: .45
		
		Utils.delay .5, ->		
			hashtagTopic.animate
				properties:
					y: hashtagTopicEndY
				time: cellItemYDisplacementTime
	
			openKeyboard.start()
			startCursorBlink()
	


	
typeNLetter = ->
	create.animate
		properties:
			y: createEndY
		time: cellItemYDisplacementTime
		
	nLetter.opacity = 1
	blinkingCursor.opacity = 1
	blinkingCursor.x += 20
	

typeOLetter = ->
	oLetter.opacity = 1
	blinkingCursor.opacity = 1
	blinkingCursor.x += 21
	

typeTLetter = ->	
	tLetter.opacity = 1
	blinkingCursor.opacity = 1
	blinkingCursor.x += 13
		

# suggestedTopics.opacity = .4
suggestionsEnter = new Animation
	layer: suggestedTopics
	properties:
		opacity: 1
	time: .2
	
suggestionsExit = suggestionsEnter.reverse()


selectSuggestedTopic = ->

	closeKeyboard.start()
	suggestionsExit.start()
	
	notOneMore.y += 296
	notOneMore.animate
		properties:
			opacity: 1
		time: .15

	exitAddTopic = addTopic.animate
		properties:
			y: addTopic.y - addTopic.height
		time: .2
		
	exitAddTopic.on 'end', ->
		
		plus.opacity = 1
		create.opacity = 0	
		hashtagTopic.opacity = 0
		nLetter.opacity = 0
		oLetter.opacity = 0
		tLetter.opacity = 0
		addTopic.y = addTopicEndY
		addTopic.opacity = 1
		threeCount.opacity = 0
		fourCount.opacity = 1


	Utils.delay .5, ->	
		topics.animate
			properties:
				y: topicsEndY
			time: .5
	
		notOneMore.animate
			properties:
				y: notOneMoreEndY
			time: .5

		plus.animate
			properties:
				y: plus.y - cellItemYDisplacement
			time: cellItemYDisplacementTime
			delay: .5
	
	
newMessage = ->
	notTagGray.animate
		properties:
			opacity: 0
		time: .2

	redTagDisplace = 18	
	redTagup = notTagRed.animate
		properties:
			y: notTagRed.y - redTagDisplace
			scaleY: 1.1
		time: .2
		
	redTagup.on 'end', ->
		notTagRed.animate
			properties:
				y: notTagRed.y + redTagDisplace
				scaleY: 1
			curve: 'spring'
		
 
openNotOneMore = ->
	#	Move everything below the selected topics off the bottom of the screen
	Utils.delay .2, ->
		addTopic.superLayer = topicsBGBottom
		addTopic.y = 84		
		topicsBGBottom.animate
			properties:
				y: 1334
			time: .5
	
	# 	Move the topics up with their background
		topics.animate
			properties:
				y: topicRetractedY
			time: .5
		
		topicsBG.animate
			properties:
				y: -topicsBG.height + notOneMore.height
			time: .5
	
	
	#	transform topic cell into functional header
		arrowDown.animate
			properties:
				y: arrowDownEndY
			time: cellItemYDisplacementTime
			delay: .6
		
		close.animate
			properties:
				y: closeEndY
			time: cellItemYDisplacementTime
			delay: .5
	
					
		notTagGray.animate
			properties:
				opacity: 1
			time: cellItemYDisplacementTime
			delay: .4
	
		
		loadingCircle.animate
			properties:
				opacity: .5
			time: .4
			delay: .6
		
		s = 0
		loadingCircleSpins = new Animation
			layer: loadingCircle
			properties:
				rotation: 405
			time: 1.1
			curve: 'bezier-curve(0.45, 0.05, 0.55, 0.95)'
		
		loadingCircleSpins.start()
		
		loadingCircleSpins.on 'end', ->
			if (s < 4)
				loadingCircle.rotation = 45
				loadingCircleSpins.start()
				s++
	

		
loadMessages = ->
	
	loadingCircle.animate
		properties:
			opacity: 0
		time: .2
		
	chatScreen.opacity = 1
	
	m = 0		
	for message in messageArray
		message.opacity = 0
	
	for message in messageArray	
		do (message) ->
			message.animate
				properties:
					opacity: 1
				time: .4
				delay: .02 * m
			m++
			
	# 	Compose enters
	compose.animate
		properties:
			opacity: 1
			y: composeEndY
		time: .4
		delay: .2
	









# Story Controller
Utils.delay 1.8, ->
	mutePP()
	
	touch(260, 432, .2, .4)
	touchCircle.animate
		properties:
			x: touchCircle.x + swipeDisplace
			
		time: .3
		curve: 'ease-out'


	Utils.delay 2, ->
		openAddTopic()
		touch(360, 784)
		
	
# 		Typing
		Utils.delay 1, ->
			
			Utils.delay .1, ->
				typeNLetter()
				touch(512, 1162)
				
				Utils.delay .3, ->
					typeOLetter()
					touch(630, 944)
				
					Utils.delay .2, ->
						typeTLetter()
						touch(332, 964)
				
						Utils.delay .1, ->
							suggestionsEnter.start()
			
			
			Utils.delay 1.3, ->
				selectSuggestedTopic()	
				touch(426, 308)


				Utils.delay 1.9, ->
					newMessage()
								
					Utils.delay 1.1, ->
						openNotOneMore()
						touch(366, 706)
						
						Utils.delay 2.4, ->
							loadMessages()
						
							Utils.delay 1.3, ->
								touch(555,888)
								touchCircle.animate
									properties:
										y: touchCircle.y + swipeDisplace
									time: .7
								
								
								scroll.scrollToPoint(
									y: 222, x: 0
									true
									curve: 'ease', time: .8
								)