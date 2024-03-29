##########################################################################
####### Production Feedback Tool                           ###############
#######                                                    ###############
####### This tool gives non-native speakers visual         ###############
####### feedback on their pronunciation of the English     ###############
####### /ɛ/–/æ/ vowel contrast.                            ###############
#######                                                    ###############
#######                                                    ###############
####### Gisela Govaart, Makiko Sadakata, Paul Boersma      ###############
####### Calibration part with help of Dirkjan Vet          ###############
#######                                                    ###############
####### v 1.0.0                                            ###############
####### July 2019                                          ###############
##########################################################################


##########################################################################
######### Adjustable settings ############################################
##########################################################################

# How often do you want to repeat each word in the training (both feedback and control)? (min 2x)
numRep = 55
# After how many words do you want to give the participant a break?
pauseAfter = 110
# What is the intensity treshold to distinguish silent trials (in dB)?
intensityMeanThreshold = 20

##########################################################################
######### Read in tables #################################################
##########################################################################

tableFemaleF_a = Read from file: "tableForTool_f_f_a.Table"
tableFemaleH_a = Read from file: "tableForTool_f_h_a.Table"
tableFemaleJ_a = Read from file: "tableForTool_f_j_a.Table"
tableFemaleM_a = Read from file: "tableForTool_f_m_a.Table"
tableFemaleP_a = Read from file: "tableForTool_f_p_a.Table"
tableFemaleF_e = Read from file: "tableForTool_f_f_e.Table"
tableFemaleH_e = Read from file: "tableForTool_f_h_e.Table"
tableFemaleJ_e = Read from file: "tableForTool_f_j_e.Table"
tableFemaleM_e = Read from file: "tableForTool_f_m_e.Table"
tableFemaleP_e = Read from file: "tableForTool_f_p_e.Table"

meanstableFemaleF_a = Read from file: "tableForToolMeans_f_f_a.Table"
meanstableFemaleH_a = Read from file: "tableForToolMeans_f_h_a.Table"
meanstableFemaleJ_a = Read from file: "tableForToolMeans_f_j_a.Table"
meanstableFemaleM_a = Read from file: "tableForToolMeans_f_m_a.Table"
meanstableFemaleP_a = Read from file: "tableForToolMeans_f_p_a.Table"
meanstableFemaleF_e = Read from file: "tableForToolMeans_f_f_e.Table"
meanstableFemaleH_e = Read from file: "tableForToolMeans_f_h_e.Table"
meanstableFemaleJ_e = Read from file: "tableForToolMeans_f_j_e.Table"
meanstableFemaleM_e = Read from file: "tableForToolMeans_f_m_e.Table"
meanstableFemaleP_e = Read from file: "tableForToolMeans_f_p_e.Table"

transTableFemaleG_a = Read from file: "transTableForTool_f_g_a.Table"
transTableFemaleK_a = Read from file: "transTableForTool_f_k_a.Table"
transTableFemaleM_a = Read from file: "transTableForTool_f_m_a.Table"
transTableFemaleT_a = Read from file: "transTableForTool_f_t_a.Table"
transTableFemaleG_e = Read from file: "transTableForTool_f_g_e.Table"
transTableFemaleK_e = Read from file: "transTableForTool_f_k_e.Table"
transTableFemaleM_e = Read from file: "transTableForTool_f_m_e.Table"
transTableFemaleT_e = Read from file: "transTableForTool_f_t_e.Table"


##########################################################################
######### Form participant information ###################################
##########################################################################

form Fill in the following information
	word ParticipantID 
	positive SessionNr

	choice Task: 1
		button Training 1
		button Training 2
		button Reading Task
		button Transfer Reading Task
endform

date$ = date$()
date$ = replace$(date$, ":", "-", 0)
fileID$ = "'participantID$'_task'task'_'sessionNr'_'date$'"
createDirectory: "Results/'fileID$'"
outdir$ = "Results/'fileID$'"
createDirectory: "'outdir$'/calibration"

demoWindowTitle: "Production feedback tool"


##########################################################################
######### Calibration ####################################################
##########################################################################

orig = Read TableOfReal from headerless spreadsheet file: "Orig.txt"

######### Record 3 corner vowels #########################################
label Calib_Info_Screen
demo Erase all
demo Silver
demo 18
@ clearDemoWindow
demo Text: 50, "centre", 50, "half", "Welcome! 'newline$' To get started, we would like you to pronounce 3 vowels: 'newline$' 'newline$' the 'oe' (as in the Dutch word 'boek'), 'newline$' the 'aa' (as in the Dutch word 'schaap'), 'newline$' and the 'ie' (as in the Dutch word 'piep'). 'newline$' 'newline$' Please make sure to keep a constant distance to the microphone. 'newline$' It is ok if you feel like you're exaggerating the vowels a bit. 'newline$' 'newline$' 'newline$' Press space to continue"
while demoWaitForInput()
	goto Uinfo_SCREEN demoInput(" ")
endwhile

### Record /u/
label Uinfo_SCREEN
@clearDemoWindow
demo 18
demo Text: 50, "centre", 50, "half", "Press space to record 'oe' (Dutch 'boek')"
while demoWaitForInput()
	goto U_SCREEN demoInput(" ")
endwhile
label U_SCREEN
@clearDemoWindow
demo Text: 50, "centre", 50, "half", "Say 'oe'"
demoShow()
sound_u = Record Sound (fixed time)... Microphone 0.99 0.5 44100 2
Save as WAV file: "'outdir$'/calibration/'fileID$'_u.wav"
@clearDemoWindow

