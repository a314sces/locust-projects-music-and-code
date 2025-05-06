# TidalCycles Installation Guide and General Livecoding Introduction for macOS

## Understanding the TidalCycles Architecture

TidalCycles (or "Tidal" for short) is a live coding environment for creating algorithmic patterns, particularly for music. Before diving into installation, it's helpful to understand how the different components work together:

### System Architecture

TidalCycles is a free/open source live coding environment written in Haskell that works with SuperCollider for sound synthesis and I/O. Here's how the system is structured:

1. **TidalCycles**: A Haskell library that provides a concise and expressive language for describing flexible patterns of sounds, notes, and parameters. Tidal focuses on pattern generation and manipulation rather than sound synthesis.

2. **SuperCollider**: A powerful platform for audio synthesis and algorithmic composition. While SuperCollider is a complete environment for sound design and music creation in its own right, TidalCycles uses it as the sound engine.

3. **SuperDirt**: A specialized synthesizer and sampler built in SuperCollider that's designed to work with TidalCycles. SuperDirt handles all audio-related aspects when you're working with Tidal.

4. **Text Editor with TidalCycles plugin**: This is where you'll write and evaluate your TidalCycles code.

### How It All Works Together

When you evaluate TidalCycles code in your editor, it sends OSC (Open Sound Control) messages to SuperCollider/SuperDirt with parameter data including note values, duration, and cycle number. This modular design creates a clear separation of concerns:

- **TidalCycles**: Handles the compositional and pattern generation aspects
- **SuperCollider/SuperDirt**: Manages the sound synthesis and audio output

This architecture is particularly advantageous for live coding because:

1. TidalCycles provides a concise syntax that lets you express complex musical ideas quickly
2. The system is more efficient for creating rhythmic and pattern-based music than working directly in SuperCollider, which can be more verbose and requires more manual specification
3. You can focus on musical patterns without needing to understand the complexities of audio synthesis (although learning some SuperCollider will give you more control over sounds)

This guide will walk you through installing all of these components on macOS, from prerequisites to testing your setup.

> **Note for Windows Users**: If you're using Windows, please refer to the [TidalCycles Windows Installation Guide](https://tidalcycles.org/docs/getting-started/windows_install) instead.

## Prerequisites

Before installing TidalCycles, you'll need to install:

1. **Xcode Command Line Tools**
2. **Haskell** (via GHCup)
3. **SuperCollider** with SC3 Plugins
4. **Git**
5. A **text editor** for interacting with TidalCycles

## Option 1: Automatic Installation (Recommended for Beginners)

The TidalCycles team provides a bootstrap script that automates the installation process. This is the easiest method if you're new to Tidal and don't already have SuperCollider and SuperDirt installed.

### Step 1: Install Xcode Command Line Tools

Open Terminal and run:
```bash
/usr/bin/xcode-select --install
```

This will prompt you to install the Command Line Tools. Follow the instructions in the dialog boxes that appear. This may take 20-30 minutes to complete.

### Step 2: Run the tidal-bootstrap script

Once the Command Line Tools are installed, run:
```bash
curl https://raw.githubusercontent.com/tidalcycles/tidal-bootstrap/master/tidal-bootstrap.command -sSf | sh
```

This script will install:
- Haskell (via GHCup)
- Cabal (Haskell package manager)
- The Tidal Pattern engine
- Pulsar text editor with TidalCycles plugin
- SuperCollider
- SuperDirt (sample library used by Tidal)
- SC3 plugins for SuperCollider

The installation process might take 20-30 minutes, especially the Haskell part.

### Step 3: Verify Installation

After installation completes:

1. Close and reopen Terminal to load the updated PATH settings
2. Verify Tidal installation by running:
   ```bash
   cabal list tidal
   cabal info tidal
   ```
3. Check if the Pulsar TidalCycles plugin was installed correctly:
   ```bash
   ls ~/.pulsar/packages/tidalcycles/node_modules/osc-min
   ```
4. Verify SuperCollider installation:
   ```bash
   /Applications/SuperCollider.app/Contents/Resources/scsynth -v
   ```

## Option 2: Manual Installation

If you prefer to install components manually or have specific requirements, follow these steps.

### Step 1: Install GHCup (Haskell)

