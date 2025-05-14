#define Name "RoguePatcher"
#define Version "1.28.0"
#define Publisher "Jarrod Doyle"
#define URL "https://jayrude.dev/"

[Setup]
AppName={#Name}
AppVersion={#Version}
AppPublisher={#Publisher}
AppPublisherURL={#URL}
AppendDefaultDirName=no
Compression=lzma/ultra64
DefaultDirName=C:\Games\Thief Gold
DirExistsWarning=no
DisableDirPage=no
DisableProgramGroupPage=yes
DisableWelcomePage=no
OutputDir=Z:\work\Build
OutputBaseFilename={#Name}_{#Version}
PrivilegesRequired=lowest
SolidCompression=yes
SetupIconFile=darkicon.ico
Uninstallable=no
WizardImageFile=thiefgold.bmp
WizardSmallImageFile=darkicon.bmp
WizardStyle=modern

[Types]
Name: "custom"; Description: "Custom"; Flags: iscustom

[Components]
Name: "newdark"; Description: "NewDark"; Types: custom; Flags: fixed;
Name: "dromed"; Description: "DromEd"; 
Name: "dromed\toolkit"; Description: "DromEd Basic Toolkit";
Name: "multiplayer"; Description: "Multiplayer";

; [Tasks]
; Name: "newdark"; Description: "Install NewDark 1.28";

;Name: "dromed"; Description: "Install DromEd"; GroupDescription: "Level Editor:"; Flags: unchecked
;Name: "toolkit"; Description: "Install the Basic Toolkit"; GroupDescription: "Level Editor:"; Flags: unchecked
;Name: "dromedhw"; Description: "Enable hardware rendering"; GroupDescription: "Level Editor:"; Flags: unchecked

;Name: "fpsfix"; Description: "High refresh rate physics corrections"; GroupDescription: "Fixes/Corrections:"; Flags: unchecked
;Name: "stutterfix"; Description: "Micro stutter/mouse lag fix (Not recommended on CrossFire/SLI setups)"; GroupDescription: "Fixes/Corrections:"; Flags: unchecked

;Name: "newmantle"; Description: "Enable NewDark mantling (HIGHLY RECOMMENDED)"; GroupDescription: "Config Edits:";
;Name: "fmsel"; Description: "Enable built-in fan mission launcher"; GroupDescription: "Config Edits:";
;Name: "texfilter"; Description: "Disable texture filtering"; GroupDescription: "Config Edits:"; Flags: unchecked
;Name: "windowed"; Description: "Enable windowed mode"; GroupDescription: "Config Edits:"; Flags: unchecked

[Files]
Source: "Resources\NewDark\*"; DestDir: "{app}"; Components: newdark; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Resources\DromEd\*"; DestDir: "{app}"; Components: dromed; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Resources\Basic Toolkit\*"; DestDir: "{app}"; Components: dromed\toolkit; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Resources\Multiplayer\*"; DestDir: "{app}"; Components: multiplayer; Flags: ignoreversion recursesubdirs createallsubdirs
;Source: "darkicon.ico"; DestDir: "{app}"; AfterInstall: PerformTasks

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Messages]
WelcomeLabel1=Welcome to the {#Name} Wizard
WelcomeLabel2=This will install the latest NewDark patch for Thief: The Dark Project and Thief: Gold. A full installation of either game is required and a fresh unmodded install is assumed.%n%nThis patcher keeps the game as close to vanilla as possible and attempts to ensure maximum compatibility with fan mission projects.%n%nNote: Many changes made by this installer are irreversible. It is recommended you backup your game before continuing with the installation.

[Code]
procedure UpdateTasksList();
begin
  WizardForm.TasksList.ItemEnabled[0] := False;

  // if WizardIsTaskSelected('dromed') then
  //   begin
  //     WizardForm.TasksList.ItemEnabled[3] := True;
  //     WizardForm.TasksList.ItemEnabled[4] := True;
  //   end
  // else
  //   begin
  //     WizardSelectTasks('!toolkit, !dromedhw');
  //     WizardForm.TasksList.ItemEnabled[3] := False;
  //     WizardForm.TasksList.ItemEnabled[4] := False;
  //   end
end;


procedure TasksClickCheck(Sender: TObject);
begin
  UpdateTasksList();
end;


procedure EditConfigLine(File, TargetLine, NewLine: String);
var
  LineIndex: Integer;
  StringList: TStringList;
  FileName: String;
begin
  FileName := WizardDirValue + '\' + File;
  StringList := TStringList.Create;
  try
    StringList.LoadFromFile(FileName);
    LineIndex := StringList.IndexOf(TargetLine);
    if LineIndex <> -1 then
      StringList[LineIndex] := NewLine
    else
      if StringList.IndexOf(NewLine) = -1 then
        StringList.Insert(StringList.Count, NewLine);
    StringList.SaveToFile(FileName);
  finally
    StringList.Free;
  end;
end;

function GetLineContaining(File, TargetString: String): String;
var
  i: Integer;
  StringList: TStringList;
  FileName: String;
begin
  FileName := WizardDirValue + '\' + File;
  StringList := TStringList.Create;
  try
    StringList.LoadFromFile(FileName);
    Result := '';
    for i:=0 to StringList.Count-1 do
      if Pos(TargetString, StringList[i]) <> 0 then
        begin
          Result := StringList[i];
          break;
        end;
  finally
    StringList.Free;
  end;
end;

procedure PerformTasks();
begin
  // Make sure things work properly with T1
  EditConfigLine('cam.cfg', 'dark1', 'dark1');

  // Fix up install.cfg to use relative paths
  EditConfigLine('install.cfg', GetLineContaining('install.cfg', 'install_path'), 'install_path .\');
  EditConfigLine('install.cfg', GetLineContaining('install.cfg', 'resname_base'), 'resname_base .\RES');
  EditConfigLine('install.cfg', GetLineContaining('install.cfg', 'load_path'), 'load_path .\');
  EditConfigLine('install.cfg', GetLineContaining('install.cfg', 'script_module_path'), 'script_module_path .\');
  EditConfigLine('install.cfg', GetLineContaining('install.cfg', 'movie_path'), 'movie_path .\MOVIES');

  if IsTaskSelected('dromedhw') then
    begin
      EditConfigLine('DromEd.cfg', 'edit_screen_depth 16', ';edit_screen_depth 16');
      EditConfigLine('DromEd.cfg', ';editor_disable_gdi', 'editor_disable_gdi');
      EditConfigLine('DromEd.cfg', ';edit_screen_depth 32', 'edit_screen_depth 32');
    end;

  if IsTaskSelected('newmantle') then
    EditConfigLine('cam_ext.cfg', ';new_mantle', 'new_mantle');
  if IsTaskSelected('fmsel') then
    EditConfigLine('cam_mod.ini', ';fm', 'fm');
  if IsTaskSelected('texfilter') then
    EditConfigLine('cam_ext.cfg', 'tex_filter_mode 16', 'tex_filter_mode 0');
  if IsTaskSelected('windowed') then
    EditConfigLine('cam_ext.cfg', ';force_windowed', 'force_windowed');

  if IsTaskSelected('fpsfix') then
    begin
      EditConfigLine('cam_ext.cfg', 'framerate_cap 100.0', 'framerate_cap 200.0');
      EditConfigLine('cam_ext.cfg', ';phys_freq 60', 'phys_freq 60');
    end;
  if IsTaskSelected('stutterfix') then
    begin
      EditConfigLine('cam_ext.cfg', 'd3d_disp_limit_gpu_frames 1', ';d3d_disp_limit_gpu_frames 1');
      EditConfigLine('cam_ext.cfg', ';d3d_disp_limit_gpu_frames 1 1', 'd3d_disp_limit_gpu_frames 1 1');
    end;
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  if CurPageID = wpSelectTasks then 
    UpdateTasksList();
end;

function NextButtonClick(PageId: Integer): Boolean;
begin
  Result := True;
  if (PageId = wpSelectDir) and not FileExists(ExpandConstant('{app}\thief.exe')) then begin
    MsgBox('A Thief 1 install was not found in the specified directory.  Please select a directory in which the game is installed.', mbError, MB_OK);
    Result := False;
    exit;
  end;
end;

procedure InitializeWizard();
begin
  WizardForm.TasksList.OnClickCheck := @TasksClickCheck;
end;