### Record /a/
demo 18
demo Text: 50, "centre", 50, "half", "Press space to record 'aa' (Dutch 'schaap')"
while demoWaitForInput()
	goto A_SCREEN demoInput(" ")
endwhile
label A_SCREEN
@clearDemoWindow
demo Text: 50, "centre", 50, "half", "Say 'aa'"
demoShow()
sound_a = Record Sound (fixed time)... Microphone 0.99 0.5 44100 2
Save as WAV file: "'outdir$'/calibration/'fileID$'_a.wav"
@clearDemoWindow

### Record /i/
demo 18
demo Text: 50, "centre", 50, "half", "Press space to record 'ie' (Dutch 'piep')"
while demoWaitForInput()
	goto I_SCREEN demoInput(" ")
endwhile
label I_SCREEN
@clearDemoWindow
demo Text: 50, "centre", 50, "half", "Say 'ie'"
demoShow()
sound_i = Record Sound (fixed time)... Microphone 0.99 0.5 44100 2
Save as WAV file: "'outdir$'/calibration/'fileID$'_i.wav"
@clearDemoWindow

######### Analyze and vizualize the vowels ###############################

tableCalib = Create Table with column names: "tableCalib", 3, "Vowel F1 F2"

### For /u/
selectObject: sound_u
To Intensity: 100, 0, "yes"
time_maxInt = Get time of maximum: 0, 0, "Parabolic"
startVowel = time_maxInt - 0.0075
endVowel = time_maxInt + 0.0075
selectObject: sound_u
formant = noprogress To Formant (burg): 0.001, 5, 5500, 0.025, 50
## female voice specific formant ceiling (5500 Hz)
f1_u = noprogress Get mean: 1, startVowel, endVowel, "Hertz"
f2_u = noprogress Get mean: 2, startVowel, endVowel, "Hertz"

selectObject: tableCalib
Set string value: 1, "Vowel", "u"
Set numeric value: 1, "F1", f1_u
Set numeric value: 1, "F2", f2_u

### For /a/
selectObject: sound_a
To Intensity: 100, 0, "yes"
time_maxInt = Get time of maximum: 0, 0, "Parabolic"
startVowel = time_maxInt - 0.0075
endVowel = time_maxInt + 0.0075
selectObject: sound_a
formant = noprogress To Formant (burg): 0.001, 5, 5500, 0.025, 50
f1_a = noprogress Get mean: 1, startVowel, endVowel, "Hertz"
f2_a = noprogress Get mean: 2, startVowel, endVowel, "Hertz"

selectObject: tableCalib
Set string value: 2, "Vowel", "a"
Set numeric value: 2, "F1", f1_a
Set numeric value: 2, "F2", f2_a

### For /i/
selectObject: sound_i
To Intensity: 100, 0, "yes"
time_maxInt = Get time of maximum: 0, 0, "Parabolic"
startVowel = time_maxInt - 0.0075
endVowel = time_maxInt + 0.0075
selectObject: sound_i
formant = noprogress To Formant (burg): 0.001, 5, 5500, 0.025, 50
f1_i = noprogress Get mean: 1, startVowel, endVowel, "Hertz"
f2_i = noprogress Get mean: 2, startVowel, endVowel, "Hertz"

selectObject: tableCalib
Set string value: 3, "Vowel", "i"
Set numeric value: 3, "F1", f1_i
Set numeric value: 3, "F2", f2_i

for i to 3
	f1 = Get value: i, "F1"
	f2 = Get value: i, "F2"
	f1 = -f1
	f2 = -f2
	Set numeric value: i, "F1", f1
	Set numeric value: i, "F2", f2
endfor

Save as tab-separated file: "'outdir$'/calibration/'fileID$'_tableCalib.txt"

######### Vowel triangle visualization ###################################

demo Erase all
demo 12
demo Select inner viewport: 10, 90, 10, 85
demo Axes: 3200, 400, 1300, 100
demo Marks top: 8  , "yes", "yes", "no"
demo Marks right: 9, "yes", "yes", "no"
demo Teal
demo Text special: f2_u, "centre", f1_u, "half", "Helvetica", 25, "0", "u"
demo Text special: f2_a, "centre", f1_a, "half", "Helvetica", 25, "0", "a"
demo Text special: f2_i, "centre", f1_i, "half", "Helvetica", 25, "0", "i"
demo Axes: 0, 100, 0, 100
demo Select inner viewport: 0, 100, 0, 100
demo 18
demo Maroon
demo Text special: 50, "centre", 97, "half", "Helvetica", 18, "0", "Please wait for the experimenter to check the recording. (space bar = ok, r = redo.)"
# If the triangle looks good, the experiment leader can push the space bar and the experiment starts. If you want to re-do the calibration, press “r”.

while demoWaitForInput()
	goto Calib_ok demoInput(" ")
	goto Calib_Info_Screen demoInput("r")
endwhile

label Calib_ok
demo Erase all
@ clearDemoWindow
demo Silver
demo Text: 50, "centre", 50, "half", "Calibration approved! 'newline$' 'newline$' Press space to continue"
demoWaitForInput()

######### Make calibration values (these are used in @getCalib) ##########
user= Read TableOfReal from headerless spreadsheet file: "'outdir$'/calibration/'fileID$'_tableCalib.txt"
Rename: "User"
@CreateCalibration

##########################################################################
######### Create word list ###############################################
##########################################################################

