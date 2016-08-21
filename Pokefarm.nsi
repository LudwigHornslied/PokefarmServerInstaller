; �ν��緯 �⺻ ���� ����
!define MUI_ICON "pokefarmic.ico"
!define COLOR_WINDOW 5
!define MUI_TEXT_INSTALLING_TITLE "��� ��ġ��"
!define MUI_TEXT_INSTALLING_SUBTITLE "������ ��ġ�ϰ� �ֽ��ϴ�."
BrandingText "Made by Ludwig_H" ; �ϴ� �귣�� �ؽ�Ʈ ����
SetFont ������� 10 ; ��ġ�� �⺻ ��Ʈ�� �������, 10pt�� ����
AutoCloseWindow false ; ��ġ �Ϸ� �� �ڵ����� ������ �ѱ�
Caption "������ ���� ��� ����ġ��" ; ��ġ���� Ÿ��Ʋ ����
OutFile "PokefarmSv.exe" ; �����Ͻ� ������ ���� �̸� ����
InstallDir "$APPDATA\.minecraft" ; ���� ��� INSTDIR�� ��� ����
ShowInstDetails show ; ��ġ ���������� ���λ��� ǥ��
SetCompressor zlib ; ���� �˰����� zlib���� ����
RequestExecutionLevel user

; ��� ����
!include "MUI.nsh"
!include "HornsliedLibrary.nsh"
!include "nsDialogs.nsh"
!include "InstModule.nsh"

; ���� ����
Var 'pokeFarmImg'
Var 'pokeFarmMods'
Var 'lootHg'
Var 'lootHg_state'
Var 'reiMinimap'
Var 'reiMinimap_state'
Var 'craftGuide'
Var 'craftGuide_state'
Var 'resetMods'
Var 'resetMods_state'
Var 'backupMods'
Var 'backupMods_state'

; �Լ�
Function init
Aero::apply
!insertmacro checkInternet "http://hornslied.tistory.com/attachment/cfile2.uf@2231A2395710F687033C0D.txt"
!insertmacro librariesCheck "1.7.10"
SetOverwrite ifnewer
InitPluginsDir
SetOutPath $PLUGINSDIR
File "pokefarmImg.bmp"
FunctionEnd

Function installOption
!insertmacro MUI_HEADER_TEXT "��ġ �ɼ�" "���Ͻô� �׸��� ������ �ֽʽÿ�."
nsDialogs::Create 1018
${NSD_CreateGroupBox} 0 0 360 130 "���"
${NSD_CreateCheckBox} 20 40 140 20 "������ ���� �����"
Pop $pokeFarmMods
${NSD_Check} $pokeFarmMods
EnableWindow $pokeFarmMods 0
${NSD_CreateCheckBox} 20 80 140 20 "��Ʈ �ѱ�ä��"
Pop $lootHg
${NSD_Check} $lootHg
${NSD_CreateCheckBox} 200 40 140 20 "Rei's minimap"
Pop $reiMinimap
${NSD_Check} $reiMinimap
${NSD_CreateCheckBox} 200 80 140 20 "���� ���̵�"
Pop $craftGuide
${NSD_Check} $craftGuide
${NSD_CreateGroupBox} 370 0 230 130 "�ɼ�"
${NSD_CreateCheckBox} 390 40 140 20 "��� �ʱ�ȭ"
Pop $resetMods
${NSD_CreateCheckBox} 390 80 140 20 "��� ���"
Pop $backupMods
${NSD_CreateBitmap} 0 140 600 123 ""
Pop $pokeFarmImg
${NSD_SetStretchedImage} $pokeFarmImg "$PLUGINSDIR\pokefarmImg.bmp" $0
${NSD_OnClick} $pokeFarmImg pokeFarmCafe
nsDialogs::show
FunctionEnd

Function installOptionLeave
${NSD_GetState} $lootHg $lootHg_state
${NSD_GetState} $reiMinimap $reiMinimap_state
${NSD_GetState} $craftGuide $craftGuide_state
${NSD_GetState} $resetMods $resetMods_state
${NSD_GetState} $backupMods $backupMods_state
FunctionEnd

Function pokeFarmCafe
ExecShell "open" "http://cafe.naver.com/mypokefarm/"
FunctionEnd

Function .onGUIEnd
Delete "$PLUGINSDIR\*"
Delete "$TEMP\*"
RMDir /r "$PLUGINSDIR"
RMDir /r "$TEMP"
MessageBox MB_OK "��ó �����ʿ��� ������ 1.7.10 Hornslied�� �ٲٰ� �����Ͻʽÿ�."
FunctionEnd

!define MUI_CUSTOMFUNCTION_GUIINIT init

Page custom installOption installOptionLeave
!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_LANGUAGE "Korean" ; ��ġ�� �⺻ �� �ѱ���� ����

Section "Mods" SEC01
!insertmacro mcProcessCheck
SetOverwrite ifnewer
SetOutPath $PLUGINSDIR
${if} $backupMods_state == 1
!insertmacro modBackup
${endif}
${if} $resetMods_state == 1
!insertmacro modReset
${endif}
!insertmacro forgeInst "1.7.10"
!insertmacro pixelmonInst "1.7.10"
!insertmacro customNpcInst "1.7.10"
!insertmacro backpackInst "1.7.10"
!insertmacro forgeMtPtInst "1.7.10"
!insertmacro smartMovInst "1.7.10"
${if} $lootHg_state == 1
!insertmacro lootHgInst "1.7.10"
${endif}
${if} $reiMinimap_state == 1
!insertmacro reiMinimapInst "1.7.10"
${endif}
${if} $craftGuide_state == 1
!insertmacro craftGuideInst "1.7.10"
${endif}
SectionEnd