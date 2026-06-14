; ─────────────────────────────────────────────────────────────────────────────
; Khmer Lunar Calendar – Inno Setup 6 installer script
; ─────────────────────────────────────────────────────────────────────────────

#define AppName      "Khmer Lunar Calendar"
#define AppNameKhmer "ប្រតិទិនខ្មែរ"
#define AppVersion   "1.0.0"
#define AppPublisher "Khmer Lunar App"
#define AppExeName   "khmer_lunar_app.exe"
#define SourceDir    "..\..\build\windows\x64\runner\Release"
#define OutputDir    "..\..\dist\windows"

[Setup]
AppId={{A3F7D2B1-1234-4567-89AB-CDEF01234567}}
AppName={#AppName}
AppVersion={#AppVersion}
AppPublisherURL=https://github.com
AppSupportURL=https://github.com
VersionInfoVersion={#AppVersion}
DefaultDirName={autopf}\{#AppName}
DefaultGroupName={#AppName}
OutputDir={#OutputDir}
OutputBaseFilename=KhmerLunarCalendar-{#AppVersion}-Setup
Compression=lzma2/ultra64
SolidCompression=yes
WizardStyle=modern
WizardSizePercent=120
DisableProgramGroupPage=yes
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog
SetupIconFile=..\..\windows\runner\resources\app_icon.ico
UninstallDisplayIcon={app}\{#AppExeName}
UninstallDisplayName={#AppName}
ChangesAssociations=no
; Minimum Windows 10
MinVersion=10.0.17763

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Create a &desktop shortcut"; GroupDescription: "Additional icons:"; Flags: checkedonce

[Files]
; Main executable
Source: "{#SourceDir}\{#AppExeName}"; DestDir: "{app}"; Flags: ignoreversion

; Flutter Windows DLL
Source: "{#SourceDir}\flutter_windows.dll"; DestDir: "{app}"; Flags: ignoreversion

; App data folder (assets, fonts, etc.)
Source: "{#SourceDir}\data\*"; DestDir: "{app}\data"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
; Start Menu
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppExeName}"; Comment: "{#AppNameKhmer}"
Name: "{group}\Uninstall {#AppName}"; Filename: "{uninstallexe}"

; Desktop shortcut (optional, based on task above)
Name: "{autodesktop}\{#AppName}"; Filename: "{app}\{#AppExeName}"; Tasks: desktopicon; Comment: "{#AppNameKhmer}"

[Run]
; Launch after install
Filename: "{app}\{#AppExeName}"; Description: "Launch {#AppName}"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[Code]
// Show a friendly finish message
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssDone then
  begin
    MsgBox('ប្រតិទិនខ្មែរ ត្រូវបានដំឡើងដោយជោគជ័យ!' + #13#10 +
           'Khmer Lunar Calendar installed successfully!', mbInformation, MB_OK);
  end;
end;