strings = Read Strings from raw text file: "stimfile.txt"
for i from 1 to numRep-1
	stringsPart'i' = Extract part: 1, 10
endfor
selectObject: strings
for  i from 1 to numRep-1
	plusObject: stringsPart'i'
endfor
s = Append
Create Permutation: "p", 10*numRep, "yes"

p = Permute randomly (blocks): 0, 0, 10, "yes", "yes"
# The words are presented in random order per block (block = 10 words).
# The last word of a block is never the same as the first word of the next block. You can change this by changing the last "yes" to "no".

selectObject: p, s
wordList = Permute strings
nrWords = Get number of strings

######### Make randomized list of motivational messages ##################
strings = Read Strings from raw text file: "mot_mess.txt"
# You can change the content of the mot_mess.txt file to add or change the motivational messages.
motmessList = Randomize

##########################################################################
######### Practice phase feedback training 1 #############################
##########################################################################

if sessionNr = 1 & task = 1

	@ clearDemoWindow
	demo Silver
	demo 18
	demo Text: 50, "centre", 50, "half", "The experimenter has provided you with the instructions for this training. 'newline$' You now get the chance to practice the task. 'newline$''newline$' Anything still unclear? 'newline$' Be welcome to ask any kinds of questions regarding the training! 'newline$''newline$' Press space to start the practice session"
	while demoWaitForInput()
		goto PRACTICE_SCREEN_1 demoInput(" ")
	endwhile
	label PRACTICE_SCREEN_1
	@clearDemoWindow
	demo Silver
	demo 18
	demo Text: 50, "centre", 50, "half", "Press space to start"

	table = Create Table with column names: "tableInfo_'fileID'", 20, "participantID task sessionNr date word wordNr intendedVowel mahalanobis startC F1_orig F2_orig F1_calib F2_calib F1_calib_erb F2_calib_erb durationVowel"

	for i from 1 to 20
		@feedbackprocess: "practiceTraining1", 1, 1, 0
		## feedbackprocess asks for 4 variables:
			# .training$. The name of the training (to save the table with the correct name
			# .visual. If set to one, there is a visualization of the vowels. If set to 0, the vowels are only recorded (reading tasks).
			# .feedback. If set to 1, the participant gets feedback on her pronunciation, if set 0, it's the control task
			# .pause. If set to 1, the pauses are included.
	endfor
	
	while demoWaitForInput()
	@clearDemoWindow
	demo Silver
	demo Text: 50, "centre", 50, "half", "This is the end of the practice. 'newline$' 'newline$' Press space to start the training."
	demoWaitForInput()

endif


##########################################################################
######### Training feedback phase (Training 1) ###########################
##########################################################################

if task = 1

	@ clearDemoWindow
	demo Silver
	demo 18
	demo Text: 50, "centre", 50, "half", "This is the start of your training session! 'newline$' 'newline$' The whole session consists of 5 blocks. After each of those, you should take your time for a break. 'newline$' If you feel like you need a little break before that, 'newline$' you're welcome to wait a bit longer before pressing the space bar to continue with the next word. 'newline$' 'newline$' Get your tongue ready and press space to start!"
	while demoWaitForInput()
		goto SPACE_SCREEN_1 demoInput(" ")
	endwhile
	label SPACE_SCREEN_1
	@clearDemoWindow
	demo Silver
	demo 18
	demo Text: 50, "centre", 50, "half", "Press space to start"

	table = Create Table with column names: "tableInfo_'fileID'", 10*numRep, "participantID task sessionNr date word wordNr intendedVowel mahalanobis startC F1_orig F2_orig F1_calib F2_calib F1_calib_erb F2_calib_erb durationVowel"
	pauseCounter = 0

	for i from 1 to nrWords
		@feedbackprocess: "Training1", 1, 1, 1
		## feedbackprocess asks for 4 variables:
			# .training$. The name of the training (to save the table with the correct name
			# .visual. If set to one, there is a visualization of the vowels. If set to 0, the vowels are only recorded (reading tasks).
			# .feedback. If set to 1, the participant gets feedback on her pronunciation, if set 0, it's the control task
			# .pause. If set to 1, the pauses are included.
	endfor
	
	while demoWaitForInput()
	@clearDemoWindow
	demo Silver
	demo Text: 50, "centre", 50, "half", "End of this training session. 'newline$' Thanks for participating!"
	while demoWaitForInput()

endif


##########################################################################
######### Practice phase control phase (training 2) ######################
##########################################################################

if sessionNr = 1 & task = 2

	@ clearDemoWindow
	demo Silver
	demo 18
	demo Text: 50, "centre", 50, "half", "The experimenter has provided you with the instructions for this training. 'newline$' You now get the chance to practice the task. 'newline$''newline$' Anything still unclear? 'newline$' Be welcome to ask any kinds of questions regarding the training! 'newline$''newline$' Press space to start the practice session"
	while demoWaitForInput()
		goto PRACTICE_SCREEN_2 demoInput(" ")
	endwhile
	label PRACTICE_SCREEN_2
	@clearDemoWindow
	demo Silver
	demo 18
	demo Text: 50, "centre", 50, "half", "Press space to start"

	table = Create Table with column names: "tableInfo_'fileID'", 20, "participantID task sessionNr date word wordNr intendedVowel mahalanobis startC F1_orig F2_orig F1_calib F2_calib F1_calib_erb F2_calib_erb durationVowel"

	for i from 1 to 20
		@feedbackprocess: "practiceTraining2", 1, 0, 0
		## feedbackprocess asks for 4 variables:
			# .training$. The name of the training (to save the table with the correct name
			# .visual. If set to one, there is a visualization of the vowels. If set to 0, the vowels are only recorded (reading tasks).
			# .feedback. If set to 1, the participant gets feedback on her pronunciation, if set 0, it's the control task
			# .pause. If set to 1, the pauses are included.
	endfor
	
	while demoWaitForInput()
	@clearDemoWindow
	demo Silver
	demo Text: 50, "centre", 50, "half", "This is the end of the practice. 'newline$' 'newline$' Press space to start the training."
	demoWaitForInput()

