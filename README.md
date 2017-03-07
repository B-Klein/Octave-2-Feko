# Octave-2-Feko
Creates EDITFEKO files from within GNU Octave. 

Installation

Install Gnu Octave, this code has been tested on Octave 4.0.0., other versions should
also work. Add the directory Octave-2-Feko path:

  1. Navigate to the directory below where you have cloned the repo, open Octave and run:
    $ addpath([pwd '/Octave-2-Feko'])
    $ savepath

The @WritePreFeko class is all that is required in order to create EDITFEKO files, the other classes are for integrating gmsh, better handeling of 3D objects and for drawing in .tex.
