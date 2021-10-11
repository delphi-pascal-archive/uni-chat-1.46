{
UniChat - chat for LANs.
GlobalConst.pas - Global chat constants module.

$Author(s): Dentall, Dr. Evil
$Last revision: 11/06/2005

All rights reserved.
Do not use source in shareware projects.
(c) 2003-2005 GlumClub team
}

unit GlobalConst;

interface
uses Graphics, Classes, Windows, UCPlugin, DynaStackProtect;
// Constants for POWERBROADCAST
const
  PBT_APMQUERYSUSPEND = $0000;
  PBT_APMQUERYSTANDBY = $0001;

  PBT_APMQUERYSUSPENDFAILED = $0002;
  PBT_APMQUERYSTANDBYFAILED = $0003;

  PBT_APMSUSPEND = $0004;
  PBT_APMSTANDBY = $0005;

  PBT_APMRESUMECRITICAL = $0006;
  PBT_APMRESUMESUSPEND = $0007;
  PBT_APMRESUMESTANDBY = $0008;

  PBTF_APMRESUMEFROMFAILURE = $00000001;

  PBT_APMBATTERYLOW = $0009;
  PBT_APMPOWERSTATUSCHANGE = $000A;

const
  Smileys: array[0..97] of string[11] =

  {'''''(',
  '''''s',
  ''')',
  ''']',}

  (
    '$|',
    '%7',
    '%8',
    '''''(',
    '''''s',
    ''')',
    ''']',
    '(!)',
    '(%>',
    '(''',
    '(..',
    '(:',
    '(?)',
    '(O)',
    '(S)',
    '(o)',
    ')''''',
    '8''(',
    '8)',
    '8*',
    '8@',
    '8S',
    '8X',
    '8|',
    ':''(',
    ':(',
    ':)',
    ':*',
    ':/',
    ':8(',
    ':8)',
    ':8*',
    ':D',
    ':P',
    ':T',
    ':[',
    ':]',
    ':ambiguity:',
    ':angel:',
    ':barbar:',
    ':bath:',
    ':bigears:',
    ':birth:',
    ':bottle:',
    ':candle:',
    ':censored:',
    ':congrat:',
    ':cop:',
    ':corporal:',
    ':curve:',
    ':devil:',
    ':doctor:',
    ':drink:',
    ':duel:',
    ':fingers:',
    ':gi',
    ':headphone:',
    ':horseman:',
    ':indigene:',
    ':j',
    ':kick:',
    ':letsdrink:',
    ':love:',
    ':married:',
    ':muse:',
    ':nu',
    ':pact:',
    ':pirate:',
    ':quarrel:',
    ':sailorman:',
    ':shout:',
    ':skull:',
    ':smoke:',
    ':sniper:',
    ':tsar:',
    ':}',
    ';)',
    ';,',
    ';E',
    ';]',
    ';|',
    '<:[',
    '<:\',
    '=>',
    '=D',
    '=o)',
    '>(',
    '>:>',
    '>[',
    'B(',
    'B)',
    'B|',
    'E)',
    'P|',
    'o)',
    'o:|',
    'o:|<',
    '|'''

    );

const
  ConvTable: array[0..97] of byte = (
    53,
    9,
    29,
    43,
    35,
    32,
    52,
    26,
    49,
    28,
    36,
    38,
    27,
    48,
    46,
    47,
    42,
    14,
    8,
    21,
    12,
    30,
    39,
    57,
    15,
    2,
    0,
    25,
    19,
    23,
    22,
    24,
    3,
    7,
    20,
    58,
    55,
    76,
    63,
    79,
    65,
    93,
    82,
    80,
    74,
    94,
    73,
    83,
    91,
    89,
    87,
    88,
    64,
    66,
    69,
    4,
    90,
    68,
    92,
    54,
    97,
    75,
    84,
    67,
    77,
    13,
    78,
    70,
    71,
    86,
    96,
    95,
    85,
    81,
    72,
    62,
    1,
    61,
    31,
    51,
    60,
    16,
    33,
    45,
    11,
    10,
    18,
    40,
    17,
    6,
    5,
    37,
    44,
    50,
    59,
    56,
    41,
    34
    );

const
  ChatID = 'UniChat!_ver14';

  sRegPath = 'Software\UniChat145';
  
  //ChatIDlen = 14;

type
  TSounds = (tsEnter,
    tsLeave,
    tsLine,
    tsNick,
    tsSignal,
    tsTopic,
    tsPrivateEnter,
    tsPrivateLeave,
    tsChannelEnter,
    tsChannelLeave,
    tsMessage,
    tsMassMessage,
    tsMeLine);

type
  TBalloons = (bsEnterExitMain,
    bsEnterExitChannel,
    bsEnterExitMainPrivate,
    bsNickChange,
    bsBoardChange,
    bsModeChange,
    bsMessage,
    bsSignal,
    bsInfo,
    bsPacketFiltered,
    bsMessageReceived,
    bsTreatment);

type
  TUniChatMsg = record
    DateTime: TDateTime;
    CRC32: LongWord;
    MsgType: byte;
    isOut: Byte;
    len: Word;
    FromLen: Word;
    toLen: Word;
    DHashValue: integer;
  end;