endif


##########################################################################
######### Training Control phase (Training 2) ############################
##########################################################################

if task = 2

	@ clearDemoWindow
	demo Silver
	demo 18
	demo Text: 50, "centre", 50, "half", "This is the start of your training session! 'newline$' 'newline$' The whole session consists of 5 blocks. After each of those, you should take your time for a break. 'newline$' If you feel like you need a little break before that, 'newline$' you're welcome to wait a bit longer before pressing the space bar to continue with the next word. 'newline$' 'newline$' Get your tongue ready and press space to start!"
	while demoWaitForInput()
		goto SPACE_SCREEN_2 demoInput(" ")
	endwhile
	label SPACE_SCREEN_2
	@clearDemoWindow
	demo Silver
	demo 18
	demo Text: 50, "centre", 50, "half", "Press space to start"
	
	table = Create Table with column names: "tableInfo_'fileID'", 10*numRep, "participantID task sessionNr date word wordNr intendedVowel mahalanobis startC F1_orig F2_orig F1_calib F2_calib F1_calib_erb F2_calib_erb durationVowel"
	pauseCounter = 0

	for i from 1 to nrWords
		@feedbackprocess: "Training2", 1, 0, 1
		## feedbackprocess asks for 4 variables:
			# .training$. The name of the training (to save the table with the correct name
			# .visual. If set to one, there is a visualization of the vowels. If set to 0, the vowels are only recorded (reading tasks).
			# .feedback. If set to 1, the participant gets feedback on her pronunciation, if set 0, it's the control task
			# .pause. If set to 1, the pauses are included.
	endfor
	
	while demoWaitForInput()
	@clearDemoWindow
	demo Silver
	demo Text: 50, "centre", 50, "half", "End of this training session. 'newline$' Thanks for participating!"
	while demoWaitForInput()

endif


##########################################################################
######### Reading task ###################################################
##########################################################################

if task = 3

	@ clearDemoWindow
	demo Silver
	demo 18
	demo Text: 50, "centre", 50, "half", "Welcome to the reading task! 'newline$' 'newline$' You are going to see single English words on the screen and your task is 'newline$' to read them out aloud. In every round, you pronounce the word 'newline$' you see on the screen and then press space to come to the next word. 'newline$' 'newline$' Whenever you feel like you need a break or need to cough, for instance, 'newline$' you can best do so in between recordings, which is whenever you see the word *next*. 'newline$' In total, you're going to see 30 words. 'newline$''newline$' Any questions? 'newline$' 'newline$' Press space to start!"
		while demoWaitForInput()
		goto SPACE_SCREEN_3 demoInput(" ")
	endwhile
	label SPACE_SCREEN_3
	@clearDemoWindow
	demo Silver
	demo 18
	demo Text: 50, "centre", 50, "half", "Press space to start"

	table = Create Table with column names: "tableInfo_'fileID'", 30, "participantID task sessionNr date word wordNr intendedVowel mahalanobis startC F1_orig F2_orig F1_calib F2_calib F1_calib_erb F2_calib_erb durationVowel"

	for i from 1 to 30
		@feedbackprocess: "Reading1", 0, 0, 0
		## feedbackprocess asks for 3 variables:
			# .training$. The name of the training (to save the table with the correct name
			# .visual. If set to one, there is a visualization of the vowels. If set to 0, the vowels are only recorded (reading tasks).
			# .feedback. If set to 1, the participant gets feedback on her pronunciation, if set 0, it's the control task
			# .pause. If set to 1, the pauses are included.
	endfor

	while demoWaitForInput()
	@clearDemoWindow
	demo Silver
	demo Text: 50, "centre", 50, "half", "End of the reading task. 'newline$' Thanks for participating!"
	while demoWaitForInput()

endif

##########################################################################
######### Transfer reading task ##########################################
##########################################################################

## This code is quite similar to the code you'd get for @feedbackprocess: "TransferReading" ,0,0,0 but it uses different word lists.

