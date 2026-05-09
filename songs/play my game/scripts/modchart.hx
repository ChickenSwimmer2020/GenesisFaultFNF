// === SQUASH N STRETCH NOTES TO BPM ===
// Notes will squash vertically on every beat and stretch back smoothly.
// Works with any BPM and BPM changes.

import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

var noteScaleTween:Map<Note, FlxTween> = new Map();

function onNoteCreation(e:NoteCreationEvent) {
    var note:Note = e.note;
    
    // Store original scale so we can reset properly
    note.originalScaleX = note.scale.x;
    note.originalScaleY = note.scale.y;
    
    // Initial tiny squash on spawn (optional visual pop)
    note.scale.set(note.originalScaleX * 0.85, note.originalScaleY * 1.3);
    
    // Hook into every beat
    note.beatHit = function(beat:Int) {
        squashAndStretch(note);
    };
    
    // Also trigger on spawn for the first hit
    squashAndStretch(note);
}

function squashAndStretch(note:Note) {
    if (note == null || note.wasGoodHit || note.tooLate) return;
    
    // Kill any existing tween on this note
    if (noteScaleTween.exists(note)) {
        noteScaleTween.get(note).cancel();
    }
    
    // Quick squash (vertical stretch + slight horizontal squash for cartoon feel)
    note.scale.set(
        note.originalScaleX * 0.92,   // slight horizontal squash
        note.originalScaleY * 1.45    // big vertical stretch
    );
    
    // Smoothly stretch back to normal (feels bouncy)
    var tween = FlxTween.tween(note.scale, {
        x: note.originalScaleX,
        y: note.originalScaleY
    }, Conductor.crochet / 1000 * 0.8, {  // ~80% of a beat duration
        ease: FlxEase.quadOut,
        onComplete: function(t) {
            noteScaleTween.remove(note);
        }
    });
    
    noteScaleTween.set(note, tween);
}

// Clean up when notes are destroyed
function onNoteDestroy(e) {
    var note = e.note;
    if (noteScaleTween.exists(note)) {
        noteScaleTween.get(note).cancel();
        noteScaleTween.remove(note);
    }
}

// Optional: Make it stronger/weaker or adjust timing
// You can tweak the numbers above:
// * 1.45 → higher = more dramatic stretch
// * 0.92 → lower = more horizontal squash
// * crochet * 0.8 → change to 0.6 for faster recovery