1. Visit [https://www.haskell.org/ghcup/](https://www.haskell.org/ghcup/) and follow the installation instructions
2. Add GHCup to your PATH:
   
   For macOS 10.14 or earlier (bash):
   ```bash
   . "$HOME/.ghcup/env"
   echo '. $HOME/.ghcup/env' >> "$HOME/.bashrc"
   ```
   
   For macOS 10.15+ (zsh):
   ```bash
   . "$HOME/.ghcup/env"
   echo '. $HOME/.ghcup/env' >> "$HOME/.zshrc"
   ```

### Step 2: Install Tidal

Update Cabal's package directory and install Tidal:
```bash
cabal update
cabal v1-install tidal
```

This might take some time if you've never installed TidalCycles before.

### Step 3: Install SuperCollider and SuperDirt

1. Download and install SuperCollider from [https://supercollider.github.io/downloads](https://supercollider.github.io/downloads)
2. Launch SuperCollider
3. Install SuperDirt by pasting this code and pressing Cmd+Return:
   ```
   Quarks.checkForUpdates({Quarks.install("SuperDirt", "v1.7.3"); thisProcess.recompile()})
   ```

### Step 4: Install a Text Editor

Choose and install one of the supported text editors. For this guide, we'll focus on **Visual Studio Code** (VS Code), which is currently one of the most popular options with good TidalCycles support:

#### Installing VS Code and TidalCycles Extension

1. **Download and Install VS Code**:
   - Visit [https://code.visualstudio.com/](https://code.visualstudio.com/)
   - Download the macOS version (.dmg file)
   - Open the downloaded file and drag Visual Studio Code to your Applications folder
   - Launch VS Code from your Applications folder

2. **Install the TidalCycles Extension**:
   - In VS Code, click on the Extensions icon in the left sidebar (or press `Cmd+Shift+X`)
   - In the search box, type "TidalCycles"
   - Find the "TidalCycles for VSCode" extension by tidalcycles
   - Click the "Install" button

3. **Install Haskell Syntax Highlighting**:
   - While still in the Extensions view, search for "Haskell Syntax Highlighting"
   - Find the extension by Justus Adam
   - Click the "Install" button

4. **Configure VS Code for TidalCycles**:
   - Open VS Code settings by pressing `Cmd+,` or selecting Code > Preferences > Settings
   - Click on the "Open Settings (JSON)" icon in the top right corner
   - Add the following settings:
   
   ```json
   {
     "files.associations": {
       "*.tidal": "haskell"
     },
     "tidalcycles.ghciPath": "ghci"
   }
   ```
   
   - If you're using Stack instead of regular GHC, add `"tidalcycles.useStackGhci": true`
   - Save the settings file

5. **Verifying Installation**:
   - Create a new file and save it with a `.tidal` extension
   - Write a simple pattern like `d1 $ sound "bd sd"`
   - To evaluate the line, place your cursor on the line and press `Shift+Enter`
   - To evaluate multiple lines, select them and press `Ctrl+Enter`
   - To stop all sounds (hush), press `Ctrl+Alt+H`

#### Special Features of the VS Code Extension

The VS Code TidalCycles extension includes a sample browser feature not available in other editors:

1. Click on the TidalCycles logo in the left sidebar activity bar
2. Browse through the available samples
3. Click on a sample to preview its sound
4. Click the insert icon to add the sample name to your code

Other supported text editors include:

- **Pulsar**: Install from [https://pulsar-edit.dev/](https://pulsar-edit.dev/), then install the TidalCycles plugin
- **Emacs**: Configure with Tidal mode
- **Vim/Neovim**: Configure with Tidal plugin
- **Sublime Text**: Configure with Tidal package

## Join the TidalCycles Community

Once you've installed TidalCycles and started exploring, you might want to connect with the vibrant community of live coders around the world. Here are some great resources:

### Tidal Club

[Tidal Club](https://club.tidalcycles.org/) is the official community forum for TidalCycles users. It's an excellent place to:

- Ask questions and get help with installation issues
- Share your patterns and performances
- Learn from other users' experiments
- Discover advanced techniques and custom functions
- Connect with the global community of live coders

### Notable Community Members

The TidalCycles community includes many innovative musicians and developers:

- **Alex McLean (Yaxu)**: Creator of TidalCycles and co-founder of the Algorave movement. Alex developed TidalCycles as part of his research into rhythm and cycle, creating a tool that's both musically expressive and technically powerful.

- **Richard Devine**: Renowned electronic musician and sound designer who has worked with companies like Sony, Microsoft, Google, and Nike. Richard is known for his complex, layered compositions and has been exploring live coding with TidalCycles alongside his extensive modular synthesizer work.

- **Lil Data**: Live coder and electronic musician affiliated with PC Music, who has created TidalCycles remixes of tracks by artists like Charli XCX.

- **Kindohm (Mike Hodnick)**: Prolific live coder and electronic musician known for his complex rhythmic patterns and extensive contributions to the community. You can find his code examples and projects on his [GitHub repository](https://github.com/kindohm).

### TOPLAP and Algorave

TidalCycles is closely associated with two important movements in the live coding world:

- **TOPLAP (Temporary Organisation for the Promotion of Live Algorithm Programming)**: Founded in 2004, TOPLAP is the central organization for live coding practices and communities worldwide. They organize events, maintain resources, and promote the practice of live coding across artistic disciplines.

- **Algorave**: A movement and event format featuring algorithmic music intended for dancing. The term combines "algorithm" and "rave" and was coined by Alex McLean and Nick Collins. Algoraves feature performances where musicians code music on the fly, with their screens projected for the audience to see.

### Annual Events

If you'd like to see live coding in action or share your own work, look out for these regular events:

- **Eulerroom Equinox**: An annual non-stop streaming event organized by TOPLAP, typically held around the March equinox, featuring live coding performances from around the world.

- **Algorave Festivals**: Taking place in cities globally, these events showcase live-coded music in a dance party context.

- **International Conference on Live Coding (ICLC)**: An academic conference bringing together researchers and practitioners working with live coding in various contexts.

Getting involved with these communities can greatly enhance your TidalCycles journey, providing inspiration, technical support, and connections with other creative coders around the world.

## Starting TidalCycles

Once you've set up your SuperCollider startup file (or if you prefer to start manually):

1. Open SuperCollider
2. If you haven't configured a startup file, start SuperDirt by executing:
   ```
   SuperDirt.start
   ```
3. Open your chosen text editor with the TidalCycles plugin/extension
4. Create a new file with a `.tidal` extension
5. Write a simple pattern, for example:
   ```haskell
   d1 $ sound "bd sd"
   ```
6. Evaluate the code (method depends on your text editor):
   - In VS Code: Place cursor on the line and press `Shift+Enter`
   - In Pulsar: Place cursor on the line and press `Shift+Enter`
   - In Emacs: Place cursor on the line and press `C-c C-e`
   - In Vim/Neovim with vim-tidal: Place cursor on the line and press `<localleader>e`

7. To stop all sounds, evaluate:
   ```haskell
   hush
   ```

### Basic Startup File Example

Here's a comprehensive startup file that enhances your TidalCycles setup with better audio configuration:

```supercollider
(
// Configuration for SuperDirt and TidalCycles
// Adapted from various community examples

// Server configuration
s.options.numBuffers = 1024 * 256;  // Increase if you need more samples
s.options.memSize = 8192 * 32;      // Increase if you get "alloc failed" messages
s.options.numWireBufs = 64;         // Increase for complex patches
s.options.maxNodes = 1024 * 32;     // Increase for complex sessions
s.options.numOutputBusChannels = 2; // Stereo output
s.options.numInputBusChannels = 2;  // Stereo input

// Wait for server to boot before configuring SuperDirt
s.waitForBoot {
    // Create SuperDirt instance with 2 orbits (stereo channels)
    ~dirt = SuperDirt(2, s);
    
    // Load default samples
    ~dirt.loadSoundFiles;
    
    // Optional: Load custom sample libraries
    // ~dirt.loadSoundFiles("~/Music/TidalSamples/*");
    
    // Start SuperDirt listening on default port
    ~dirt.start(57120, [0, 0]);
    
    // Set latency for stable timing
    s.latency = 0.3;
    
    // Console feedback
    "SuperDirt is running and ready for TidalCycles".postln;
};
)
```

### Example: Advanced MIDI Configuration for DAW Integration

Here's an example of a more sophisticated setup that creates multiple MIDI connections to control a DAW like Ableton Live. This approach uses IAC (Inter-Application Communication) Driver buses to route MIDI from TidalCycles to different channels in your DAW:

```supercollider
// SuperCollider startup file for advanced TidalCycles + DAW integration

// Audio device selection - uncomment the one you're using
// s.options.device = "Built-in Output";
// s.options.device = "Universal Audio Thunderbolt";
// s.options.device = "AirPods Max";
s.options.device = "Your Audio Interface"; // Change to your device name

// Basic server configuration
s.options.numOutputBusChannels = 2; // Stereo output
s.options.numInputBusChannels = 0;
s.options.memSize = 8192 * 16;
s.options.numBuffers = 1024 * 256;
s.options.maxNodes = 1024 * 32;

// Reboot server with new configuration
s.reboot;
s.waitForBoot{
    // Create SuperDirt instance with 2 channels per orbit
    ~dirt = SuperDirt(2, s);
    
    // Start SuperDirt with 12 orbits (for extensive multichannel use)
    ~dirt.start(57120, 0 ! 12, NetAddr("127.0.0.1"));
    
    // Load custom sample libraries - replace with your paths
    ~dirt.loadSoundFiles("~/Music/TidalSamples/drums/*");
    ~dirt.loadSoundFiles("~/Music/TidalSamples/synths/*");
    
    // Wait for SuperCollider to finish booting
    s.sync;
    
    // Initialize MIDI
    MIDIClient.init;
    
    // Create MIDI outputs to IAC Driver buses
    // These let you send MIDI to different tracks in your DAW
    ~midiOut1 = MIDIOut.newByName("IAC Driver", "Bus 1");
    ~midiOut2 = MIDIOut.newByName("IAC Driver", "Bus 2");
    ~midiOut3 = MIDIOut.newByName("IAC Driver", "Bus 3");
    ~midiOut4 = MIDIOut.newByName("IAC Driver", "Bus 4");
    
    // Add these MIDI destinations to SuperDirt with custom names
    // These names will be used as synth names in TidalCycles
    ~dirt.soundLibrary.addMIDI(\drums, ~midiOut1);
    ~dirt.soundLibrary.addMIDI(\bass, ~midiOut2);
    ~dirt.soundLibrary.addMIDI(\lead, ~midiOut3);
    ~dirt.soundLibrary.addMIDI(\pad, ~midiOut4);
    
    // Optional: Add hardware synths if you have them
    // ~midiOutHW = MIDIOut.newByName("Your Hardware Synth", "MIDI Port Name");
    // ~dirt.soundLibrary.addMIDI(\hardware, ~midiOutHW);
    
    // Print message when everything is ready
    "SuperDirt is running with MIDI configuration for DAW integration.".postln;
    "Available synths: drums, bass, lead, pad".postln;
};
```

After setting up this configuration, you can use TidalCycles to send MIDI to different channels in your DAW:

```haskell
-- Send a bass pattern to the 'bass' MIDI device (IAC Driver Bus 2)
d1 $ note "c3 [~ c3] e3 g3" # s "bass"

-- Send a drum pattern to the 'drums' MIDI device (IAC Driver Bus 1)
d2 $ n "36 ~ 38 ~" # s "drums"  -- MIDI notes 36=kick, 38=snare

-- Send a lead melody to the 'lead' MIDI device (IAC Driver Bus 3)
d3 $ note "c5 [e5 g5] c6 a5" # s "lead"
```

To set up the IAC Driver on macOS:
1. Open "Audio MIDI Setup" (found in Applications/Utilities)
2. Open the MIDI Studio window (Window > Show MIDI Studio) 
3. Double-click the IAC Driver icon
4. Check "Device is online"
5. Add as many ports as you need (each port can have 16 MIDI channels)
6. In your DAW, configure MIDI tracks to receive from these IAC buses

### Integration with Ableton Link

To sync TidalCycles with Ableton Live or other Link-enabled software:

```supercollider
(
// Usual server configuration
s.options.numBuffers = 1024 * 256;
s.options.memSize = 8192 * 32;
s.options.numWireBufs = 64;
s.options.maxNodes = 1024 * 32;
s.options.numOutputBusChannels = 2;
s.options.numInputBusChannels = 2;

s.waitForBoot {
    // Start SuperDirt
    ~dirt = SuperDirt(2, s);
    ~dirt.loadSoundFiles;
    ~dirt.start(57120, [0, 0]);
    
    // Create Link connection (requires sc3-plugins)
    // The 2 is the beats per cycle
    ~link = LinkClock(2).latency_(s.latency);
    
    // Register the clock with SuperDirt
    ~link.tempo_(120/60/2); // Set tempo (120 BPM)
    ~dirt.serverControls = ~dirt.serverControls.addFirst(~link);
    
    "SuperDirt is running with Ableton Link support".postln;
    "Current tempo: 120 BPM".postln;
};
)
```

### Using Your Startup File

1. After saving your startup file, restart SuperCollider
2. The configured settings will load automatically
3. For MIDI integration, remember to:
   - Verify device names with `MIDIClient.destinations` before setting them
   - Configure your DAW to receive MIDI if needed
   - In TidalCycles, use the `midi` synth to send MIDI messages:
     ```haskell
     d1 $ note "c4 e4 g4 c5" # s "midi"
     ```

4. For Ableton Link:
   - Ensure Link is enabled in your DAW
   - You may need to adjust the tempo in TidalCycles with `setcps (120/60/2)`

These configurations will help you integrate TidalCycles with your existing music production workflow, allowing you to combine the powerful pattern generation of Tidal with your favorite DAW, hardware synths, or other software.

## Troubleshooting

If you encounter issues:

- For Haskell problems, check the log at `/tmp/ghcup-install.log`
- If the automatic installation failed, try running the bootstrap script again
- If SuperDirt wasn't installed correctly, open SuperCollider, choose "Quarks" from the Language menu, and check if SuperDirt and Dirt-Samples are listed and checked
- If the text editor plugin didn't install correctly, try installing it manually through the editor's package manager

## System Compatibility

- Silicon/M1 Macs: Validated on macOS Ventura
- Intel Macs: Tested on Big Sur and Monterey

## Next Steps

After successful installation, explore:
1. Basic patterns and functions
2. Working with samples
3. Adding effects
4. Combining patterns

Happy live coding!