if task = 4

	######### Create word list ###############################################
	strings = Read Strings from raw text file: "stimfileTransfer.txt"
	for i from 1 to 2
		stringsPart'i' = Extract part: 1, 8
	endfor
	selectObject: strings
	for  i from 1 to 2
		plusObject: stringsPart'i'
	endfor
	s = Append
	Create Permutation: "p", 8*3, "yes"
	p = Permute randomly (blocks): 0, 0, 8, "yes", "yes"
	selectObject: p, s
	wordListTrans = Permute strings

	@ clearDemoWindow
	demo Silver
	demo 18
	demo Text: 50, "centre", 50, "half", "Welcome to the transfer reading task! 'newline$' 'newline$' Again you are going to see single English words on the screen and your task is 'newline$' to read them out aloud. In every round, you pronounce the word 'newline$' you see on the screen and then press space to come to the next word. 'newline$' 'newline$' Whenever you feel like you need a break or need to cough, for instance, 'newline$' you can best do so in between recordings, which is whenever you see the word *next*. 'newline$' In total, you're going to see 24 words. 'newline$' 'newline$' Any questions? 'newline$' 'newline$' Press space to start!"
	while demoWaitForInput()

	table = Create Table with column names: "tableInfo_'fileID'", 24, "participantID task sessionNr date word wordNr intendedVowel mahalanobis startC F1_orig F2_orig F1_calib F2_calib F1_calib_erb F2_calib_erb durationVowel"

	for i from 1 to 24
		@clearDemoWindow
		demo Silver
		demo 24
		demo Text special: 50, "centre", 50, "half", "Helvetica", 28, "0", "Next"

		######### Present target word on screen ##################################

		selectObject: wordListTrans
		word$ = Get string: 'i'
		s$ = left$ (word$, 1)
		if s$ = "c"
			s$ = "k"
		endif
		;e$ = right$ (word$, 1)
		## taken out because these are not CVC words, and this information is not relevant
		vowel$ = mid$ (word$, 2,1)
		if vowel$ = "u"
			vowel$ = "e"
		endif
		while demoWaitForInput()
			goto PRES_SCREEN_4 demoInput(" ")
		endwhile
		label PRES_SCREEN_4
		@clearDemoWindow
		sleep(0.2)
		demo Silver
		demo 24
		demo Text special: 50, "centre", 50, "half", "Helvetica", 38, "0", word$
		demoShow()

		######### Record the participant's utterance #############################

		sound = Record Sound (fixed time)... Microphone 0.99 0.5 44100 2
		j = ceiling((i-1)/10 + 0.05)
		Save as WAV file: "'outdir$'/'fileID$'_'word$''j'.wav"

		######### Segment the participant's utterance ############################

		## This part is to make sure that if the program does not detect any sound, it will give you the message to try again, instead of break down.
		selectObject: sound
		To Intensity: 100, 0, "yes"
		intensityMean = Get mean: 0, 0, "dB"
		if intensityMean < intensityMeanThreshold
			demo Red
			demo Text special: 50, "centre", 30, "half", "Helvetica", 30, "0", "You were too late or speaking too softly 'newline$' Please try again! "
			selectObject: table
				Set string value: i, "participantID", participantID$
				Set numeric value: i, "task", task
				Set numeric value: i, "sessionNr", sessionNr
				Set string value: i, "date", date$()
				Set string value: i, "word", word$
				Set numeric value: i, "wordNr", j
				Set string value: i, "intendedVowel", vowel$
				Set numeric value: i, "mahalanobis", 0
				Set string value: i, "startC", s$
				Set numeric value: i, "F1_orig", 0
				Set numeric value: i, "F2_orig", 0
				Set numeric value: i, "F1_calib", 0
				Set numeric value: i, "F2_calib", 0
				Set numeric value: i, "F1_calib_erb", 0
				Set numeric value: i, "F2_calib_erb", 0
			selectObject: sound
			Remove

			# Enables retake in case of silent trials (jumps back to screen showing the current word)
			while demoWaitForInput()
				goto PRES_SCREEN_4 demoInput(" ")
			endwhile

		else
		## if the intensity is high enough: go ahead with the normal process
			selectObject: sound
			textgrid = noprogress To TextGrid: "CVC", ""
			Set interval text: 1, 1, word$

			selectObject: sound
			speechSynt = noprogress Create SpeechSynthesizer: "English", "f1"
			# Here f1, you can also choose one of the other female 'voices'.
			selectObject: sound, textgrid, speechSynt
			Save as binary file: outdir$ + "/delete.Collection"
			textgridAligned = noprogress To TextGrid (align): 1, 1, 1, -40, 0.3, 0.1
			## -40 dB is the silence threshold.

			selectObject: textgridAligned
			noprogress Save as text file: "'outdir$'/'fileID$'_'word$''j'.TextGrid"
	
			######### Analyze the participant's utterance ############################

			selectObject: textgridAligned
			nrIntervals = noprogress Get number of intervals: 4
			for k from 1 to nrIntervals
				selectObject: textgridAligned
				intervalLabel$ = Get label of interval: 4, k
						if intervalLabel$ = "æ" or intervalLabel$ = "a" or intervalLabel$ = "ɛ" or intervalLabel$ = "e"
					startVowel = noprogress Get starting point: 4, k
					endVowel = noprogress Get end point: 4, k
					durationVowel = (endVowel - startVowel)
				endif	
			endfor

			selectObject: sound
			formant = noprogress To Formant (burg): 0.001, 5, 5500, 0.025, 50

			f1_orig = noprogress Get mean: 1, startVowel, endVowel, "Hertz"
			f2_orig = noprogress Get mean: 2, startVowel, endVowel, "Hertz"

			## F1 and F2 values are calibrated. The output of this procedure are two variables: f1 and f2, with the calibrated values in it.
			f1_forCalib = -f1_orig
			f2_forCalib = -f2_orig
			@GetCalib(f1_forCalib, f2_forCalib)
			## The values from the GetCalib have a minus sign, this still needs to be deleted:			f1 = -f1
			f2 = -f2
			# For the visualization, we use ERBs.
			f1_erb = hertzToErb(f1)
			f2_erb = hertzToErb(f2)


			### Compute the Mahalanobis distance
			if vowel$ = "a"
				if s$ = "g"
					@mahalanobis: transTableFemaleG_a
				elsif s$ = "k"
					@mahalanobis: transTableFemaleK_a
				elsif s$ = "m"
					@mahalanobis: transTableFemaleM_a
				elsif s$ = "t"
					@mahalanobis: transTableFemaleT_a
				endif
			elsif vowel$ = "e"
				if s$ = "g"
					@mahalanobis: transTableFemaleG_e
				elsif s$ = "k"
					@mahalanobis: transTableFemaleK_e
				elsif s$ = "m"
					@mahalanobis: transTableFemaleM_e
				elsif s$ = "t"
					@mahalanobis: transTableFemaleT_e
				endif
			endif

			######### Save the info in a table ##################################
			selectObject: table
				Set string value: i, "participantID", participantID$
				Set numeric value: i, "task", task
				Set numeric value: i, "sessionNr", sessionNr
				Set string value: i, "date", date$
				Set string value: i, "word", word$
				Set numeric value: i, "wordNr", j
				Set string value: i, "intendedVowel", vowel$
				Set numeric value: i, "mahalanobis", mahalanobis.mahaladist
				Set string value: i, "startC", s$
				Set numeric value: i, "F1_orig", f1_orig
				Set numeric value: i, "F2_orig", f2_orig
				Set numeric value: i, "F1_calib", f1
				Set numeric value: i, "F2_calib", f2
				Set numeric value: i, "F1_calib_erb", f1_erb
				Set numeric value: i, "F2_calib_erb", f2_erb
				Set numeric value: i, "durationVowel", durationVowel
			selectObject: sound, textgrid, textgridAligned, speechSynt, formant
			Remove

		## endif of the loop to avoid silence error
		endif

		# save output so far (every trial)
		selectObject: table
		Save as tab-separated file: "'outdir$'/'fileID$'_transferReadingTask.txt"

		demoShow()

	endfor

	while demoWaitForInput()
	@ clearDemoWindow
	demo Silver
	demo Text: 50, "centre", 50, "half", "This is the end of the reading task. 'newline$' Thanks for participating!"
	while demoWaitForInput()