var
  shtdwn: boolean;
  MsgData: TStrings;
  txtHist: TStrings;
  txtPos: integer;
  //  txtTopic: string;
    //  edTopic: TEdit;
  lastuser: string;
  lastString: integer;
  CurID: string;

  //============Common Variables
  //Curren variables
  CurNick: string; // Current Nick
  CurMode: char; // Current Mode
  CurSex: char; // Current Gender
  CurActive: char; // Current chat state {In chat window or not}
  cbItem: integer; // Current item in combobox

  // Anti-flood protection

  FloodScore: integer = 999;
//  ShowNickLength: integer = 32;
  SoundScore: integer;
  Phrases: integer;
  RoomsCreated: integer;
//  lastme: boolean;
  noAskClose: boolean;

  //CrossFlood: boolean = False;
  //EntrophyFlood: boolean = False;

  // Fade Effects
//  isFadeEnabled: boolean;

  // Secret userlocking
  UserLocked: Boolean;

  // Anti packet repeating
  LastKey: integer;

  //Sounds
  SndEnabled: Boolean;
  SndEnter: Boolean;
  SndLeave: Boolean;
  SndEnterChannel: Boolean;
  SndLeaveChannel: Boolean;
  SndEnterPrivate: Boolean;
  SndLeavePrivate: Boolean;
  SndLine: Boolean;
  SndMeLine: Boolean;
  SndMessage: Boolean;
  SndMultiMsg: Boolean;
  SndTopic: Boolean;
  SndNickChange: Boolean;
  SndSignal: Boolean;
  //SndTopic: Boolean;

  //Ballons
  BOnlyInactive: Boolean;
  BEnterExitMain: Boolean;
  BEnterExitChannel: Boolean;
  BEnterExitPrivate: Boolean;
  BNickChange: Boolean;
  BBoardChange: Boolean;
  BModeChange: Boolean;
  BMessage: Boolean;
  BSignal: Boolean;
  BInfo: Boolean;
  BMessageReceived: boolean;
  BTalkTreating: boolean;


  //System messages
  SysEnterExitMain: Boolean;
  SysEnterExitChannel: Boolean;
  SysEnterExitPrivate: Boolean;
  SysNickChange: Boolean;
  SysBoardChange: Boolean;
  SysTopicChange: Boolean;
  SysModeChange: Boolean;
  SysMessage: Boolean;
  SysSignal: Boolean;

  //Radio boxes
  CrbLogin: Boolean;
  CrbLast: Boolean;
  CcbAutogender: Boolean;

  //TimeStamp mode
  isSeconds: Boolean;

  //Network Connection
  isServer: boolean;
  isServer_: boolean;
  BroadcastIP: string;
  DedicatedIP: string;
  Port: string;
  portDedic: integer;
  Auto2Broad: boolean;

  //User Information
  UserNfo: string;
  AutoAway: Boolean = False;

  hlib: Thandle;
  GetLastInputInfoSELF: function (var plii: TLastInputInfo): BOOL; stdcall;


  //Hokey
//  GhotKey: TShortCut;
//  GDisableSL: TShortCut;

  //
  LogDir: string;

  // Mode Defaults
  mdActive: string;
  mdDND: string;
  mdOffline: string;
  mdGaming: string;
  mdAway: string;

  // Rooms options
  DefaultRoom: string;
  ShowMyRooms: boolean;
  NotifyNewRoom: boolean;

  // Security
  GroupKey: string;
  isProtectEnabled: boolean;
  MaxPackets: integer;
  NotifyBaloon: boolean;

  // Filters
  Name_Room: TStrings;
  Name_Private: TStrings;
  Name_Msg: TStrings;

  IP_Room: TStrings;
  IP_Private: TStrings;
  IP_Msg: TStrings;

  AutoPrivate: string;
  AutoMessage: string;

  MassMsg: boolean;

  // Board Routines
  BoardNick: TStrings;
  BoardData: TStrings;
  myBoard: string;

  // Priveledge prefix

  priv_prefix: string;

  // Unique page identefier
  pages_cnt: integer;

  // Max Lines Count
  chat_maxlines: integer;

  // Smile state
  smilestate: boolean;

  // Additional Notifications

  DontNotifyTab: boolean;
  DontNotifyTray: boolean;
  DontShowTalk: boolean;
  ForceMsgInOffline: boolean;
  NotifyInOffline: boolean;
  NotifyUserTyping: boolean;
  FlashTasbarOnText: boolean;

  ShowErrorMessage: Boolean = True;

  DoublesNick: string;


resourcestring
SERVICE_PACK = '';
//uum = 'Обновление UniChat';



const
  MemFileSize = 127;
  MemFileName = '!UniChat_v14!!';
  AwayMessage = 'Авторежим: %d мин. тайм-аут';
  adminpackID: string  = '';


var
  MemHnd: HWND;

  // De-truncating server routines
  datatrunc: string;
  datatrunclen: integer;

  // For ichat-server

  PacketPart:  array[1..65384] of char;
  PacketParted: boolean;
  PacketPartLen: integer;



  // Stuff
  UCPlugins: TUniChatPlugins;
  AntiFloodPacket: TStackProtect;





implementation
{$R SMILEPACK2.RES}
//{$R SOUNDPACK.RES}

end.

