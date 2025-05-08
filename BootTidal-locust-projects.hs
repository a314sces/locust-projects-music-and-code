:set -XOverloadedStrings
:set prompt ""

import Sound.Tidal.Context
import Data.List (intercalate)

:{
let robustSlicedSamplePlayer stepCount notesPerBar barCount sampleName midiChannel =
      let indices = intercalate " " (map show [0 .. stepCount - 1])
          stepCountPattern = parseBP_E (show stepCount)
          bars = intercalate " " (map show [0 .. barCount - 1])
      in
          n (parseBP_E ("{" ++ indices ++ "}%" ++ (show notesPerBar))
             |+ (parseBP_E("<" ++ bars ++">") |* parseBP_E(show stepCount))
             |+ "-24")
           # s sampleName
           # midichan midiChannel
:}

:{
let rescale :: (Double, Double) -> (Double, Double) -> Double -> Double
    rescale (inMin, inMax) (outMin, outMax) x = 
        outMin + (x - inMin) * (outMax - outMin) / (inMax - inMin)
:}

:{
let binaryToPattern :: String -> Pattern Bool
    binaryToPattern str = stack $ fmap (pure . (== '1')) str
:}

:{
let octaveUp :: String -> Pattern Int
    octaveUp pat = s
      where
        boolPat = binaryToPattern pat
        s = fmap (\x -> if x then 12 else 0) boolPat

    octaveDown :: String -> Pattern Int
    octaveDown pat = s
      where
        boolPat = binaryToPattern pat
        s = fmap (\x -> if x then (-12) else 0) boolPat
:}


:{
let slicedSamplePlayer stepCount barCount sampleName midiChannel =
      let indices = intercalate " " (map show [0 .. stepCount - 1])
          stepCountPattern = parseBP_E (show stepCount)
          bars = intercalate " " (map show [0 .. barCount - 1])
      in
           n (parseBP_E ("{" ++ indices ++ "}%" ++ (show stepCount))
             |+ (parseBP_E("<" ++ bars ++">") |* parseBP_E(show stepCount))
             |+ "-24")
           # s sampleName
           # midichan midiChannel
:}

import System.IO (hSetEncoding, stdout, utf8)
hSetEncoding stdout utf8

tidal <- startTidal (superdirtTarget {oLatency = 0, oAddress = "127.0.0.1", oPort = 57120}) (defaultConfig {cVerbose = True, cFrameTimespan = 1/20, cProcessAhead=3/10})