endif


##########################################################################
######### Procedures #####################################################
##########################################################################

procedure clearDemoWindow
	demo Erase all
	demo Axes: 0, 100, 0, 100
	demo Select inner viewport: 0, 100, 0, 100
	demo Paint rectangle: "black", 0, 100, 0, 100
endproc

## -----------------------------------------------------------------------

procedure mahalanobis: .tableForTool
	selectObject: .tableForTool
	Down to TableOfReal: ""
	cov_i = To Covariance
	table_i = Create Table with column names: "table_i", 1, "F1 F2"
	Set numeric value: 1, "F1", f1
	Set numeric value: 1, "F2", f2
	selectObject: table_i
	tor_i = Down to TableOfReal: ""
	selectObject: cov_i, tor_i
	table_mal = To TableOfReal (mahalanobis): "no"
	.mahaladist = Get value: 1,1
	selectObject: cov_i, table_i, tor_i, table_mal
	Remove
endproc

## -----------------------------------------------------------------------

procedure drawAxes: .tableA, .tableE, .vowel$, .word$
	selectObject: .tableA
	meanF1a = Get value: 1, "F1"
	meanF2a = Get value: 1, "F2"
	meanF1a_erb = hertzToErb(meanF1a)
	meanF2a_erb = hertzToErb(meanF2a)

	selectObject: .tableE
	meanF1e = Get value: 1, "F1"
	meanF2e = Get value: 1, "F2"
	meanF1e_erb = hertzToErb(meanF1e)
	meanF2e_erb = hertzToErb(meanF2e)

	if .vowel$ = "a"
			if .word$ = "fan"
				.wrongword$ = "fen"
			elsif .word$ = "ham"
				.wrongword$ = "hem"
			elsif .word$ = "jam"
				.wrongword$ = "gem"
			elsif .word$ = "man"
				.wrongword$ = "men"
			elsif .word$ = "pan"
				.wrongword$ = "pen"
			endif

			demo Select inner viewport: 0, 100, 0, 100
			demo Paint rectangle: "black", 0, 100, 0, 100
			demo Axes: 22.5, 16, 20, 9.5
			demo Green
			demo Text special: meanF2a_erb, "centre", meanF1a_erb, "half", "Helvetica", 25, "0", "+"
			demo Text special: meanF2a_erb, "centre", meanF1a_erb, "top", "Helvetica", 25, "0", .word$
			demo Silver
			demo Text special: meanF2e_erb, "centre", meanF1e_erb, "half", "Helvetica", 25, "0", "+"
			demo Text special: meanF2e_erb, "centre", meanF1e_erb, "top", "Helvetica", 25, "0", .wrongword$

	else
			if .word$ = "fen"
				.wrongword$ = "fan"
			elsif .word$ = "hem"
				.wrongword$ = "ham"
			elsif .word$ = "gem"
				.wrongword$ = "jam"
			elsif .word$ = "men"
				.wrongword$ = "man"
			elsif .word$ = "pen"
				.wrongword$ = "pan"
			endif

			demo Select inner viewport: 0, 100, 0, 100
			demo Paint rectangle: "black", 0, 100, 0, 100
			demo Axes: 22.5, 16, 20, 9.5
			demo Green
			demo Text special: meanF2e_erb, "centre", meanF1e_erb, "half", "Helvetica", 25, "0", "+"
			demo Text special: meanF2e_erb, "centre", meanF1e_erb, "top", "Helvetica", 25, "0", .word$
			demo Silver
			demo Text special: meanF2a_erb, "centre", meanF1a_erb, "half", "Helvetica", 25, "0", "+"
			demo Text special: meanF2a_erb, "centre", meanF1a_erb, "top", "Helvetica", 25, "0", .wrongword$ 
	endif
