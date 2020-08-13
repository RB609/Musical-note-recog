import os
def note(i):
    octave = i // 12
    note = i % 12
    toreturn = ""
    if(note == 0):
        toreturn += 'A'
    elif(note == 1):
        toreturn += 'A#'
    elif(note == 2):
        toreturn += 'B'
    elif(note == 3):
        toreturn += 'C'
    elif(note == 4):
        toreturn += 'C#'
    elif(note == 5):
        toreturn += 'D'
    elif(note == 6):
        toreturn += 'D#'
    elif(note == 7):
        toreturn += 'E'
    elif(note == 8):
        toreturn += 'F'
    elif(note == 9):
        toreturn += 'F#'
    elif(note == 10):
        toreturn += 'G'
    elif(note == 11):
        toreturn += 'G#'
    
    toreturn += str(octave)
    toreturn += '.wav'
    return toreturn
    
for i in range(88):
    name = '%d.wav'%(i+1)
    os.rename(name, note(i))
