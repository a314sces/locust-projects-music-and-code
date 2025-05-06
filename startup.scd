// This code forwards messages from tidal to an additional port via OSC.
// From https://github.com/tado/ofxTidalCycles

// -----------------------------------------------------------------------
// Send to somewhere else
// -----------------------------------------------------------------------

// var addr = NetAddr.new("127.0.0.1", 3333);
// OSCFunc({ |msg, time, tidalAddr|
//	var latency = time - Main.elapsedTime;
//	msg = msg ++ ["time", time, "latency", latency];
//	msg.postln;
//	addr.sendBundle(latency, msg)
// }, '/play2').fix;


// s.options.device                 = "Universal Audio Thunderbolt";
// s.options.device                 = "Built-in Output";
// s.options.device                 = "AirPods Max";
// s.options.device                 = "MacBook Pro Speakers";
// s.options.device                 = "TD";
// s.options.device                 = "DJM-900NXS2"; // your interface here

// -----------------------------------------------------------------------
// Options
// -----------------------------------------------------------------------

s.options.numOutputBusChannels      = 2; // 1 stero channel
s.options.numInputBusChannels       = 0;
s.options.memSize                   = 8192*16;
s.options.numBuffers                = 1024*256;
s.options.maxNodes                  = 1024*32;

// -----------------------------------------------------------------------
// Bootup
// -----------------------------------------------------------------------

