Mandolin mand => Dyno dyn => dac;
Mandolin mand2 => dyn;
Mandolin mand3 => dyn;
Mandolin mand4 => dyn;
dyn.compress();
dyn => PRCRev r => dac;
0.1 => r.gain;
0.8 => r.mix;

float bpm;
120 => bpm;
dur whole;
dur half;
dur eight;
(60/bpm)::second => dur quarter;
4*quarter => whole;
2*quarter => half;
.5*quarter => eight;

float G3;
196 => G3;
float A3;
220 => A3;
float B3;
246.94 => B3;
float C4;
261.63 => C4;
float D4;
293.66 => D4;
float E4;
329.63 => E4;
float F4;
349.23 => F4;
float G4;
392 => G4;
float A4;
440 => A4;
float B4;
493.88 => B4;
float C5;
523.25 => C5;
float D5;
587.33 => D5;
float E5;
659.25 => E5;
float F5;
698.46 => F5;
float G5;
783.99 => G5;
float A5;
880 => A5;
float B5;
987.877 => B5;
float C6;
1046.50 => C6;
float D6;
1174.66 => D6;
float E6;
1318.51 => E6;

float Amin[4];
A3 => Amin[0];
E4 => Amin[1];
C5 => Amin[2];
E5 => Amin[3];

float Bdim[4];
B3 => Bdim[0];
D4 => Bdim[1];
B4 => Bdim[2];
F5 => Bdim[3];

float Cmaj[4];
C4 => Cmaj[0];
G4 => Cmaj[1];
E5 => Cmaj[2];
C6 => Cmaj[3];

float Dmin[4];
A3 => Dmin[0];
D4 => Dmin[1];
A4 => Dmin[2];
F5 => Dmin[3];

float Emin[4];
G3 => Emin[0];
E4 => Emin[1];
B4 => Emin[2];
E5 => Emin[3];

float Fmaj[4];
A3 => Fmaj[0];
F4 => Fmaj[1];
C5 => Fmaj[2];
F5 => Fmaj[3];

float Gmaj[4];
G3 => Gmaj[0];
D4 => Gmaj[1];
B4 => Gmaj[2];
G5 => Gmaj[3];

fun void playC(float arr[]){
  playMand(arr[0], eight);
  playMand(arr[1], eight);
  playMand(arr[2], quarter);
}

fun void eightArp(float arr[]){
  playMand(arr[0], eight );
  playMand(arr[1], eight );
  playMand(arr[2], eight );
  playMand(arr[3], eight );
}

fun void strum(float arr[], dur len){
  eight/4 => dur lent;
  arr[0] => mand.freq;
  arr[1] => mand2.freq;
  arr[2] => mand3.freq;
  arr[0] => mand4.freq;
  
  mand.noteOn;
  0.5 => mand.pluck;
  lent => now;
  mand.noteOn;
  0.6 => mand2.pluck;
  lent => now;
  mand.noteOn;
  0.7 => mand3.pluck;
  lent => now;
  mand.noteOn;
  0.8 => mand4.pluck;
  lent => now;
  len - eight => now;
  
  mand.noteOff;
  mand2.noteOff;
  mand3.noteOff;
  mand4.noteOff;
}

fun void playM(int num, float chord[]){
  for(0 => int i; i < num; i++){
    eightArp(chord);
    playC(chord);
  }
}

fun void playMand(float freq, dur len){
  freq => mand.freq;
  mand.noteOn;
  0.3 => mand.pluck;
  len => now;
  mand.noteOff;
}

fun void verse(){
  playM(4, Amin);
  playM(2, Dmin);
  playM(2, Amin);
  playM(1, Emin);
  playM(1, Dmin);
  playM(1, Amin);
  playM(1, Emin);
}

fun void chorus(){
  playM(1, Cmaj);
  strum(Cmaj, half);
  strum(Cmaj, half);
  playM(1, Fmaj);
  strum(Gmaj, half);
  strum(Fmaj, half);
  strum(Amin, half);
  playM(1, Amin);
  playM(1, Emin);
  strum(Dmin, half);
  strum(Cmaj, half);
  strum(Emin, half);
}

fun void timing(){
  eightArp(Amin);
  eightArp(Dmin);
  eightArp(Emin);
  eightArp(Amin);
}

fun void end(){
  strum(Cmaj, whole);
}

while(true){
  verse();
  chorus();
  verse();
  chorus();
  end();
  5::second => now;
}
