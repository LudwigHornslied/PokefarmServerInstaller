; 인스톨러 기본 정보 설정
!define MUI_ICON "pokefarmic.ico"
!define COLOR_WINDOW 5
!define MUI_TEXT_INSTALLING_TITLE "모드 설치중"
!define MUI_TEXT_INSTALLING_SUBTITLE "모드들을 설치하고 있습니다."
BrandingText "Made by Ludwig_H" ; 하단 브랜딩 텍스트 지정
SetFont 나눔고딕 10 ; 설치기 기본 폰트를 나눔고딕, 10pt로 지정
AutoCloseWindow false ; 설치 완료 후 자동으로 페이지 넘김
Caption "포켓팜 서버 모드 간편설치기" ; 설치파일 타이틀 지정
OutFile "PokefarmSv.exe" ; 컴파일시 나오는 파일 이름 지정
InstallDir "$APPDATA\.minecraft" ; 변수 경로 INSTDIR의 경로 지정
ShowInstDetails show ; 설치 페이지에서 세부사항 표시
SetCompressor zlib ; 압축 알고리즘을 zlib으로 설정
RequestExecutionLevel user

; 헤더 파일
!include "MUI.nsh"
!include "HornsliedLibrary.nsh"
!include "nsDialogs.nsh"
!include "InstModule.nsh"

; 변수 선언
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

; 함수
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
!insertmacro MUI_HEADER_TEXT "설치 옵션" "원하시는 항목을 선택해 주십시오."
nsDialogs::Create 1018
${NSD_CreateGroupBox} 0 0 360 130 "모드"
${NSD_CreateCheckBox} 20 40 140 20 "포켓팜 서버 모드팩"
Pop $pokeFarmMods
${NSD_Check} $pokeFarmMods
EnableWindow $pokeFarmMods 0
${NSD_CreateCheckBox} 20 80 140 20 "룻트 한글채팅"
Pop $lootHg
${NSD_Check} $lootHg
${NSD_CreateCheckBox} 200 40 140 20 "Rei's minimap"
Pop $reiMinimap
${NSD_Check} $reiMinimap
${NSD_CreateCheckBox} 200 80 140 20 "조합 가이드"
Pop $craftGuide
${NSD_Check} $craftGuide
${NSD_CreateGroupBox} 370 0 230 130 "옵션"
${NSD_CreateCheckBox} 390 40 140 20 "모드 초기화"
Pop $resetMods
${NSD_CreateCheckBox} 390 80 140 20 "모드 백업"
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
MessageBox MB_OK "런처 프로필에서 버전을 1.7.10 Hornslied로 바꾸고 실행하십시오."
FunctionEnd

!define MUI_CUSTOMFUNCTION_GUIINIT init

Page custom installOption installOptionLeave
!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_LANGUAGE "Korean" ; 설치기 기본 언어를 한국어로 지정

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