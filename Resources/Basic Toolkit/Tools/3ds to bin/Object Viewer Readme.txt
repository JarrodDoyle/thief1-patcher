   Takes a binary bsp file, or several binary bsp files, or a .cmp compound file and displays them.

   -ppal.gif specifies the palette to use, or
     If no palette is specified, the First Contact palette is used.
   -upal.gif specifies the palette to use without remapping textures
   -m means to generate and use mip maps in the model.
   -dd3d starts it in d3d mode.
   -cFILE loads in a command file line by line
       by default looks for view.cfg
   Set the RAW environment variable to point at your texture directory
   Set the IDATA environment variable to point at your model
      note that no 16 bit or 24 format of textures are supported.  Only cel
      gif,pcx, and bmp.
      You switch between the multiple models using the h key.
  
   Controls are:
   l/j, arrows, for changing object heading
   i/k, arrows, for changing pitch
   u/o for changing bank
   w/s for moving it backwards and forwards
   a/d for moving it left and right
   q/e for moving it up and down
   z/Z, also +/- zooms in and out
   b/v changes background color
   1/2 changes lighting harshness
   3/4 changes lighting heading
   5/6 changes lighting pitch
   7   toggles lighting or full ambient
   p   toggles lighting table displayer on and off
   P   makes a screen shot, viewxxxx.bmp
   r   changes resolution
   m   toggles texture/solid/wire modes
   t   cycles through textures, space toggles transparency
   f   toggles viewer motion versus object motion
   y   toggles information mode, showing vhots and vcalls, then lighting vecs
   x   toggles cycling the parameters to move subobjects
   `   toggles rendering order
   h   toggles through all the models
   n   toggles silly scaling mode
   [   toggles linear or perspective
   ]   collapses all the models and shows them together
   g   toggles mip mapping on and off
   \  updates all the textures
   :vhot <id>  moves the head to vhot number id
   :display "full" or "debug" or "d3d [#]" or "zd3d [#]" 
        or "list" to get d3d list on mono screen
   :res 800 600 sets the resolution
   :load foo.bin  loads a bsp model
   :load      brings up dialog box
   :fov <deg> makes the field of view <deg> degrees
   :rate <float> sets the rate of time for swinging parts
   :range <deg> sets the swinging range of the parts
   :time <float> sets the rate of time for all controls
   :model <int> sets the current model number
   :vcall <int vcall> <int model> sets a vcall to render a model.
          That model must be loaded already.
   :vcall clear  Clears all the vcalls.
   :vcall_spin <float rpm> spins a vcall model at rpm
   :update <on|off> starts or stops auto tmap updating (default off)
   :axle_list  mprints a list of all the axles and their ranges
   :back <r g b> makes the background be a specified rgb triplet
   :alpha <val 0..1> makes the object transparent.
   :sun_direct <val 0..1> makes that much light come directly from sun
   :sun_brightness <float val> scales the total brightness.
   :scale <x y z> scales the model in each axis.
   :scale <val> scales the model by val.