endproc

## -----------------------------------------------------------------------

procedure GetCalib(.f1, .f2)
   f1= .f1 - (f1_f1*.f1 + f1_f2*.f2 + f1_off)
   f2= .f2 - (f2_f1*.f1 + f2_f2*.f2 + f2_off)
endproc

## -----------------------------------------------------------------------

procedure CreateCalibration

  select user
  Insert column (index): 3
  Set value: 1, 3, 1
  Set value: 2, 3, 1
  Set value: 3, 3, 1
  .t1= Copy: "t1"
  .t2= Copy: "t2"

  select orig
  .diff= Copy: "diff"
  Formula: "TableOfReal_User[] - self"
  .df1= Extract column ranges: "1"
  select .diff
  .df2= Extract column ranges: "2"

  select .t1
  plus .df1
  .ta1= Append columns
  .m1= To Matrix
  .s1= Solve equation: 1.19e-007
  Rename: "M1"

  f1_f1= Get value in cell: 1, 1
  f1_f2= Get value in cell: 1, 2
  f1_off= Get value in cell: 1, 3

  select .t2
  plus .df2
  .ta2= Append columns
  .m2= To Matrix
  .s2= Solve equation: 1.19e-007
  Rename: "M2"

  f2_f1= Get value in cell: 1, 1
  f2_f2= Get value in cell: 1, 2
  f2_off= Get value in cell: 1, 3

  select .t1
  plus .t2
  plus .diff
  plus .ta1
  plus .ta2
  plus .m1
  plus .m2
  plus .s1
  plus .s2
  plus .df1
  plus .df2
  Remove

endproc

## -----------------------------------------------------------------------

