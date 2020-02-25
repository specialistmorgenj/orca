![orca_norns|690x231,100%](https://llllllll.co/uploads/default/original/3X/e/e/ee7a2a1460ac4c0a54c8a0b067b7e7d9c35f23fd.png)

## [Orca](https://100r.co/pages/orca.html) is a visual programming language, designed to create procedural sequencers on the fly.

![307x154,100%](https://frederickk.github.io/orca/screenshot/m-orca-empty.png)


---

### Requirements	

[PolyPerc engine](https://llllllll.co/t/awake/)

Currently [mutlitple engines are not supported](https://llllllll.co/t/orca/22492/154). This version of Orca, replaces the [Timber engine](https://llllllll.co/t/timber/) with the [PolyPerc synth engine](https://llllllll.co/t/awake/) (from Awake).



### Documentation

Please refer to original [docs](https://github.com/hundredrabbits/Orca#operators)


---

## Operators

- `A` **add**(*a* b): Outputs sum of inputs.
- `B` **bounce**(*rate* mod): Outputs values between inputs.
- `C` **clock**(*rate* mod): Outputs modulo of frame.
- `D` **delay**(*rate* mod): Bangs on modulo of frame.
- `E` **east**: Moves eastward, or bangs.
- `F` **if**(*a* b): Bangs if inputs are equal.
- `G` **generator**(*x* *y* *len*): Writes operands with offset.
- `H` **halt**: Halts southward operand.
- `I` **increment**(*step* mod): Increments southward operand.
- `J` **jumper**(*val*): Outputs northward operand.
- `K` **konkat**(*len*): Reads multiple variables.
- `L` **loop**(*step* *len* val): Moves eastward operands.
- `M` **multiply**(*a* b): Outputs product of inputs.
- `N` **north**: Moves Northward, or bangs.
- `O` **read**(*x* *y* read): Reads operand with offset.
- `P` **push**(*len* *key* val): Writes eastward operand.
- `Q` **query**(*x* *y* *len*): Reads operands with offset.
- `R` **random**(*min* max): Outputs random value.
- `S` **south**: Moves southward, or bangs.
- `T` **track**(*key* *len* val): Reads eastward operand.
- `U` **uclid**(*step* max): Bangs on Euclidean rhythm.
- `V` **variable**(*write* read): Reads and writes variable.
- `W` **west**: Moves westward, or bangs.
- `X` **write**(*x* *y* val): Writes operand with offset.
- `Y` **jymper**(*val*): Outputs westward operand.
- `Z` **lerp**(*rate* target): Transitions operand to input.
- `*` **bang**: Bangs neighboring operands.
- `#` **comment**: Halts a line.

## IO / Norns operators

<!--
Only 1 Engine supported at a time, so Timber is deactivated in favor of PolyPerc
- `'` **timber engine**(*sample* octave note level position): Triggers sample player.
- `"` **timber param**(*sample* *param* value): Sets timber param on bang.
-->
- `/` **softcut**(*playhead* *rec* *play* level rate position)
- `\` **softcut param**(*playhead* *param* value): Sets softcut param on bang
- `>` **g.write**(*x* *y* value): Sets grid led on bang.
- `<` **g.read**(*x* *y*): Reads specific coordinates. If value > 6 outputs bang.
- `:` **midi**(*channel* octave note velocity length): Sends a MIDI note.
- `|` **synth**(*octave* *note* release cutoff amp pw gain): Plays a note with the synth engine.
- `%` **mono**(*channel* octave note velocity length): Sends monophonic MIDI note.
- `&` **midi in**(*channel*): Outputs midi note
- `^` **cc in**(*cc*): Outputs midi cc value
- `!` **cc**(*channel* knob value): Sends MIDI control change.
- `=` **OSC** (*path*;x;y..): Locks each consecutive eastwardly ports. `;` is delimeter for values
- `$` **r.note**(scale-mode note): Outputs random note within scale.
- `?` **levels**(*param* value): Sets selected volume level on bang



### SYNTH

The **SYNTH** operator `|` takes up to 7 inputs(*octave*, *note*, release, cutoff, amp, pw, gain).

For example `|4C` will create place a C at the 4th octave (Midi scale), with a default release of 1600ms (`h`). If you want a note with a shorter release enter something like `|4C9`. This will emit the same note as before but with a 822ms release. Cutoff is the frequency the note is filtered through, default is 800mhz (`h`).


### MIDI IN

The **MIDI IN** operator `&` takes 1 input(channel).

This operator receives a MIDI note from a MIDI controller, based on the channel value (default is channel 1).


### CC IN

The **CC IN** operator `^` takes 1 input(channel).

This operator receives a MIDI CC message from a MIDI controller, based on the channel value (default is channel 1).


### R.NOTE

The **R.NOTE** operator `$` takes 2 inputs(scale-mode, note).

This operator generates a scale based on the given mode (default is Dorian) and note/key (default is C). For example to generate an F natural minor scale enter `$2F`. There are 35 different modes to choose from:
- `1`: Major
- `2`: Natural Minor
- `3`: Harmonic Minor
- `4`: Melodic Minor
- `5`: Dorian
- `6`: Phrygian
- `7`: Lydian
- `8`: Mixolydian
- `9`: Locrian
- `a`: Gypsy Minor
- `b`: Whole Tone
- `c`: Major Pentatonic
- `d`: Minor Pentatonic
- `e`: Major Bebop
- `f`: Altered Scale
- `g`: Dorian Bebop
- `h`: Mixolydian Bebop
- `i`: Blues Scale
- `j`: Diminished Whole Half
- `k`: Diminished Half Whole
- `l`: Neapolitan Major
- `m`: Hungarian Major
- `n`: Harmonic Major
- `o`: Hungarian Minor
- `p`: Lydian Minor
- `q`: Neapolitan Minor
- `r`: Major Locrian
- `s`: Leading Whole Tone
- `t`: Six Tone Symmetrical
- `u`: Arabian
- `v`: Balinese
- `w`: Byzantine
- `x`: Hungarian Gypsy
- `y`: Persian
- `z`: East Indian Purvi


### LEVELS

The **LEVELS** operator `?` takes 2 inputs(*param*, value).

There are 9 different params that can be modulated on the fly with this operator:
- `1`: level output channels
- `2`: level engine master
- `3`: level softcut master
- `4`: level ADC input
- `5`: reverb engine level
- `6`: softcut reverb level
- `7`: reverb DAC level
- `8`: softcut ADC level
- `9`: softcut engine level

In order to trigger parameter setting a bang `*` has to occure on the left side of operator. The value is simply the percentage to set the level `0` is 0% `z` is 100%. For example `?5z` will set the engine reverb to 100%, or `?2h` will set the engine volume level to 50%.



---

## Demos

When Orca is installed, a number of demos are avaiable to demonstrate basic functionalites.


### synth-demo

![307x154,100%](https://frederickk.github.io/orca/screenshot/m-orca-synth-demo.png)

This demo shows very simply how the **SYNTH** operator `|` works, by randomly selecing notes created with the **TRACK** `T` operator.


### synth-scale-demo

![307x154,100%](https://frederickk.github.io/orca/screenshot/m-orca-synth-scale-demo.png)

This demo shows very simply how the **R.NOTE** operator `$` works, using the **SYNTH** `|` operator to generate the tones.


### import-demo

![307x154,100%](https://frederickk.github.io/orca/screenshot/m-orca-import-demo.png)

This is a text file, similar to what can be found on [PatchStorage](https://patchstorage.com/platform/orca/). Load this demo with the "» Import txt" menu within the main parameters page. Note, this demo uses the MIDI operator `:`, so unless you have a MIDI controller attached you won't hear any sound.





