# Vowel Production Feedback Tool

This is a tool to give online feedback on vowel production, using the computer program [Praat](http://www.fon.hum.uva.nl/praat/) (Boersma & Weenink, 2016). 
It can be used to analyze and give visual feedback on productions of the English /ɛ/–/æ/ contrast, to train the pronunciation of this contrast for non-native English speakers.

The current version is only available for female speakers. If you would like to use the tool for male speakers, you can open an issue to request this.

## Background
This tool can be used to train speakers’ production of a non-native vowel contrast. Tools to do this kind of training have been developed (for a review see Kartushina et al., 2015, JASA, 138(2), 817-832) – but are not freely available yet. Moreover, most training studies do not explicitly test whether the dimensions the tool uses for feedback are optimally informative/relevant for learning the contrast. The studies mentioned in Kartushina et al. (2015) differ greatly in terms of behavioral improvements as well as in terms of the methods of the studies: Feedback systems are different, and different acoustic measures are used, i.e. there is inconsistency in the features that are used to base the feedback on. This means that some studies might give feedback based on features that are not so relevant in speech perception, or they leave out important features. 

For this tool, we carried out an extensive linear discriminant analysis (LDA) to analyze a dataset of productions of the our vowels of interest (the English /ɛ/ in ‘pen’  and /æ/ in ‘pan’), produced by 10 native speakers of English. We did this to identify the most important features of the English vowels /ɛ/ and /æ/, because these features will be most useful to receive feedback on for non-native speakers. We found that the mean F1 and F2 over the whole duration of the vowel are the best indicators, and that coarticulation should be taken into account. Our tool thus uses these features to provide the participant feedback on her vowel production. More information on how the tool was developed can be found [here](thesis-GiselaGovaart.pdf).

## The tool
The tool has four different tasks:
- Training 1: Feedback training (the participant produces the words and gets visual feedback on her pronunciation) 
- Training 2: Control training (same as training 1, but without visual feedback on own production)
- Reading task: The participants produces the words she was trained on, without feedback.
- Transfer Reading: A transfer reading task with 8 new words.

For Training 1 and 2, if session number = 1, the training starts with a practice phase with 20 words. The reading tasks do not have a practice phase.

## Using the tool
Information for experiment leader:
- After the initial calibration phase, you should check whether the three vowels are on a triangle, and whether the values make sense. If the triangle does not look good, redo the calibration, because this influences all vowels in the experiment.

## Collaborators
- [Gisela Govaart](https://www.cbs.mpg.de/person/govaart/373360)
- [Makiko Sadakata](http://www.sadakata.com)
- [Paul Boersma](http://www.fon.hum.uva.nl/paul/)

This tool was created as part of a research internship at the Donders Institute, Nijmegen and the Amsterdam Center for Language and Communication: Phonetic Sciences, Amsterdam. 

We thank: Jana Thorin, Dirkjan Vet, James McQueen, David Weenink, Peter Desain