:{
let only = (hush >>)
    p = streamReplace tidal
    hush = streamHush tidal
    panic = do hush
               once $ sound "superpanic"
    list = streamList tidal
    mute = streamMute tidal
    unmute = streamUnmute tidal
    unmuteAll = streamUnmuteAll tidal
    unsoloAll = streamUnsoloAll tidal
    solo = streamSolo tidal
    unsolo = streamUnsolo tidal
    once = streamOnce tidal
    first = streamFirst tidal
    asap = once
    nudgeAll = streamNudgeAll tidal
    all = streamAll tidal
    resetCycles = streamResetCycles tidal
    setcps = asap . cps
    getcps = streamGetcps tidal
    getnow = streamGetnow tidal
    xfade i = transition tidal True (Sound.Tidal.Transition.xfadeIn 4) i
    xfadeIn i t = transition tidal True (Sound.Tidal.Transition.xfadeIn t) i
    histpan i t = transition tidal True (Sound.Tidal.Transition.histpan t) i
    wait i t = transition tidal True (Sound.Tidal.Transition.wait t) i
    waitT i f t = transition tidal True (Sound.Tidal.Transition.waitT f t) i
    jump i = transition tidal True (Sound.Tidal.Transition.jump) i
    jumpIn i t = transition tidal True (Sound.Tidal.Transition.jumpIn t) i
    jumpIn' i t = transition tidal True (Sound.Tidal.Transition.jumpIn' t) i
    jumpMod i t = transition tidal True (Sound.Tidal.Transition.jumpMod t) i
    jumpMod' i t p = transition tidal True (Sound.Tidal.Transition.jumpMod' t p) i
    mortal i lifespan release = transition tidal True (Sound.Tidal.Transition.mortal lifespan release) i
    interpolate i = transition tidal True (Sound.Tidal.Transition.interpolate) i
    interpolateIn i t = transition tidal True (Sound.Tidal.Transition.interpolateIn t) i
    clutch i = transition tidal True (Sound.Tidal.Transition.clutch) i
    clutchIn i t = transition tidal True (Sound.Tidal.Transition.clutchIn t) i
    anticipate i = transition tidal True (Sound.Tidal.Transition.anticipate) i
    anticipateIn i t = transition tidal True (Sound.Tidal.Transition.anticipateIn t) i
    forId i t = transition tidal False (Sound.Tidal.Transition.mortalOverlay t) i
    d1 = p 1 . (|< orbit 0)
    d2 = p 2 . (|< orbit 1)
    d3 = p 3 . (|< orbit 2)
    d4 = p 4 . (|< orbit 3)
    d5 = p 5 . (|< orbit 4)
    d6 = p 6 . (|< orbit 5)
    d7 = p 7 . (|< orbit 6)
    d8 = p 8 . (|< orbit 7)
    d9 = p 9 . (|< orbit 8)
    d10 = p 10 . (|< orbit 9)
    d11 = p 11 . (|< orbit 10)
    d12 = p 12 . (|< orbit 11)
    d13 = p 13
    d14 = p 14
    d15 = p 15
    d16 = p 16
    d17 = p 17
    d18 = p 18
    d19 = p 19
    d20 = p 20
    f1 = p "f1" . (|< midichan 1) . (|< ccn 2)
    f2 = p "f2" . (|< midichan 2) . (|< ccn 3)
    f3 = p "f3" . (|< midichan 3) . (|< ccn 4)
    f4 = p "f4" . (|< midichan 4) . (|< ccn 5)
    f5 = p "f5" . (|< midichan 5) . (|< ccn 6)
    f6 = p "f6" . (|< midichan 6) . (|< ccn 7)
    f7 = p "f7" . (|< midichan 7) . (|< ccn 8)
    f8 = p "f8" . (|< midichan 8) . (|< ccn 9)
    f9 = p "f9" . (|< midichan 9) . (|< ccn 10)
    f10 = p "f10" . (|< midichan 10) . (|< ccn 11)
    f11 = p "f11" . (|< midichan 11) . (|< ccn 12)
    f12 = p "f12" . (|< midichan 12) . (|< ccn 13)
    f13 = p "f13" . (|< midichan 13) . (|< ccn 14)
    f14 = p "f14" . (|< midichan 14) . (|< ccn 15)
    f15 = p "f15" . (|< midichan 15) . (|< ccn 16)
    f16 = p "f16" . (|< midichan 16) . (|< ccn 17)
    m1 = p "m1" . (|< midichan 1) . (|< ccn 2)
    m2 = p "m2" . (|< midichan 2) . (|< ccn 3)
    m3 = p "m3" . (|< midichan 3) . (|< ccn 4)
    m4 = p "m4" . (|< midichan 4) . (|< ccn 5)
    m5 = p "m5" . (|< midichan 5) . (|< ccn 6)
    m6 = p "m6" . (|< midichan 6) . (|< ccn 7)
    m7 = p "m7" . (|< midichan 7) . (|< ccn 8)
    m8 = p "m8" . (|< midichan 8) . (|< ccn 9)
    m9 = p "m9" . (|< midichan 9) . (|< ccn 10)
    m10 = p "m10" . (|< midichan 10) . (|< ccn 11)
    m11 = p "m11" . (|< midichan 11) . (|< ccn 12)
    m12 = p "m12" . (|< midichan 12) . (|< ccn 13)
    m13 = p "m13" . (|< midichan 13) . (|< ccn 14)
    m14 = p "m14" . (|< midichan 14) . (|< ccn 15)
    m15 = p "m15" . (|< midichan 15) . (|< ccn 16)
    m16 = p "m16" . (|< midichan 16) . (|< ccn 17)
:}

:{
let getState = streamGet tidal
    setI = streamSetI tidal
    setF = streamSetF tidal
    setS = streamSetS tidal
    setR = streamSetR tidal
    setB = streamSetB tidal
:}

:set prompt "tidal> "
:set prompt-cont ""

default (Pattern String, Integer, Double)
