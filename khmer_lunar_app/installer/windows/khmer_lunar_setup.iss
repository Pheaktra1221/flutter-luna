; ─────────────────────────────────────────────────────────────────────────────
; Khmer Lunar Calendar – Inno Setup 6 installer script
; ─────────────────────────────────────────────────────────────────────────────

#define AppName      "Khmer Lunar Calendar"
#define AppNameKhmer "ប្រតិទិនខ្មែរ"
#define AppVersion   "1.0.0"
#define AppPublisher "Pheaktra1221"
#define AppURL       "https://github.com/Pheaktra1221/flutter-luna"
#define AppExeName   "khmer_lunar_app.exe"
#define SourceDir    "..\..\build\windows\x64\runner\Release"
#define OutputDir    "..\..\dist\windows"

[Setup]
AppId={{A3F7D2B1-1234-4567-89AB-CDEF01234567}}
AppName={#AppName}
AppVersion={#AppVersion}
AppPublisher={#AppPublisher}
AppPublisherURL={#AppURL}
AppSupportURL={#AppURL}
AppUpdatesURL={#AppURL}/releases
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
MinVersion=10.0.17763

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Create a &desktop shortcut"; GroupDescription: "Additional icons:"; Flags: checkedonce

[Files]
Source: "{#SourceDir}\{#AppExeName}";     DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceDir}\flutter_windows.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceDir}\data\*";            DestDir: "{app}\data"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\{#AppName}";           Filename: "{app}\{#AppExeName}"; Comment: "{#AppNameKhmer}"
Name: "{group}\Check for Updates";    Filename: "{app}\{#AppExeName}"; Parameters: "--check-update"; Comment: "Check for new version"
Name: "{group}\Uninstall {#AppName}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#AppName}";     Filename: "{app}\{#AppExeName}"; Tasks: desktopicon; Comment: "{#AppNameKhmer}"

[Run]
; Launch app after install
Filename: "{app}\{#AppExeName}"; Description: "Launch {#AppName}"; Flags: nowait postinstall skipifsilent

; Open GitHub releases page for updates (shown as checkbox at end of install)
Filename: "https://github.com/Pheaktra1221/flutter-luna/releases"; \
  Description: "Check for updates on GitHub"; Flags: postinstall shellexec skipifsilent unchecked

[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[Code]
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssDone then
  begin
    MsgBox('ប្រតិទិនខ្មែរ ត្រូវបានដំឡើងដោយជោគជ័យ!' + #13#10 +
           'Khmer Lunar Calendar installed successfully!' + #13#10#13#10 +
           'To update: visit ' + '{#AppURL}' + '/releases',
           mbInformation, MB_OK);
  end;
end;
