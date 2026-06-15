; ─────────────────────────────────────────────────────────────────────────────
; Khmer Lunar Calendar – Inno Setup 6
; Modes: Fresh Install | Update/Repair | Uninstall
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
MinVersion=10.0.17763
; Allow running even if already installed (enables Update/Repair mode)
AllowNoIcons=no

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Create a &desktop shortcut"; GroupDescription: "Additional icons:"; Flags: checkedonce

[Files]
Source: "{#SourceDir}\{#AppExeName}";      DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceDir}\flutter_windows.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceDir}\data\*";             DestDir: "{app}\data"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\{#AppName}";           Filename: "{app}\{#AppExeName}"; Comment: "{#AppNameKhmer}"
Name: "{group}\Uninstall {#AppName}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#AppName}";     Filename: "{app}\{#AppExeName}"; Tasks: desktopicon; Comment: "{#AppNameKhmer}"

[Run]
Filename: "{app}\{#AppExeName}"; Description: "Launch {#AppName}"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[Code]

// ── Detect if already installed ───────────────────────────────────────────────
function IsAlreadyInstalled: Boolean;
var
  ExePath: String;
begin
  ExePath := ExpandConstant('{autopf}\{#AppName}\{#AppExeName}');
  Result := FileExists(ExePath);
end;

// ── Show mode selection dialog before wizard ─────────────────────────────────
var
  ModePage: TInputOptionWizardPage;

procedure InitializeWizard;
begin
  ModePage := CreateInputOptionPage(wpWelcome,
    'ជ្រើសរើសប្រតិបត្តិការ  (Choose Operation)',
    'សូមជ្រើសរើសអ្វីដែលអ្នកចង់ធ្វើ  (Select what you want to do)',
    '',
    True, False);

  if IsAlreadyInstalled then
  begin
    ModePage.Add('ដំឡើងឡើងវិញ / ជួសជុល  (Update / Repair)');
    ModePage.Add('លុបចោល  (Uninstall)');
    ModePage.Add('ផ្លាស់ប្តូរទីតាំង  (Change install folder)');
    ModePage.Values[0] := True;
  end
  else
  begin
    ModePage.Add('ដំឡើងថ្មី  (Fresh Install)');
    ModePage.Values[0] := True;
  end;
end;

// ── Act on selection ──────────────────────────────────────────────────────────
function NextButtonClick(CurPageID: Integer): Boolean;
var
  UninstPath: String;
  ResultCode: Integer;
begin
  Result := True;

  if CurPageID = ModePage.ID then
  begin
    if IsAlreadyInstalled then
    begin
      if ModePage.Values[1] then
      begin
        // ── Uninstall mode ───────────────────────────────────────────────────
        UninstPath := ExpandConstant('{autopf}\{#AppName}\unins000.exe');
        if FileExists(UninstPath) then
        begin
          if MsgBox('ចង់លុបចោលកម្មវិធីមែនទេ?' + #13#10 + 'Uninstall Khmer Lunar Calendar?',
              mbConfirmation, MB_YESNO) = IDYES then
          begin
            Exec(UninstPath, '/SILENT', '', SW_SHOW, ewWaitUntilTerminated, ResultCode);
          end;
        end
        else
          MsgBox('រកមិនឃើញ uninstaller' + #13#10 + 'Uninstaller not found at: ' + UninstPath, mbError, MB_OK);
        Result := False; // stop wizard
        WizardForm.Close;
      end
      else if ModePage.Values[2] then
      begin
        // ── Change folder: proceed normally – user picks folder in next step ─
        WizardForm.DirEdit.Text := ExpandConstant('{autopf}\{#AppName}');
      end;
      // Values[0] = Update/Repair: proceed normally (files overwrite existing)
    end;
    // Fresh install: proceed normally
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssDone then
  begin
    MsgBox('ប្រតិទិនខ្មែរ ត្រូវបានដំឡើង/ធ្វើបច្ចុប្បន្នភាពដោយជោគជ័យ!' + #13#10 +
           'Khmer Lunar Calendar installed/updated successfully!',
           mbInformation, MB_OK);
  end;
end;