s.reboot;
s.waitForBoot{

	// SuperDirt.start;
	~dirt = SuperDirt(2,s); // 2 channels per orbit
	~dirt.start(57120, 0 ! 12, NetAddr("127.0.0.1") );

//	~dirt.loadSoundFiles("/Users/lfo/Dropbox/cv/*"); // how to load a custom sample library

	s.sync; // wait for supercollider to finish booting up

	MIDIClient.init;

        ~midiOut1 = MIDIOut.newByName("IAC Driver", "Tidal1");
        ~midiOut2 = MIDIOut.newByName("IAC Driver", "Tidal2");
        ~midiOut3 = MIDIOut.newByName("IAC Driver", "Tidal3");
        ~midiOut4 = MIDIOut.newByName("IAC Driver", "Tidal4");
        ~midiOut5 = MIDIOut.newByName("IAC Driver", "Tidal5");
        ~midiOut6 = MIDIOut.newByName("IAC Driver", "Tidal6");
        ~midiOut7 = MIDIOut.newByName("IAC Driver", "Tidal7");
        ~midiOut8 = MIDIOut.newByName("IAC Driver", "Tidal8");
        ~midiOut9 = MIDIOut.newByName("IAC Driver", "Tidal9");
        ~midiOut10 = MIDIOut.newByName("IAC Driver", "Tidal10");
        ~midiOut11 = MIDIOut.newByName("IAC Driver", "Tidal11");
        ~midiOut12 = MIDIOut.newByName("IAC Driver", "Tidal12");
        ~midiOut13 = MIDIOut.newByName("IAC Driver", "Tidal13");
        ~midiOut14 = MIDIOut.newByName("IAC Driver", "Tidal14");
        ~midiOut15 = MIDIOut.newByName("IAC Driver", "Tidal15");
        ~midiOut16 = MIDIOut.newByName("IAC Driver", "Tidal16");
        ~midiOut17 = MIDIOut.newByName("IAC Driver", "Tidal17");
        ~midiOut18 = MIDIOut.newByName("IAC Driver", "Tidal18");
        ~midiOut19 = MIDIOut.newByName("IAC Driver", "Tidal19");
        ~midiOut20 = MIDIOut.newByName("IAC Driver", "Tidal20");
//        ~midiOut21 = MIDIOut.newByName("IAC Driver", "Tidal21");
//        ~midiOut22 = MIDIOut.newByName("IAC Driver", "Tidal22");
//        ~midiOut23 = MIDIOut.newByName("IAC Driver", "Tidal23");
        ~midiOut31 = MIDIOut.newByName("IAC Driver", "TidalCh1");
        ~midiOut32 = MIDIOut.newByName("IAC Driver", "TidalCh2");
        ~midiOut33 = MIDIOut.newByName("IAC Driver", "TidalCh3");
        ~midiOut34 = MIDIOut.newByName("IAC Driver", "TidalCh4");
        ~midiOut35 = MIDIOut.newByName("IAC Driver", "TidalCh5");
        ~midiOut36 = MIDIOut.newByName("IAC Driver", "TidalCh6");
        ~midiOut37 = MIDIOut.newByName("IAC Driver", "TidalCh7");
        ~midiOut38 = MIDIOut.newByName("IAC Driver", "TidalCh8");
        ~midiOut39 = MIDIOut.newByName("IAC Driver", "TidalCh9");
        ~midiOut41 = MIDIOut.newByName("IAC Driver", "Touch1");
        ~midiOut42 = MIDIOut.newByName("IAC Driver", "Touch2");
        ~midiOut43 = MIDIOut.newByName("IAC Driver", "Touch3");

        ~dirt.soundLibrary.addMIDI(\pig, ~midiOut1);
        ~dirt.soundLibrary.addMIDI(\drums, ~midiOut2);
        ~dirt.soundLibrary.addMIDI(\three, ~midiOut3);
        ~dirt.soundLibrary.addMIDI(\four, ~midiOut4);
        ~dirt.soundLibrary.addMIDI(\five, ~midiOut5);
        ~dirt.soundLibrary.addMIDI(\six, ~midiOut6);
        ~dirt.soundLibrary.addMIDI(\seven, ~midiOut7);
        ~dirt.soundLibrary.addMIDI(\eight, ~midiOut8);
        ~dirt.soundLibrary.addMIDI(\nine, ~midiOut9);
        ~dirt.soundLibrary.addMIDI(\ten, ~midiOut10);
        ~dirt.soundLibrary.addMIDI(\eleven, ~midiOut11);
        ~dirt.soundLibrary.addMIDI(\twelve, ~midiOut12);
        ~dirt.soundLibrary.addMIDI(\thirteen, ~midiOut13);
        ~dirt.soundLibrary.addMIDI(\fourteen, ~midiOut14);
        ~dirt.soundLibrary.addMIDI(\fifteen, ~midiOut15);
        ~dirt.soundLibrary.addMIDI(\sixteen, ~midiOut16);
        ~dirt.soundLibrary.addMIDI(\seventeen, ~midiOut17);
        ~dirt.soundLibrary.addMIDI(\eighteen, ~midiOut18);
        ~dirt.soundLibrary.addMIDI(\nineteen, ~midiOut19);
        ~dirt.soundLibrary.addMIDI(\twenty, ~midiOut20);
        ~dirt.soundLibrary.addMIDI(\ch1, ~midiOut31);
        ~dirt.soundLibrary.addMIDI(\ch2, ~midiOut32);
        ~dirt.soundLibrary.addMIDI(\ch3, ~midiOut33);
        ~dirt.soundLibrary.addMIDI(\ch4, ~midiOut34);
        ~dirt.soundLibrary.addMIDI(\ch5, ~midiOut35);
        ~dirt.soundLibrary.addMIDI(\ch6, ~midiOut36);
        ~dirt.soundLibrary.addMIDI(\ch7, ~midiOut37);
        ~dirt.soundLibrary.addMIDI(\ch8, ~midiOut38);
        ~dirt.soundLibrary.addMIDI(\ch9, ~midiOut39);
        ~dirt.soundLibrary.addMIDI(\touch1, ~midiOut41);
        ~dirt.soundLibrary.addMIDI(\touch2, ~midiOut42);
        ~dirt.soundLibrary.addMIDI(\touch3, ~midiOut43);

//  ~midiOut48 = MIDIOut.newByName("208C", "208C");
//  ~dirt.soundLibrary.addMIDI(\buchla, ~midiOut48);

// ~midiOut49 = MIDIOut.newByName("Arturia MicroFreak", "");
// ~dirt.soundLibrary.addMIDI(\micro, ~midiOut49);

// ~midiOut50 = MIDIOut.newByName("Elektron Digitakt", "Elektron Digitakt");
// ~dirt.soundLibrary.addMIDI(\takt, ~midiOut50);

// ~midiOut51 = MIDIOut.newByName("POLY2", "POLY2");
// ~dirt.soundLibrary.addMIDI(\poly2, ~midiOut51);

 // ~midiOut52 = MIDIOut.newByName("HYDRASYNTH DR", "HYDRASYNTH DR");
 // ~dirt.soundLibrary.addMIDI(\hydra, ~midiOut52);

// ~midiOut53 = MIDIOut.newByName("Blofeld", "");
// ~dirt.soundLibrary.addMIDI(\blofeld, ~midiOut53);

// ~midiOut54 = MIDIOut.newByName("Waldorf Kyra", "Kyra MIDI In");
// ~dirt.soundLibrary.addMIDI(\kyra, ~midiOut54);

// ~midiOut55 = MIDIOut.newByName("Elektron Digitone", "Elektron Digitone");
// ~dirt.soundLibrary.addMIDI(\digi, ~midiOut55);

// ~midiOut56 = MIDIOut.newByName("USB MIDI Interface", "USB MIDI Interface");
// ~dirt.soundLibrary.addMIDI(\pop, ~midiOut56);

// ~midiOut57 = MIDIOut.newByName("RD-9", "RD-9");
// ~dirt.soundLibrary.addMIDI(\rd9, ~midiOut57);

// ~midiOut58 = MIDIOut.newByName("RD-8", "RD-8");
// ~dirt.soundLibrary.addMIDI(\rd8, ~midiOut58);

// ~midiOut70 = MIDIOut.newByName("mioXL", "DIN 7");
// ~dirt.soundLibrary.addMIDI(\r8, ~midiOut70);

// ~midiOut71 = MIDIOut.newByName("mioXL", "DIN 5");
// ~dirt.soundLibrary.addMIDI(\strings, ~midiOut71);

// ~midiOut72 = MIDIOut.newByName("mioXL", "DIN 4");
// ~dirt.soundLibrary.addMIDI(\xbase09, ~midiOut72);

// ~midiOut80 = MIDIOut.newByName("Nord Lead 4", "MIDI Input");
// ~dirt.soundLibrary.addMIDI(\nord, ~midiOut80);

// ~midiOut81 = MIDIOut.newByName("UNO Synth", "UNO Synth");
// ~dirt.soundLibrary.addMIDI(\uno, ~midiOut81);

// ~midiOut82 = MIDIOut.newByName("opsix", "Generic USB MIDI Sound");
// ~dirt.soundLibrary.addMIDI(\opsix, ~midiOut82);

// ~midiOut83 = MIDIOut.newByName("MS-20 mini", "SYNTH");
// ~dirt.soundLibrary.addMIDI(\ms20, ~midiOut83);

// ~midiOut84 = MIDIOut.newByName("SQ-64", "SEQ");
// ~dirt.soundLibrary.addMIDI(\seq64, ~midiOut84);

// ~midiOut85 = MIDIOut.newByName("USB Midi ", "USB Midi ");
// ~dirt.soundLibrary.addMIDI(\mks80, ~midiOut85);

// ~midiOut86 = MIDIOut.newByName("USB Midi Over", "USB Midi ");
// ~dirt.soundLibrary.addMIDI(\mks80, ~midiOut86);

};