procedure feedbackprocess: .training$ .visual .feedback .pause

	######### Prompt participant to the next screen in case of reading task
	if .visual = 0
		@clearDemoWindow
		demo Silver
		demo 24
		demo Text special: 50, "centre", 50, "half", "Helvetica", 28, "0", "Next"
	endif

	######### Present target word on screen ##################################

	selectObject: wordList
	word$ = Get string: 'i'
	s$ = left$ (word$, 1)
	if s$ = "g"
		s$ = "j"
	endif
	e$ = right$ (word$, 1)
	vowel$ = mid$ (word$, 2,1)
	while demoWaitForInput()
		goto WORD_SCREEN_1 demoInput(" ")
	endwhile
	label WORD_SCREEN_1
	@clearDemoWindow
	sleep(0.2)
	demo Silver
	demo 24
	demo Text special: 50, "centre", 50, "half", "Helvetica", 38, "0", word$
	demoShow()

	######### Record the participant's utterance #############################

	sound = Record Sound (fixed time)... Microphone 0.99 0.5 44100 2
	j = ceiling((i-1)/10 + 0.05)
	Save as WAV file: "'outdir$'/'fileID$'_'word$''j'.wav"

	######### Segment the participant's utterance ############################

	## This part is to make sure that if the program does not detect any sound, it will give you the message to try again, instead of break down.
	selectObject: sound
	To Intensity: 100, 0, "yes"
	intensityMean = Get mean: 0, 0, "dB"
	if intensityMean < intensityMeanThreshold
		demo Red
		demo Text special: 50, "centre", 30, "half", "Helvetica", 30, "0", "You were too late 'newline$' or speaking too softly"
		selectObject: table
		Set string value: i, "participantID", participantID$
		Set numeric value: i, "task", task
		Set numeric value: i, "sessionNr", sessionNr
		Set string value: i, "date", date$()
		Set string value: i, "word", word$
		Set numeric value: i, "wordNr", j
		Set string value: i, "intendedVowel", vowel$
		Set numeric value: i, "mahalanobis", 0
		Set string value: i, "startC", s$
		Set numeric value: i, "F1_orig", 0
		Set numeric value: i, "F2_orig", 0
		Set numeric value: i, "F1_calib", 0
		Set numeric value: i, "F2_calib", 0
		Set numeric value: i, "F1_calib_erb", 0
		Set numeric value: i, "F2_calib_erb", 0
		Set numeric value: i, "durationVowel", 0
		selectObject: sound
		Remove
	
		## For the reading task, we prompt the participant to retake the words if their utterance was too soft, because of the low number of stimuli.
		if .visual = 0
			# enables retake in case of silent trials (jumps back to screen showing the current word)
			while demoWaitForInput()
				goto WORD_SCREEN_1 demoInput(" ")
			endwhile
		endif

	else
	## If the intensity is high enough: go ahead with the normal process.

		selectObject: sound
		textgrid = noprogress To TextGrid: "CVC", ""
		Set interval text: 1, 1, word$

		selectObject: sound
		speechSynt = noprogress Create SpeechSynthesizer: "English", "f1"
		# Here f1, you can also choose one of the other female 'voices'.
		selectObject: sound, textgrid, speechSynt
		Save as binary file: outdir$ + "/delete.Collection"
		textgridAligned = noprogress To TextGrid (align): 1, 1, 1, -40, 0.3, 0.1
		## The Silence Threshold (-40) is lower than the default, and the time for minimal silent interval duration is longer than the default.
		## This is done such that the speech synthesizer does not think too fast that the sound is a silence (because then the tool does not give feedback)

		selectObject: textgridAligned
		noprogress Save as text file: "'outdir$'/'fileID$'_'word$''j'.TextGrid"

		######### Analyze the participant's utterance ############################

		selectObject: textgridAligned
		nrIntervals = noprogress Get number of intervals: 4
		for k from 1 to nrIntervals
			selectObject: textgridAligned
			intervalLabel$ = Get label of interval: 4, k
			if intervalLabel$ = "æ" or intervalLabel$ = "a" or intervalLabel$ = "ɛ" or intervalLabel$ = "e"
				startVowel = noprogress Get starting point: 4, k
				endVowel = noprogress Get end point: 4, k
				durationVowel = (endVowel - startVowel)
			endif	
		endfor
	
		selectObject: sound
		formant = noprogress To Formant (burg): 0.001, 5, 5500, 0.025, 50

		f1_orig = noprogress Get mean: 1, startVowel, endVowel, "Hertz"
		f2_orig = noprogress Get mean: 2, startVowel, endVowel, "Hertz"

		## F1 and F2 values are calibrated. The output of this procedure are two variables: f1 and f2, with the calibrated values in it.
		f1_forCalib = -f1_orig
		f2_forCalib = -f2_orig
		@GetCalib(f1_forCalib, f2_forCalib)
		## The values from the GetCalib have a minus sign, this still needs to be deleted:
		f1 = -f1
		f2 = -f2
		## For the visualization, we use ERBs.
		f1_erb = hertzToErb(f1)
		f2_erb = hertzToErb(f2)

		### Compute the Mahalanobis distance
		
		if vowel$ = "a"
			if s$ = "f"
				@mahalanobis: tableFemaleF_a
			elsif s$ = "h"
				@mahalanobis: tableFemaleH_a
			elsif s$ = "j"
				@mahalanobis: tableFemaleJ_a
			elsif s$ = "m"
				@mahalanobis: tableFemaleM_a
			elsif s$ = "p"
				@mahalanobis: tableFemaleP_a
			endif
		elsif vowel$ = "e"
			if s$ = "f"
				@mahalanobis: tableFemaleF_e
			elsif s$ = "h"
				@mahalanobis: tableFemaleH_e
			elsif s$ = "j"
				@mahalanobis: tableFemaleJ_e
			elsif s$ = "m"
				@mahalanobis: tableFemaleM_e
			elsif s$ = "p"
				@mahalanobis: tableFemaleP_e
			endif
		endif
		
		######### Give the participant feedback ##################################
		## Only for the training tasks, not for the reading tasks

		if .visual = 1
			
			if s$ = "f"
				@drawAxes: meanstableFemaleF_a, meanstableFemaleF_e, vowel$, word$
			elsif s$ = "h"
				@drawAxes: meanstableFemaleH_a, meanstableFemaleH_e, vowel$, word$
			elsif s$ = "j"
				@drawAxes: meanstableFemaleJ_a, meanstableFemaleJ_e, vowel$, word$
			elsif s$ = "m"
				@drawAxes: meanstableFemaleM_a, meanstableFemaleM_e, vowel$, word$
			elsif s$ = "p"
				@drawAxes: meanstableFemaleP_a, meanstableFemaleP_e, vowel$, word$
			endif

			### Plot the feedback (but only if .feedback = 1)

			if .feedback = 1
				## First check whether the values can be used: do they fit on the screen?
				if f2_erb < 22.5 & f2_erb > 16 & f1_erb > 9.5 & f1_erb < 20
					demo Paint circle (mm): "blue", f2_erb, f1_erb, 2.5
				else
					demo Red
					demo Text special: 19.25, "centre", 11, "half", "Helvetica", 18, "0", "Too far from the target vowels"
				endif
			endif
	
		endif

		######### Save the info in a table ##################################

		selectObject: table
			Set string value: i, "participantID", participantID$
			Set numeric value: i, "task", task
			Set numeric value: i, "sessionNr", sessionNr
			Set string value: i, "date", date$()
			Set string value: i, "word", word$
			Set numeric value: i, "wordNr", j
			Set string value: i, "intendedVowel", vowel$
			Set numeric value: i, "mahalanobis", mahalanobis.mahaladist
			Set string value: i, "startC", s$
			Set numeric value: i, "F1_orig", f1_orig
			Set numeric value: i, "F2_orig", f2_orig
			Set numeric value: i, "F1_calib", f1
			Set numeric value: i, "F2_calib", f2
			Set numeric value: i, "F1_calib_erb", f1_erb
			Set numeric value: i, "F2_calib_erb", f2_erb
			Set numeric value: i, "durationVowel", durationVowel

		selectObject: sound, textgrid, textgridAligned, speechSynt, formant
		Remove

	## endif of the loop to avoid silence error
	endif

	## save output so far (every trial)
	selectObject: table
	Save as tab-separated file: "'outdir$'/'fileID$'_'.training$'.txt"
	
	### The pause (only if .pause = 1)
	if .pause = 1
		if i mod pauseAfter = 0 
			pauseCounter = pauseCounter + 1
			selectObject: motmessList
			motmess$ = Get string: 'pauseCounter'
			while demoWaitForInput()
				goto PAUSE_SCREEN_1 demoInput(" ")
			endwhile
			label PAUSE_SCREEN_1
			@clearDemoWindow
			demo Silver
			demo 24
			demo Text: 50, "centre", 50, "half", "'motmess$' 'newline$'  'newline$' Take your time for a little break! 'newline$'  'newline$' Press space when you're ready to continue"
		endif
	endif

	demoShow()

endproc
